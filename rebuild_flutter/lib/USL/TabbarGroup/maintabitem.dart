import 'package:flutter/material.dart';

typedef MainTabItemTapAction = void Function(int index);

class MainTabItem extends StatelessWidget {
  String title;
  Icon icons;
  MainTabItemTapAction tapaction;
  int idx;

  MainTabItem(
      int idx, String title, Icon icons, MainTabItemTapAction tapaction) {
    this.icons = icons;
    this.title = title;
    this.tapaction = tapaction;
    this.idx = idx;
  }

  dynamic action;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 50,
        height: 54,
        child: GestureDetector(
            onTap: () { tapaction(idx); },
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 4),
                  alignment: Alignment.center,
                  width: 50,
                  height: 25,
                  child: this.icons
                ),
                Container(
                    padding: EdgeInsets.only(top: 4),
                    alignment: Alignment.center,
                    width: 50,
                    height: 22,
                    child: Text(
                      title,
                      style: TextStyle(fontSize: 13),
                      textAlign: TextAlign.center,
                    )),
              ],
            )));
  }
}
