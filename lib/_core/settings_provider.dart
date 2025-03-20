import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  bool _isUserAuthenticated = false;
  bool get isUserAuthenticated => _isUserAuthenticated;
  set isUserAuthenticated(bool value) {
    _isUserAuthenticated = value;
    notifyListeners();
  }
}
