import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class MyDropdownSearchPackage {
  static MyDropdownSearchPackage? _instance;
  MyDropdownSearchPackage._();
  static MyDropdownSearchPackage get instance {
    _instance ??= MyDropdownSearchPackage._();
    return _instance!;
  }

  DropdownSearch dropDownWithSearchBar() {
    return DropdownSearch<String>(
      popupProps: PopupProps.menu(
        showSelectedItems: true,
        disabledItemFn: (String s) => s.startsWith('I'),
      ),
      items: ["Brazil", "Italia (Disabled)", "Tunisia", 'Canada'],
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          labelText: "Menu mode",
          hintText: "country in menu mode",
        ),
      ),
      onChanged: print,
      selectedItem: "Brazil",
    );
  }
}
