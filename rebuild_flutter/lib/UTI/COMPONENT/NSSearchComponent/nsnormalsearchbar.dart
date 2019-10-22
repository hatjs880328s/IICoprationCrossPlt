
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NSNormalSearchBar extends StatelessWidget {
  /// 对外暴露的点击方法 - 可以设置跳转
  ValueSetter<int> onTap;

  Widget build(BuildContext context) {
    return Container(
        height: 35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          border: Border.all(width: 1, color: Colors.white),
          color: Color.fromRGBO(1, 1, 1, 0.04),
        ),
        margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: GestureDetector(
            onTap: () { this.onTap(0); },
            child: Text(
              '🔍  搜索',
              style: TextStyle(fontSize: 18, color: Colors.grey),
              textAlign: TextAlign.center,
            )));
  }
}
