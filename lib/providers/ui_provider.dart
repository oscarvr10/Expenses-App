import 'package:flutter/material.dart';

class UiProvider extends ChangeNotifier {
  int _bnbIndex = 0;
  int get bnbIndex => _bnbIndex;

  set bnbIndex(int i) {
    _bnbIndex = i;
    notifyListeners();
  }
}
