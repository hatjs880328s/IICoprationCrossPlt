import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class IIWaitAni {

  static void showWait(String waitInfo) {
    Fluttertoast.showToast(
      msg: waitInfo.isEmpty ? '请求数据,请稍候' : waitInfo,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.black87,
      textColor: Colors.white
    );
  }

  static void hideWait() {
    Fluttertoast.cancel();
  }
}