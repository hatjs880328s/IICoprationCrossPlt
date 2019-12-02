import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rebuild_flutter/BLL/AppBll/nsnormalconfig.dart';
import 'package:rebuild_flutter/BLL/LoginBll/loginbll.dart';
import 'package:rebuild_flutter/BLL/gitbll/gitfileprogressbll.dart';
import 'package:rebuild_flutter/BLL/gitbll/gituserprogressbll.dart';
import 'package:rebuild_flutter/MODEL/Login/nsloginglobal.dart';
import 'package:rebuild_flutter/MODEL/Login/nsloginmodel.dart';
import 'package:rebuild_flutter/USL/TabbarGroup/maintabbar.dart';
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

  Color loginBtnColor = Colors.grey;

  String sentCode = "8888";

  String errorText;

  @override
  void initState() {
    super.initState();
    sdk.sharesdkConfig();

    this.codeCon.addListener(() {
      setState(() {
        if (this.codeCon.text == this.sentCode && this.sentCode.isNotEmpty) {
          loginBtnColor = Colors.black;
          errorText = null;
        } else {
          errorText = "验证码错误";
        }
      });
    });
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _countdownTimer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                decoration: InputDecoration(hintText: "请输入验证码", errorText: errorText),
              ),
            ),

            /// 登陆按钮
            Container(
              margin: EdgeInsets.only(left: 25, right: 25, top: 65),
              height: 45,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(0, 0, 0, 0.05),
                  borderRadius: BorderRadius.circular(3)),
              child: GestureDetector(
                  onTap: () {
                    this.emailLogin();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(top: 2),
                    child: Text(
                      '登陆',
                      style: TextStyle(color: loginBtnColor,
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
                  GestureDetector(
                    child: Image(
                    height: 30,
                    width: 30,
                    image: AssetImage('images/login_weixin.png'),
                  ),
                  onTap: () {
                    this.getUserInfoWithThirdPlt("weixin");
                  },
                  ),
                  //qq
                  Container(
                    margin: EdgeInsets.only(left: 45, right: 45),
                    child: GestureDetector(
                      child: Image(
                      height: 30,
                      width: 30,
                      image: AssetImage('images/login_qq.png'),
                    ),
                    onTap: () {
                      this.getUserInfoWithThirdPlt("qq");
                    },
                    )
                  ),
                  //新浪微博
                  GestureDetector(
                    child: Image(
                    height: 30,
                    width: 30,
                    image: AssetImage('images/login_weibo.png'),
                  ),
                  onTap: () {
                    this.getUserInfoWithThirdPlt("weibo");
                  },
                  )
                ],
              ),
            )
          ],
        )),
    );
  }

  /// 第三方登陆
  void getUserInfoWithThirdPlt(String plt) {
    LoginBll().loginwithThirdPlt(plt, (){
      //登陆成功
      
      this.goMainpage();
    });
  }

  /// 邮件登陆
  void emailLogin() {
    if (this.errorText != null) { return; }
    LoginBll().loginWithEmailAndCode(this.emailCon.text, () {
      //登陆成功
      this.goMainpage();
    });
  }

  void goMainpage() async {
    NSLoginModel model = await NSLoginGlobal.getInstance().getUserInfo();
    await GitUserProgressBLL().createNewUser2Git(model);
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return MaintabBar();
    }));
  }

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
          this.sentCode = code;
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
