import 'package:flutter/material.dart';
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
  ];

  List<String> lists2 = ['三毛', '张胜男', '秋天的小胖子', '冬天的小裙子'];

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
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
                  Image(
                    image: AssetImage('images/main_tab_bookstore.png'),
                    height: 25,
                    width: 25,
                  ),
                  Text(
                    '  协同组文章e',
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
            ),
            ListView.builder(itemCount: this.lists2.length, itemBuilder: (context, idx) {
              return Text('halo$idx');
            },)
          ],
        ));
  }

  // List<Widget> createVws() {
  //   List<Widget> result = [];
  //   for (int i = 0 ; i < this.lists.length ; i++ ) {
  //     var ss = Container(
  //       padding: EdgeInsets.fromLTRB(4, 4, 4, 4),
  //       child: Column(
  //         children: <Widget>[
  //           // LINE 1
  //           Row(
  //             children: <Widget>[
  //               Text(this.lists[i].title, style: TextStyle(color: Colors.black87, fontSize: 16)),
  //               Text('置顶', style: TextStyle(color: Colors.grey, fontSize: 14)),
  //             ],
  //           )
  //         ],
  //       )
  //     );
  //     result.add(ss); 
  //   }

  //   return result;
  // }

}
