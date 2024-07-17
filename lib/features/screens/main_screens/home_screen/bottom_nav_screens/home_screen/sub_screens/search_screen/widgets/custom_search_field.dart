import 'package:flutter/material.dart';
import 'package:practical_pachprthlo/config/constants/colors.dart';
import 'package:practical_pachprthlo/config/localization/l10n.dart';
import 'package:practical_pachprthlo/utils/my_media_query.dart';

class CustomSearchField extends StatelessWidget {
  const CustomSearchField({
    super.key,
    required this.searchFocusNode,
    required this.searchController,
    required this.searchTerm,
    required this.dropDownList,
  });

  final FocusNode searchFocusNode;
  final TextEditingController searchController;
  final ValueNotifier<String> searchTerm;
  final List<String> dropDownList;

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: searchFocusNode,
      controller: searchController,
      decoration: InputDecoration(
        hintText: AppLocalizations.of(context)!.searchByCategoriesText,
        hintStyle: Theme.of(context).textTheme.titleSmall!.copyWith(color: kWhiteColor),
        filled: true,
        fillColor: kWhiteColor.withOpacity(0.3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        suffixIcon: PopupMenuButton(
          itemBuilder: (BuildContext context) {
            dropDownList.sort();
            return [
              ...List.generate(
                dropDownList.length,
                (index) => PopupMenuItem(
                  value: dropDownList[index],
                  child: Text(dropDownList[index]),
                ),
              )
            ];
          },
          onOpened: () {
            searchFocusNode.unfocus();
          },
          onSelected: (newValue) {
            searchTerm.value = newValue;
            searchController.text = newValue;
          },
          child: Icon(
            Icons.arrow_drop_down_rounded,
            size: getScreenArea(context, 0.00009),
          ),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: getScreenArea(context, 0.000075), vertical: 0),
      ),
      style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kWhiteColor),
      onChanged: (value) {
        searchTerm.value = searchController.text;
      },
    );
  }
}
