import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:rebuild_flutter/BLL/AppBll/nsnormalconfig.dart';

class NSActionSheet extends StatelessWidget {

  dynamic actionOne;

  dynamic actionTwo;

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      title: Text("创建文件与文件夹", style: TextStyle(fontSize: 16, color: Colors.black)),
      message: Text("新建文件默认放到您的[最新]目录下",
          style: TextStyle(fontSize: 14, color: Colors.grey, fontFamily: NSNormalConfig.fontFamily)),
      cancelButton: Container(
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
      actions: <Widget>[
        CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
            this.actionOne(0);
          },
          child: Text("新建文件",
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontFamily: NSNormalConfig.fontFamily),
              textAlign: TextAlign.center),
        ),
        CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
            this.actionTwo(1);
          },
          child: Text("新建书架",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  decoration: TextDecoration.none,
                  color: Colors.black,
                  fontFamily: NSNormalConfig.fontFamily),
              textAlign: TextAlign.center),
        ),
      ],
    );
  }
}
