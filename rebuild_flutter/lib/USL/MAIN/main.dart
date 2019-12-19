import 'package:fish_redux/fish_redux.dart';
import 'package:rebuild_flutter/BLL/AppBll/nsappconfig.dart';
import 'package:rebuild_flutter/MODEL/Login/nsloginglobal.dart';
import 'package:rebuild_flutter/MODEL/Login/nsloginmodel.dart';
import 'package:rebuild_flutter/USL/Login/loginpage.dart';
import 'package:rebuild_flutter/USL/ReduxAPP/empty/gird_page/page.dart';
import 'package:rebuild_flutter/USL/ReduxAPP/empty/main_page/page.dart';
import 'package:rebuild_flutter/USL/ReduxAPP/empty/reduxlist_page/page.dart';
import 'package:rebuild_flutter/USL/TabbarGroup/maintabbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  Widget mainWid;

  @override
  void initState() {
    super.initState();
    this.mainWid = initWid();

    this.shouldJumpWid();
  }

  @override
  Widget build(BuildContext context) {
    NSAPPConfig.startService();

    final AbstractRoutes routes = PageRoutes(
    pages: <String, Page<Object, dynamic>>{
      'mainpage': MainPage(),
      'girdpage': GirdPage(),
      'reduxlist': ReduxlistPage(),
    }
  );

    return MaterialApp(
      title: "halo,world",
      theme: ThemeData(primaryColor: Colors.white),
      debugShowCheckedModeBanner: false,
      home: mainWid,
      onGenerateRoute: (RouteSettings settings) {
      return MaterialPageRoute<Object>(builder: (BuildContext context) {
        return routes.buildPage(settings.name, settings.arguments);
      });
    },
    );
  }

  Widget initWid() {
    return Center(
          child: Image(
            image: AssetImage('images/cop_128.png'),
            height: 128,
            width: 128,
          ),
        );
  }

  /// 验证是否有登陆信息
  Future<void> shouldJumpWid() async {
    NSLoginModel model = await NSLoginGlobal.getInstance().getUserInfo();
    if (model == null) {
      setState(() {
        this.mainWid = LoginPage();
      });
    } else {
      setState(() {
        this.mainWid = MaintabBar();
      });
    }
  }
}
