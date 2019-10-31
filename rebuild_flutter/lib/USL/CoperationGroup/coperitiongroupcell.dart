import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rebuild_flutter/BLL/AppBll/nsnormalconfig.dart';

class CoperitionGroupCell extends StatelessWidget {
  
  String title = "";

  String time = "";

  dynamic action;

  CoperitionGroupCell(String title, String time, dynamic action) {
    this.time = time;
    this.title = title;
    this.action = action;
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () { action(); },
      child: Container(
      height: 80,
      padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 4),
            child: Row(
              children: <Widget>[
                //Icon(Icons),
                Image(
                  height: 25,
                  width: 25,
                  image: AssetImage("images/main_tab_group.png")
                ),
                Container(width: 15),
                Text(title,
                    style: TextStyle(fontSize: 17, color: Colors.black, fontFamily: NSNormalConfig.fontFamily)),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 4, 0, 3),
            child: Row(
              children: <Widget>[
                Text(time,
                    style: TextStyle(fontSize: 14, color: Colors.grey, fontFamily: NSNormalConfig.fontFamily),
                    textAlign: TextAlign.start),
              ],
            ),
          ),
          Divider(height: 1, color: Colors.black12, endIndent: 0),
        ],
      ),
    ),
    );
  }
  
}