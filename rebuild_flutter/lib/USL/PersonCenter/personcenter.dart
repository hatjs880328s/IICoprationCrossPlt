import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rebuild_flutter/MODEL/Login/nsloginglobal.dart';
import 'package:rebuild_flutter/MODEL/Login/nsloginmodel.dart';
import 'package:rebuild_flutter/USL/PersonCenter/personcenterbottom.dart';
import 'package:rebuild_flutter/USL/PersonCenter/personcentercenterlist.dart';
import 'package:rebuild_flutter/USL/PersonCenter/personcenterheader.dart';

/// 个人中心页面
class PersonCenter extends StatefulWidget {
  
  State<PersonCenter> createState() {
    return PersonCenterStata();
  }
}

class PersonCenterStata extends State<PersonCenter> {
  NSLoginModel userinfo;
  @override
  void initState() {
    super.initState();
    this.getUserinfo();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          PersonCenterHeader(this.userinfo),
          SizedBox(height: 15),
          PersoncenterCenterList(),
          PersoncenterBottom()
        ],
      ),
    );
  }

  void getUserinfo() async {
    var userinfos = await NSLoginGlobal.getInstance().getUserInfo();
    setState(() {
      this.userinfo = userinfos;
    });
  }
}