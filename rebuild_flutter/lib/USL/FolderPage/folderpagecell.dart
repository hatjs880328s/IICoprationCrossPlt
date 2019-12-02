import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rebuild_flutter/BLL/AppBll/nsnormalconfig.dart';
import 'package:rebuild_flutter/MODEL/CoperationGroup/coperationgroupmodel.dart';
import 'package:rebuild_flutter/MODEL/Newfile/foldermodel.dart';

class FolderPageCell extends StatelessWidget {
  FolderModel file;

  dynamic action;

  FolderPageCell(FolderModel file, dynamic action) {
    this.file = file;
    this.action = action;
  }

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
                Image(image: AssetImage("images/main_tab_bookstore.png"), height: 24, width: 24),
                Container(width: 15),
                Text(this.file.name,
                    style: TextStyle(fontSize: 16, color: Colors.black, fontFamily: NSNormalConfig.fontFamily)),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 4, 0, 3),
            child: Row(
              children: <Widget>[
                Text(this.file.getCreateTime(),
                    style: TextStyle(fontSize: 13, color: Colors.grey, fontFamily: NSNormalConfig.fontFamily),
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
