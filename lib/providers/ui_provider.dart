import 'package:flutter/material.dart';

class UIProvider extends ChangeNotifier {
  int _currentNavBarIndex = 0;

  int get currentNavBarIndex => _currentNavBarIndex;

  set setCurrentNavBarIndex(int value) {
    _currentNavBarIndex = value;
    notifyListeners();
  }

  set setCurrentFromScan(String scanType) {
    _currentNavBarIndex = scanType == 'LOCATION' ? 0 : 1;
    notifyListeners();
  }
}
