import 'package:flutter/material.dart';

/// 个人中心底部的退出登录按钮
class PersoncenterBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(16),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12, width: 0.5),
              borderRadius: BorderRadius.circular(4),
            ),
            child: GestureDetector(
              child: Text('退出登录',
                  style: TextStyle(color: Colors.red, fontSize: 16)),
              onTap: () {
                
              },
            )),
        SizedBox(
          height: 25,
        )
      ],
    );
  }
}
