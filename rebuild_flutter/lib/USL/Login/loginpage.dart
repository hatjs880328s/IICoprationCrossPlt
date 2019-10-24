import 'package:flutter/material.dart';
import 'package:rebuild_flutter/BLL/AppBll/nsnormalconfig.dart';
import 'package:rebuild_flutter/USL/TESTFile/testindicate.dart';
import 'package:rebuild_flutter/UTI/COMPONENT/NSShare/nsahresdk.dart';
import 'package:sharesdk_plugin/sharesdk_interface.dart';
import 'package:sharesdk_plugin/sharesdk_plugin.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  NSShareSDK sdk = NSShareSDK();

  @override
  void initState() {
    super.initState();
    sdk.sharesdkConfig();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
      children: <Widget>[
        /// app - icon - 为了让它从左边开始有添加了个row
        Row(
          children: <Widget>[
            Container(
              height: 80,
              width: 80,
              margin:
                  EdgeInsets.fromLTRB(25, NSNormalConfig.appAppBarHeight, 0, 0),
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
        Container(
          alignment: Alignment.topLeft,
          margin: EdgeInsets.fromLTRB(25, 15, 0, 0),
          child: Text(
            'Hello！欢迎使用\n协同文档',
            style:
                TextStyle(fontFamily: NSNormalConfig.fontFamily, fontSize: 28),
            textAlign: TextAlign.left,
          ),
        ),
      ],
    ),
    );
  }

  // void getUserInfoToWechat(BuildContext context) {
  //   SharesdkPlugin.getUserInfo(
  //       ShareSDKPlatforms.wechatSession, (SSDKResponseState state,
  //       Map user, SSDKError error) {
  //       print('error =======${error.toString()}');
  //   });
  // }
}
