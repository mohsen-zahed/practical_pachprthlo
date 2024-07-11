import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practical_pachprthlo/config/localization/l10n.dart';
import 'package:practical_pachprthlo/features/blocs/language_bloc/localization_bloc.dart';
import 'package:practical_pachprthlo/features/data/models/disease_response_model/disease_response_model.dart';
import 'package:practical_pachprthlo/features/providers/categories_provider.dart';
import 'package:practical_pachprthlo/features/screens/main_screens/home_screen/bottom_nav_screens/home_screen/sub_screens/search_screen/widgets/custom_search_field.dart';
import 'package:practical_pachprthlo/features/screens/main_screens/home_screen/bottom_nav_screens/home_screen/widgets/single_disease_card_widget.dart';
import 'package:practical_pachprthlo/packages/dropdown_search_package/my_dropdown_search_package.dart';
import 'package:practical_pachprthlo/utils/my_media_query.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, required this.diseaseList});
  final List<DiseaseModel> diseaseList;
  static const String id = '/search_screen';

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final ValueNotifier<String> searchTerm = ValueNotifier<String>('');
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();
  bool isProSearchModelActive = false;

  @override
  void initState() {
    super.initState();
    searchFocusNode.requestFocus();
  }

  @override
  void dispose() {
    super.dispose();
    searchTerm.dispose();
    searchController.dispose();
    searchFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            isProSearchModelActive = !isProSearchModelActive;
          });
        },
        label: Row(
          children: [
            Text(isProSearchModelActive ? AppLocalizations.of(context)!.searchSimpleText : AppLocalizations.of(context)!.searchProText),
            SizedBox(width: getScreenArea(context, 0.000005)),
            BlocBuilder<LocalizationBloc, LocalizationState>(
              builder: (context, state) {
                return Icon(
                    state.selectedLanguage.locale == const Locale('fa') ? Icons.keyboard_arrow_left_rounded : Icons.keyboard_arrow_right_rounded,
                    size: getScreenArea(context, 0.00006));
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Expanded(
              child: isProSearchModelActive
                  ? MyDropdownSearchPackage.dropDownWithSearchBar(
                      placeHolder: AppLocalizations.of(context)!.searchByCategoriesText,
                      context: context,
                      onChanged: (value) {
                        searchTerm.value = value!;
                      },
                      searchItems: Provider.of<CategoriesProvider>(context).searchCategoriesList,
                    )
                  : CustomSearchField(
                      searchFocusNode: searchFocusNode,
                      searchController: searchController,
                      searchTerm: searchTerm,
                    ),
            ),
            SizedBox(width: getScreenArea(context, 0.00003)),
            GestureDetector(
              onTap: () {
                if (searchController.text.isNotEmpty) {
                  searchController.clear();
                  searchTerm.value = '';
                } else {
                  Navigator.pop(context);
                }
              },
              child: const Icon(Icons.clear),
            ),
          ],
        ),
      ),
      body: ValueListenableBuilder<String>(
        valueListenable: searchTerm,
        builder: (context, value, child) {
          List<DiseaseModel> searchedList = [];
          List<DiseaseModel> list = widget.diseaseList;
          if (value.isNotEmpty) {
            searchedList = list.where((element) {
              //* Search works according to name and species.
              //* Species is located on the card image as a badge...
              //* The name is an image credit tag on the card image and Expansion Tile's title...
              return element.name.toLowerCase().contains(value.trim().toLowerCase()) ||
                  element.species.toLowerCase().contains(value.trim().toLowerCase()) ||
                  element.origin.toLowerCase().contains(value.trim().toLowerCase()) ||
                  element.location.toLowerCase().contains(value.trim().toLowerCase()) ||
                  element.gender.toLowerCase().contains(value.trim().toLowerCase()) ||
                  element.type.toLowerCase().contains(value.trim().toLowerCase());
            }).toList();
          } else {
            searchedList = list;
          }
          if (searchedList.isEmpty) {
            return Center(
              child: Text(AppLocalizations.of(context)!.noCreaturesFoundText),
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: getScreenArea(context, 0.00005)),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: getScreenArea(context, 0.00008)),
                    child: Text('Results found: ${searchedList.length}'),
                  ),
                ),
                SizedBox(height: getScreenArea(context, 0.00003)),
                Container(
                  height: getScreenArea(context, 0.00001),
                  color: Colors.grey.shade300,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: searchedList.length,
                    itemBuilder: (context, index) {
                      return SingleDiseaseCardWidget(diseaseModel: searchedList[index], index: index);
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
