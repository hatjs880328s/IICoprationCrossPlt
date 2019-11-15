import 'package:rebuild_flutter/BLL/AppBll/nsnormalconfig.dart';
import 'package:flutter/material.dart';
import 'package:rebuild_flutter/MODEL/CoperationGroup/coperationgroupmodel.dart';
import 'package:rebuild_flutter/MODEL/Newfile/realgitfilemodel.dart';
import 'package:rebuild_flutter/USL/CreateFile/updateFile.dart';

class FileListCell extends StatelessWidget {

  CoperationGroupModel groupModel;

  RealGitFileModel itemmodel;

  FileListCell(CoperationGroupModel groupItem, RealGitFileModel itemmodel) {
    this.groupModel = groupItem;
    this.itemmodel = itemmodel;
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
            child: Text(this.itemmodel.title, style: TextStyle(fontSize: 17, fontFamily: NSNormalConfig.fontFamily)),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
            child: Text(nonEnterSubtitle(), style: TextStyle(fontSize: 14, fontFamily: NSNormalConfig.fontFamily, color: Colors.grey)),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: Text(this.itemmodel.getCreateTime(), style: TextStyle(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.w400, fontFamily: NSNormalConfig.fontFamily)),
          ),
          Divider(height: 1, color: Colors.black12, endIndent: 0),
        ],
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return UpdateFile(this.groupModel, this.itemmodel, true);
        }));
      },
      ),
    );
  }

  /// 去掉结尾的换行
  String nonEnterSubtitle() {
    var result = this.itemmodel.subtitle.replaceAll("\n", "");
    return result;
  }
}