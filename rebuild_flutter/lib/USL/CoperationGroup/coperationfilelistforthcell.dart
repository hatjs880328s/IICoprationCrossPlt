import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rebuild_flutter/BLL/AppBll/nsnormalconfig.dart';
import 'package:rebuild_flutter/MODEL/CoperationGroup/coperationgroupmodel.dart';
import 'package:rebuild_flutter/MODEL/Newfile/realgitfilemodel.dart';
import 'package:rebuild_flutter/USL/CreateFile/updateFile.dart';

/// 文章列表
class CoperationFileListForthCell extends StatelessWidget {

  List<RealGitFileModel> lists;

  CoperationGroupModel oldModel;

  CoperationFileListForthCell(CoperationGroupModel oldModel) {
    this.oldModel = oldModel;
    this.lists = oldModel.files;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(8, 10, 8, 0), 
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 0.5, color: Colors.grey),
          borderRadius: BorderRadius.circular(4),
        ),
        padding: EdgeInsets.fromLTRB(8, 10, 8, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(4, 8, 4, 4),
              child: Row(
                children: <Widget>[
                  Image(
                    image: AssetImage('images/coperation_detail_edit.png'),
                    height: 25,
                    width: 25,
                  ),
                  Text(
                    '  协同组文章',
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
            ),
            Column(children: createVws(context)),
          ],
        ))
    );
  }

  List<Widget> createVws(BuildContext context) {
    List<Widget> result = [];
    for (int i = 0; i < this.lists.length; i++) {
      var ss = Container(
          margin: EdgeInsets.fromLTRB(6, 4, 6, 4),
          padding: EdgeInsets.fromLTRB(6, 10, 6, 10),
          decoration: BoxDecoration(
              color: NSNormalConfig.listCellBgColor,
              borderRadius: BorderRadius.circular(6)),
          child: GestureDetector(
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // LINE 1
              Row(
                children: <Widget>[
                  Container(
                    child: Text(this.lists[i].name,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          letterSpacing: 1.5)),
                    width: MediaQuery.of(context).size.width - 110,
                  ),
                  // 目前没有指定操作
                  // Container(
                  //   margin: EdgeInsets.only(left: 15),
                  //   child: Text(
                  //     '置顶',
                  //     style: TextStyle(color: Colors.grey, fontSize: 14),
                  //     textAlign: TextAlign.end,
                  //   ),
                  // )
                ],
              ),
              // LINE 2
              Container(
                padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                child: Text(
                  this.lists[i].description.replaceAll("\n", ""),
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.black87, fontSize: 15, height: 1.7),
                ),
              ),
              // LINE 3
              Row(
                children: <Widget>[
                  RichText(
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(
                          text: "Noah_shan",
                          style: TextStyle(color: Colors.black, fontSize: 16)),
                      TextSpan(
                          text: "   2019-10-15 12:09",
                          style: TextStyle(color: Colors.grey, fontSize: 16)),
                    ]),
                  )
                ],
              )
            ],
          ),
          onTap: () {
            this.jump2EditorPage(context, i);
          },
          )
          );
      result.add(ss);
    }
    return result;
  }

  /// 跳转到编辑页面
  Future jump2EditorPage(BuildContext context, int idx) async {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      var page = UpdateFile(this.oldModel, this.lists[idx], false);
      return page;
    }));
  }
}
