import 'package:flutter/material.dart';

class SpeedDialProvider with ChangeNotifier {
  bool _isDialOpen = false;

  bool get isDialOpen => _isDialOpen;

  void toggleDial() {
    _isDialOpen = !_isDialOpen;
    notifyListeners();
  }
}