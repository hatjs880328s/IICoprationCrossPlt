import 'dart:wasm';
import 'package:path/path.dart';
import 'package:rebuild_flutter/BLL/AppBll/nsnormalconfig.dart';
import 'package:flutter/material.dart';
import 'package:rebuild_flutter/USL/CreateFile/editorpage.dart';
import 'package:rebuild_flutter/USL/DetailPage/detailpage.dart';

class FileListCell extends StatelessWidget {

  String title = "";

  String time = "";

  String img = "";

  String path = "";

  FileListCell({String img, String title, String time, String path}) {
    this.title = title;
    this.img = img;
    this.time = time;
    this.path = path;
  }

  /// vw create
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 8, 0, 8),
      child: GestureDetector(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: Text(title, style: TextStyle(fontSize: 17, fontFamily: NSNormalConfig.fontFamily)),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: Text(time, style: TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w400, fontFamily: NSNormalConfig.fontFamily)),
          ),
          Divider(height: 1, color: Colors.black12, endIndent: 0),
        ],
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return EditorPage(this.path, null, null);
        }));
      },
      ),
    );
  }
}