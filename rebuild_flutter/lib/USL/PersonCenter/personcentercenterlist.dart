import 'package:flutter/material.dart';

/// 中间的listvw
class PersoncenterCenterList extends StatelessWidget {
  List<List<String>> datasource = [
    ["个人信息", "我的收藏", "我的标签", "与我分享", "加星文件"],
    ["消息中心", "意见反馈", "关于我们"]
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: this.createWidget(context),
    );
  }

  /// 根据数据源创建widget数组
  List<Widget> createWidget(BuildContext context) {
    List<Widget> result = [];
    for (String eachitem in this.datasource[0]) {
      if (this.datasource[0].last == eachitem) {
        var eachWidget = Container(
            padding: EdgeInsets.all(17),
            child: Stack(
              children: <Widget>[
                Positioned(
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Image(image: AssetImage('images/main_tab_person.png'), height: 24, width: 24),
                          SizedBox(width: 15),
                          Text(eachitem, style: TextStyle(fontSize: 15)),
                        ],
                      ),
                      SizedBox(height: 30),
                      Divider(
                          height: 1,
                          color: Colors.grey,
                          endIndent: 0,
                          indent: 0)
                    ],
                  ),
                ),
                Positioned(
                  right: 9,
                  child: Image(
                  image: AssetImage('images/personcenter_arrow_right.png'),
                  width: 20,
                  height: 20
                ),
                )
              ],
            ));
        result.add(eachWidget);
      } else {
        var eachWidget = Container(
          padding: EdgeInsets.all(17),
          child: Stack(
            children: <Widget>[
              Positioned(
                child: Row(
                  children: <Widget>[
                    Image(image: AssetImage('images/main_tab_person.png'), height: 24, width: 24),
                    SizedBox(width: 15),
                    Text(eachitem, style: TextStyle(fontSize: 15)),
                  ],
                ),
              ),
              Positioned(
                right: 9,
                child: Image(
                  image: AssetImage('images/personcenter_arrow_right.png'),
                  width: 20,
                  height: 20
                ),
              )
            ],
          ),
        );
        result.add(eachWidget);
      }
    }
    for (String eachitem in this.datasource[1]) {
      var eachWidget = Container(
        padding: EdgeInsets.all(17),
        child: Stack(
            children: <Widget>[
              Positioned(
                child: Row(
                  children: <Widget>[
                    Image(image: AssetImage('images/main_tab_person.png'), height: 24, width: 24),
                    SizedBox(width: 15),
                    Text(eachitem, style: TextStyle(fontSize: 15)),
                  ],
                ),
              ),
              Positioned(
                right: 9,
                child: Image(
                  image: AssetImage('images/personcenter_arrow_right.png'),
                  width: 20,
                  height: 20
                ),
              )
            ],
          ),
      );
      result.add(eachWidget);
    }
    return result;
  }
}
