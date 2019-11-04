import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// 协同组成员cell
class CoperationFileListCell extends StatelessWidget {

  List<String> lists = ['三毛', '张胜男', '秋天的小胖子', '冬天的小裙子', '鲁能泰山', 'halo,world', 'rich text', '三毛', '张胜男', '秋天的小胖子', '冬天的小裙子', '鲁能泰山', 'halo,world', 'rich text'];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 0.5, color: Colors.grey),
        borderRadius: BorderRadius.circular(4),
      ),
      margin: EdgeInsets.fromLTRB(8, 10, 8, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(4, 8, 4, 4),
            child: Row(
            children: <Widget>[
              Image(image: AssetImage('images/main_tab_bookstore.png'), height: 25, width: 25,),
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
    );
  }

  /// 创建所有标签
  List<Widget> getTexts() {
    List<Widget> result = [];
    for (int i = 0 ; i < lists.length ; i ++ ) {
      result.add(
        Container(
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(width: 0.5, color: Colors.grey),
          ),
          child: Text(
        lists[i], 
        style: TextStyle(fontSize: 15, color: Colors.black87))),
      );
    }
    return result;
  }
}