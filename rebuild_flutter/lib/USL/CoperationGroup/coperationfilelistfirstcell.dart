import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rebuild_flutter/USL/CreateFile/editorpage.dart';

/// 协同组顶部漂亮cell
class CoperationFileListFirstCell extends StatelessWidget {

  String coperationName;

  CoperationFileListFirstCell(String coperationGroupname) {
    this.coperationName = coperationGroupname;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 243,
        //color: Colors.white,
        child: Stack(
          children: <Widget>[
            Positioned(
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Positioned(
                left: 8,
                top: 100,
                right: 8,
                height: 130,
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      border: Border.all(width: 0.5, color: Colors.grey),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 1.0),
                            blurRadius: 1.0,
                            spreadRadius: 0.3)
                      ],
                    ),
                    padding: EdgeInsets.only(top: 50),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                            left: 40,
                            top: 10,
                            child: GestureDetector(
                                child: Column(
                                  children: <Widget>[
                                    Icon(Icons.palette),
                                    Text('邀请', style: TextStyle(fontSize: 15)),
                                    Text('加入',
                                        style: TextStyle(
                                            fontSize: 13, color: Colors.grey)),
                                  ],
                                ),
                                onTap: () {
                                  print("点击邀请");
                                })),
                        Positioned(
                            width: 60,
                            left: (MediaQuery.of(context).size.width - 16) / 2 -
                                30,
                            top: 10,
                            child: GestureDetector(
                              child: Column(
                                children: <Widget>[
                                  Icon(Icons.share),
                                  Text('分享', style: TextStyle(fontSize: 15)),
                                  Text('此群组',
                                      style: TextStyle(
                                          fontSize: 13, color: Colors.grey)),
                                ],
                              ),
                              onTap: () {
                                print("点击分享");
                              },
                            )),
                        Positioned(
                            right: 40,
                            top: 10,
                            child: GestureDetector(
                              child: Column(
                                children: <Widget>[
                                  Icon(Icons.save_alt),
                                  Text('创建', style: TextStyle(fontSize: 15)),
                                  Text('新文章',
                                      style: TextStyle(
                                          fontSize: 13, color: Colors.grey)),
                                ],
                              ),
                              onTap: () {
                                print("点击收藏");
                              },
                            ))
                      ],
                    ))),
            //头像
            Positioned(
                left: 40,
                top: 50,
                width: 100,
                height: 100,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    border: Border.all(
                        width: 1, color: Colors.grey, style: BorderStyle.solid),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    image: DecorationImage(
                      image: AssetImage('images/cop_128.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                )),
            //协同组名称
            Positioned(
                top: 110,
                right: 40,
                child: Text('协同组名称: 协同组A',
                    textAlign: TextAlign.end,
                    style:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.w500)))
          ],
        ));
  }

  /// 创建一个新的协同组文章
  void createNewCoperationFile(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return EditorPage(null, this.coperationName);
    }));

  }

}
