import 'package:flutter/material.dart';

class CounterProvider extends ChangeNotifier {
  int number;

  CounterProvider({this.number = 0});

  void incrementNumber() {
    number++;
    notifyListeners();
  }

  void decrementNumber() {
    if (number > 0) number--;
    notifyListeners();
  }
}
