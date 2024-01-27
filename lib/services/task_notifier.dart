import 'package:flutter/material.dart';

class TaskNotifier extends ChangeNotifier {
  bool _shouldReload = false;

  bool get shouldReload => _shouldReload;

  void setShouldReload(bool value) {
    _shouldReload = value;
    notifyListeners();
  }
}
