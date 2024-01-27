import 'package:flutter/material.dart';

class TaskNotifier extends ChangeNotifier {
  bool _shouldReload = false;
  String? _pickedDate;

  bool get shouldReload => _shouldReload;
  String? get pickedDate => _pickedDate;

  void setShouldReload(bool value) {
    _shouldReload = value;
    notifyListeners();
  }

  void setPickedDate(String? date) {
    _pickedDate = date;
    notifyListeners();
  }
}
