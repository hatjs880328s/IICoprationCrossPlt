import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rebuild_flutter/BLL/AppBll/nsnormalconfig.dart';
import 'package:rebuild_flutter/BLL/LoginBll/loginbll.dart';
import 'package:rebuild_flutter/UTI/COMPONENT/NSShare/nsahresdk.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  NSShareSDK sdk = NSShareSDK();

  TextEditingController emailCon = TextEditingController();

  TextEditingController codeCon = TextEditingController();

  Timer _countdownTimer;
  String _codeCountdownStr = '获取验证码';
  int _countdownNum = 59;

  @override
  void initState() {
    super.initState();
    sdk.sharesdkConfig();
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _countdownTimer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            /// app - icon - 为了让它从左边开始有添加了个row
            Row(
              children: <Widget>[
                Container(
                  height: 80,
                  width: 80,
                  margin: EdgeInsets.fromLTRB(
                      25, NSNormalConfig.appAppBarHeight, 0, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    image: DecorationImage(
                      image: AssetImage('images/cop_128.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),

            /// 欢迎文案
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.fromLTRB(25, 15, 0, 0),
              child: Text(
                'Hello！欢迎使用\n协同文档',
                style: TextStyle(
                    fontFamily: NSNormalConfig.fontFamily, fontSize: 28),
                textAlign: TextAlign.left,
              ),
            ),

            /// 邮箱提示
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(top: 30, left: 25),
              child: Text(
                '邮箱账号',
                style: TextStyle(
                    fontFamily: NSNormalConfig.fontFamily, fontSize: 13),
                textAlign: TextAlign.left,
              ),
            ),

            /// 邮箱输入框
            Container(
              margin: EdgeInsets.only(left: 25, right: 25, top: 10),
              child: TextField(
                controller: emailCon,
                style: TextStyle(
                    fontSize: 16, fontFamily: NSNormalConfig.fontFamily),
                decoration: InputDecoration(
                  hintText: "请输入邮箱账号",
                  suffix: GestureDetector(
                    onTap: () {
                      this.reGetCountdown();
                    },
                    child: Text(
                      _codeCountdownStr,
                      style: TextStyle(color: Colors.blue, fontSize: 15),
                    ),
                  ),
                ),
              ),
            ),

            /// 验证码提示
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(top: 30, left: 25),
              child: Text(
                '验证码',
                style: TextStyle(
                    fontFamily: NSNormalConfig.fontFamily, fontSize: 13),
                textAlign: TextAlign.left,
              ),
            ),

            /// 验证码
            Container(
              margin: EdgeInsets.only(left: 25, right: 25, top: 10),
              child: TextField(
                controller: codeCon,
                style: TextStyle(
                    fontSize: 16, fontFamily: NSNormalConfig.fontFamily),
                decoration: InputDecoration(hintText: "请输入验证码"),
              ),
            ),

            /// 登陆按钮
            Container(
              margin: EdgeInsets.only(left: 25, right: 25, top: 65),
              height: 40,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(0, 0, 0, 0.05),
                  borderRadius: BorderRadius.circular(3)),
              child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(top: 2),
                    child: Text(
                      '登陆',
                      style: TextStyle(
                          fontFamily: NSNormalConfig.fontFamily, fontSize: 20),
                    ),
                  )),
            ),

            /// 第三方登陆
            Container(
              margin: EdgeInsets.only(left: 25, right: 25, top: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  //微信
                  Image(
                    height: 30,
                    width: 30,
                    image: AssetImage('images/login_weixin.png'),
                  ),
                  //qq
                  Container(
                    margin: EdgeInsets.only(left: 45, right: 45),
                    child: Image(
                      height: 30,
                      width: 30,
                      image: AssetImage('images/login_qq.png'),
                    ),
                  ),
                  //新浪微博
                  Image(
                    height: 30,
                    width: 30,
                    image: AssetImage('images/login_weibo.png'),
                  )
                ],
              ),
            )
          ],
        ));
  }

  // void getUserInfoToWechat(BuildContext context) {
  //   SharesdkPlugin.getUserInfo(
  //       ShareSDKPlatforms.wechatSession, (SSDKResponseState state,
  //       Map user, SSDKError error) {
  //       print('error =======${error.toString()}');
  //   });
  // }

  /// 发送邮件 - 计时器
  void reGetCountdown() {
    setState(() {
      if (_countdownTimer != null) {
        return;
      }
      // 发送邮件
      String email = this.emailCon.text;
        FocusScope.of(context).requestFocus(FocusNode());
        LoginBll().loginwithEmail(email, (String code) {
          print(code);
        });
      // Timer的第一秒倒计时是有一点延迟的，为了立刻显示效果可以添加下一行。
      _codeCountdownStr = '${_countdownNum--}重新获取';
      _countdownTimer = new Timer.periodic(new Duration(seconds: 1), (timer) {
        setState(() {
          if (_countdownNum > 0) {
            _codeCountdownStr = '${_countdownNum--}重新获取';
          } else {
            _codeCountdownStr = '获取验证码';
            _countdownNum = 59;
            _countdownTimer.cancel();
            _countdownTimer = null;
          }
        });
      });
    });
  }
}
