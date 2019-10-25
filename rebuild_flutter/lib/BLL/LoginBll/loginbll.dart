import 'dart:convert';
import 'dart:ffi';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:rebuild_flutter/MODEL/Login/nsloginmodel.dart';
import 'package:rebuild_flutter/UTI/COMPONENT/IIMail/iismtpmail.dart';
import 'package:rebuild_flutter/UTI/COMPONENT/NSShare/nsahresdk.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharesdk_plugin/sharesdk_plugin.dart';

class LoginBll {

  String userInfoKey = "NSUSERINFOKEY";

  /// 第三方登陆
  void loginwithThirdPlt(String types, dynamic resultaction) {
    ShareSDKPlatform form = ShareSDKPlatforms.wechatSession;
    switch (types) {
      case "qq":
        form = ShareSDKPlatforms.qq;
        break;
      case "weixin":
        form = ShareSDKPlatforms.wechatSession;
        break;
      case "weibo":
        form = ShareSDKPlatforms.sina;
        break;
      default:
        break;
    }
    NSShareSDK().authPlatform(form, (Map maps) {
      String modelStr = json.encode(maps);
      this.saveUserinfo2Local(modelStr);
    });
  }

  /// 邮箱登陆 - 获取验证码
  void loginwithEmail(String email, dynamic codeaction) {
    IISmtpMail().sendMail(email, (String code) {
      if (code == null) {
        //发送失败
        Fluttertoast.showToast(msg: '发送失败，请稍后再试', gravity: ToastGravity.CENTER);
        //return null;
        codeaction(null);
      } else {
        //发送成功
        codeaction(code);
      }
    });
  }

  /// 用户信息本地存储
  void saveUserinfo2Local(String modelJsonStr) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(userInfoKey, modelJsonStr);
  }
}
