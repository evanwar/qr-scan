import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UIProvider extends ChangeNotifier {
  int _selectOptionMenu = 0;

  int get selectMenuOption {
    return this._selectOptionMenu;
  }

  set selectMenuOption(int index) {
    if (index != _selectOptionMenu) {
      this._selectOptionMenu = index;
      notifyListeners();
    }
  }
}
