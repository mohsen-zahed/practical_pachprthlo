import 'package:flutter/material.dart';
import 'package:practical_pachprthlo/features/data/models/disease_response_model/disease_response_model.dart';
import 'package:practical_pachprthlo/features/screens/main_screens/home_screen/bottom_nav_screens/home_screen/sub_screens/search_screen/widgets/custom_search_field.dart';
import 'package:practical_pachprthlo/features/screens/main_screens/home_screen/bottom_nav_screens/home_screen/widgets/single_disease_card_widget.dart';
import 'package:practical_pachprthlo/packages/dropdown_search_package/my_dropdown_search_package.dart';
import 'package:practical_pachprthlo/utils/my_media_query.dart';

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
        label: Text('change search mode'),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Expanded(
              child: isProSearchModelActive
                  ? MyDropdownSearchPackage.instance.dropDownWithSearchBar()
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
              return element.species.toLowerCase().contains(value.trim().toLowerCase()) ||
                  element.origin.toLowerCase().contains(value.trim().toLowerCase()) ||
                  element.location.toLowerCase().contains(value.trim().toLowerCase()) ||
                  element.gender.toLowerCase().contains(value.trim().toLowerCase()) ||
                  element.type.toLowerCase().contains(value.trim().toLowerCase());
            }).toList();
          } else {
            searchedList = list;
          }
          if (searchedList.isEmpty) {
            return const Center(
              child: Text('No creatures found...'),
            );
          } else {
            return ListView.builder(
              itemCount: searchedList.length,
              itemBuilder: (context, index) {
                return SingleDiseaseCardWidget(diseaseModel: searchedList[index], index: index);
              },
            );
          }
        },
      ),
    );
  }
}
