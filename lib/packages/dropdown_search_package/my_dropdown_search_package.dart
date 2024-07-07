import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:practical_pachprthlo/config/constants/colors.dart';

class MyDropdownSearchPackage {
  MyDropdownSearchPackage._();

  static DropdownSearch dropDownWithSearchBar(
      {required BuildContext context, required Function(String?) onChanged, required List<String> searchItems, required String placeHolder}) {
    return DropdownSearch<String>(
      popupProps: const PopupProps.menu(
        showSelectedItems: true,
      ),
      items: searchItems,
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          hintText: placeHolder,
          hintStyle: Theme.of(context).textTheme.titleSmall!.copyWith(color: kWhiteColor),
        ),
      ),
      onChanged: onChanged,
    );
  }
}
