import 'package:flutter/material.dart';

class CategoriesProvider extends ChangeNotifier {
  List<String> searchCategoriesList;

  CategoriesProvider({List<String>? initialList}) : searchCategoriesList = initialList ?? [];

  void addCategory(String category) {
    if (!searchCategoriesList.contains(category)) {
      searchCategoriesList = List.from(searchCategoriesList)..add(category);
    }
    notifyListeners();
  }
}
