import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rebuild_flutter/BLL/AppBll/nsnormalconfig.dart';
import 'package:rebuild_flutter/MODEL/Newfile/realgitfilemodel.dart';

/// 文章列表
class CoperationFileListForthCell extends StatelessWidget {
  List<RealGitFileModel> lists = [
    RealGitFileModel(
        'ID',
        'Article of the papers,Article of the papers,Article of the papers,Article of the papers,Article of the papers',
        0,
        '???',
        'Article of the papers',
        'Describution of the papers'),
    RealGitFileModel(
        'ID',
        'Article of the papers,Article of the papers,Article of the papers,Article of the papers,Article of the papers',
        0,
        '???',
        'Article of the papers',
        'Describution of the papers'),
    RealGitFileModel(
        'ID',
        'Article of the papers,Article of the papers,Article of the papers,Article of the papers,Article of the papers',
        0,
        '???',
        'Article of the papers',
        'Describution of the papers'),
    RealGitFileModel(
        'ID',
        'Article of the papers,Article of the papers,Article of the papers,Article of the papers,Article of the papers',
        0,
        '???',
        'Article of the papers',
        'Describution of the papers'),
    RealGitFileModel(
        'ID',
        'Article of the papers,Article of the papers,Article of the papers,Article of the papers,Article of the papers',
        0,
        '???',
        'Article of the papers',
        'Describution of the papers'),
    RealGitFileModel(
        'ID',
        'Article of the papers,Article of the papers,Article of the papers,Article of the papers,Article of the papers',
        0,
        '???',
        'Article of the papers',
        'Describution of the papers'),
  ];

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
                    image: AssetImage('images/main_tab_bookstore.png'),
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
          child: Column(
            children: <Widget>[
              // LINE 1
              Row(
                children: <Widget>[
                  Container(
                    child: Text(this.lists[i].title,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          letterSpacing: 1.5)),
                    width: MediaQuery.of(context).size.width - 110,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15),
                    child: Text(
                      '置顶',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                      textAlign: TextAlign.end,
                    ),
                    //decoration: BoxDecoration(),
                  )
                ],
              ),
              // LINE 2
              Container(
                padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                child: Text(
                  this.lists[i].content,
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
          ));
      result.add(ss);
    }

    return result;
  }
}
