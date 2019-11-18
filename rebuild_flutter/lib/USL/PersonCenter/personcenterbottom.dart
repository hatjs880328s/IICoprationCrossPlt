import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rebuild_flutter/BLL/LoginBll/loginbll.dart';
import 'package:rebuild_flutter/USL/Login/loginpage.dart';

/// 个人中心底部的退出登录按钮
class PersoncenterBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(16),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12, width: 0.5),
              borderRadius: BorderRadius.circular(4),
            ),
            child: GestureDetector(
              child: Text('退出登录',
                  style: TextStyle(color: Colors.red, fontSize: 16)),
              onTap: () {
                this.logout(context);
              },
            )),
        SizedBox(
          height: 25,
        )
      ],
    );
  }

  /// 退出登录
  Future<void> logout(BuildContext context) async {
    var result = await LoginBll().deleteUserInfo();
    if (result) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return LoginPage();
      }));
    } else {
      Fluttertoast.showToast(
        msg: "退出登录，请稍候再试."
      );
    }
  }
}
