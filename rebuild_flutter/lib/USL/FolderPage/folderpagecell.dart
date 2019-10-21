import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FolderPageCell extends StatelessWidget {
  String title = "";

  String time = "";

  FolderPageCell(String title, String time) {
    this.time = time;
    this.title = title;
  }

  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 4),
            child: Row(
              children: <Widget>[
                Icon(Icons.folder_open),
                Container(width: 15),
                Text(title,
                    style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
            child: Row(
              children: <Widget>[
                Text(time,
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                    textAlign: TextAlign.start),
              ],
            ),
          ),
          Divider(height: 1, color: Colors.black12, endIndent: 0),
        ],
      ),
    );
  }
}
