import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rebuild_flutter/BLL/AppBll/nsnormalconfig.dart';

class NSActionField extends StatelessWidget {
  
  dynamic actionOne;

  TextEditingController con = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text("创建文件夹", style: TextStyle(fontSize: 16, color: Colors.black)),
      content: Text("请输入文件夹名称",
          style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
              fontFamily: NSNormalConfig.fontFamily)),
      actions: <Widget>[
        Container(
          decoration: BoxDecoration(
            border: null,
          ),
          padding: EdgeInsets.all(6),
          child: CupertinoTextField(
            controller: con,
          ),
        ),
        Container(
          height: 45,
          padding: EdgeInsets.fromLTRB(0, 11, 0, 8),
          child: GestureDetector(
            child: Text(
              "取消",
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: NSNormalConfig.fontFamily,
                  decoration: TextDecoration.none),
              textAlign: TextAlign.center,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        Container(
          height: 45,
          padding: EdgeInsets.fromLTRB(0, 11, 0, 8),
          child: GestureDetector(
            child: Text(
              "创建",
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: NSNormalConfig.fontFamily,
                  decoration: TextDecoration.none,
                  color: Colors.black),
              textAlign: TextAlign.center,
            ),
            onTap: () {
              if (this.con.text.isEmpty) {
                Fluttertoast.showToast(
                  msg: "文件夹名称不可为空",
                );
              } else {
                Navigator.pop(context);
                actionOne(this.con.text);
              }
            },
          ),
        )
      ],
    );
  }
}