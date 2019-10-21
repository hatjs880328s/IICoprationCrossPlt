import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NSNormalSearchBar extends StatelessWidget {

  /// 对外暴露的点击方法 - 可以设置跳转
  ValueSetter<int> onTap;

  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(14)),
        border: Border.all(width: 1, color: Colors.white),
        color: Color.fromRGBO(1, 1, 1, 0.05),
      ),
      margin: EdgeInsets.fromLTRB(15, 8, 15, 8),
      child: TextField(
            enableInteractiveSelection: false,
            textAlign: TextAlign.center,
            onTap: () {
              this.onTap(0);
            },
            decoration:
                InputDecoration(hintText: '🔍  搜索', border: InputBorder.none),
          )
    );
  }
}
