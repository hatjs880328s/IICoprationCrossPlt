import 'dart:convert';

import 'package:rebuild_flutter/MODEL/Login/nsloginmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NSLoginGlobal {
  static NSLoginGlobal _shareInstance;

  String userInfoKey = "NSUSERINFOKEY";

  static NSLoginGlobal getInstance() {
    if (_shareInstance == null) {
      _shareInstance = NSLoginGlobal();
    }

    return _shareInstance;
  }

  /// 获取用户信息
  Future<NSLoginModel> getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String info = prefs.getString(userInfoKey);
    if (info == null) {
      return null;
    }
    Map maps = json.decode(info);
    NSLoginModel model = NSLoginModel.fromJson(maps);
    return model;
  }
}