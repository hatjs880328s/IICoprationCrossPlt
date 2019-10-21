import 'dart:wasm';

import 'package:flutter/material.dart';

class FileListCell extends StatelessWidget {

  String title = "";

  String time = "";

  String img = "";

  FileListCell({String img, String title, String time}) {
    this.title = title;
    this.img = img;
    this.time = time;
  }

  /// vw create
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 8, 0, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: Text(time, style: TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w400)),
          ),
          Divider(height: 1, color: Colors.black12, endIndent: 0),
        ],
      ),
    );
  }
}