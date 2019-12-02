import 'dart:convert';
import 'package:convert/src/hex.dart';
import 'package:crypto/crypto.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rebuild_flutter/MODEL/Login/nsloginglobal.dart';
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
      if (maps == null) {
        //resultaction(false);
        Fluttertoast.showToast(
          msg: '认证失败',
        );
        return;
      }
      String modelStr = json.encode(maps);
      this.saveUserinfo2Local(modelStr);
      resultaction();
    });
  }

  /// 邮箱登陆 - 获取验证码
  void loginwithEmail(String email, dynamic codeaction) {
    IISmtpMail().sendMail(email, (String code) {
      if (code == null) {
        //发送失败
        Fluttertoast.showToast(msg: '发送失败，请稍后再试', gravity: ToastGravity.CENTER);
        codeaction(null);
      } else {
        //发送成功
        Fluttertoast.showToast(msg: '发送成功！', gravity: ToastGravity.CENTER);
        codeaction(code);
      }
    });
  }

  /// 邮箱登陆 - 真正的登陆
  void loginWithEmailAndCode(String email, dynamic endaction) {
    this.changeEamil2UserModel(email);
    endaction();
  }

  /// 用户信息本地存储
  void saveUserinfo2Local(String modelJsonStr) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(userInfoKey, modelJsonStr);
  }

  /// 获取用户信息
  Future<NSLoginModel> getUserInfo() async {
    return await NSLoginGlobal.getInstance().getUserInfo();
  }

  /// 删除用户信息
  Future<bool> deleteUserInfo() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     return await prefs.remove(this.userInfoKey);
  }

  /*
   * 将email转为用户model
   */
  NSLoginModel changeEamil2UserModel(String email) {
    var content = Utf8Encoder().convert(email);
    var digest = md5.convert(content);
    String md5Str = hex.encode(digest.bytes);
    Map<String, String> map = {
      "userid": md5Str,
      "nickname": email,
      "icon": "images/cop_128.png",
      "email": email
    };
    NSLoginModel model = NSLoginModel.fromJson(map);
    this.saveUserinfo2Local(json.encode(map));
    return model;
  }
}
