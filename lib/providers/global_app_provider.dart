import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GlobalAppProvider extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  void openLoader() {
    _isLoading = true;
    notifyListeners();
  }
  void closeLoader() {
    _isLoading = false;
    notifyListeners();
  }
}
