import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// 协同组基本信息 cell
class CoperationFileListSecondCell extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 0.5, color: Colors.grey),
        borderRadius: BorderRadius.circular(4),
      ),
      margin: EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(4, 8, 4, 4),
            child: Row(
            children: <Widget>[
              Image(image: AssetImage('images/main_tab_bookstore.png'), height: 25, width: 25,),
              Text('  协同组信息', style: TextStyle(fontSize: 16),)
            ],
          ),
          ),
          Container(
            padding: EdgeInsets.all(4),
            child: RichText(text: TextSpan(
              children: <TextSpan>[
                TextSpan(text: '文章数', style: TextStyle(color: Colors.grey, fontSize: 15)),
                TextSpan(text: '  5', style: TextStyle(fontSize: 16, color: Colors.black)),
              ]
            ),)
          ),
          Container(
            padding: EdgeInsets.all(4),
            child: RichText(text: TextSpan(
              children: <TextSpan>[
                TextSpan(text: '成员数', style: TextStyle(color: Colors.grey, fontSize: 15)),
                TextSpan(text: '  8', style: TextStyle(fontSize: 16, color: Colors.black)),
              ]
            ),)
          ),
          Container(
            padding: EdgeInsets.all(4),
            child: RichText(text: TextSpan(
              children: <TextSpan>[
                TextSpan(text: '最后修改时间', style: TextStyle(color: Colors.grey, fontSize: 15)),
                TextSpan(text: '  2019-8-4 12:28', style: TextStyle(fontSize: 16, color: Colors.black)),
              ]
            ),)
          ),
        ],
      )
    );
  }
}