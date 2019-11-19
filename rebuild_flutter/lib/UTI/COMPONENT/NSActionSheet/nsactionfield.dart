import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rebuild_flutter/BLL/AppBll/nsnormalconfig.dart';

class NSActionField extends StatelessWidget {
  
  dynamic actionOne;

  String title;

  String subtitle;

  String confirmStr;

  NSActionField(String title, String subTitle, String confirmStr) {
    this.title = title;
    this.subtitle = subTitle;
    this.confirmStr = confirmStr;
  }

  TextEditingController con = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title, style: TextStyle(fontSize: 16, color: Colors.black)),
      content: Text(subtitle,
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
                  fontWeight: FontWeight.w500,
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
              confirmStr,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: NSNormalConfig.fontFamily,
                  decoration: TextDecoration.none,
                  color: Colors.black),
              textAlign: TextAlign.center,
            ),
            onTap: () {
              if (this.con.text.isEmpty) {
                Fluttertoast.showToast(
                  msg: "内容不可为空",
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
