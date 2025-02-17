import 'package:flutter/material.dart';

abstract class LoadingNotifier extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  openLoading() {
    _isLoading = true;
    notifyListeners();
  }

  closeLoading() {
    _isLoading = false;
    notifyListeners();
  }
}
