import 'package:flutter/material.dart';

typedef MainTabItemTapAction = void Function(int index);

class MainTabItem extends StatelessWidget {
  String title;
  String icons;
  MainTabItemTapAction tapaction;
  int idx;
  Color itemcolor;

  MainTabItem(Color backcolor, int idx, String title, String icons, MainTabItemTapAction tapaction) {
    this.icons = icons;
    this.title = title;
    this.tapaction = tapaction;
    this.idx = idx;
    this.itemcolor = backcolor;
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
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        width: 22,
                        height: 22,
                        left: 5,
                        top: 4,
                        child: Container(
                          color: this.itemcolor,
                        )
                      ),
                      Positioned(
                        child: Image(image: AssetImage(icons),),
                      )
                    ],
                  )
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
                    )
                )
              ],
          )
        )
      );
  }
}
