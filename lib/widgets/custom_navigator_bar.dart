import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/ui_provider.dart';

class CustomNavigatorBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UIProvider>(context);

    final int currentIndex = 0;
    return BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          provider.selectMenuOption = index;
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.map,
                  color: provider.selectMenuOption == 0
                      ? Theme.of(context).primaryColor
                      : Colors.grey),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.compass_calibration,
                  color: provider.selectMenuOption == 1
                      ? Theme.of(context).primaryColor
                      : Colors.grey),
              label: '')
        ]);
  }
}
