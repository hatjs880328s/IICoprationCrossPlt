import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rebuild_flutter/BLL/AppBll/nsnormalconfig.dart';
import 'package:rebuild_flutter/MODEL/Login/nsloginmodel.dart';

/// 协同组成员cell
class CoperationFileListCell extends StatelessWidget {

  CoperationFileListCell(List<NSLoginModel> users) {
    this.lists = users;
  }

  List<NSLoginModel> lists = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(8, 2, 8, 0),
      color: Colors.white,
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
              Image(image: AssetImage('images/main_tab_person.png'), height: 25, width: 25,),
              Text('  协同组成员', style: TextStyle(fontSize: 16),)
            ],
          ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(4, 4, 4, 8),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: this.getTexts(),
            )
          ),
        ],
      )
    )
    );
  }

  /// 创建所有标签
  List<Widget> getTexts() {
    List<Widget> result = [];
    if (null == this.lists) { return result ;}
    for (int i = 0 ; i < lists.length ; i ++ ) {
      result.add(
        Container(
          decoration: BoxDecoration(
            color: NSNormalConfig.listCellBgColor,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(width: 0.5, color: NSNormalConfig.listCellBgColor),
          ),
          child: Text(
        lists[i].nickname, 
        style: TextStyle(fontSize: 15, color: Colors.black87))),
      );
    }
    return result;
  }
}