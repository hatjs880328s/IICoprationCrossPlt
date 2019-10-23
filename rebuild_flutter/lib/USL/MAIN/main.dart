
import 'package:rebuild_flutter/BLL/AppBll/nsappconfig.dart';
import 'package:rebuild_flutter/USL/TabbarGroup/maintabbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:rebuild_flutter/USL/TESTFile/testindicate.dart';
import 'package:rebuild_flutter/USL/TESTFile/fromtable.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    NSAPPConfig.startService();
    
    return MaterialApp(
        title: "halo,world",
        theme: ThemeData(
          primaryColor: Colors.white
        ),
        home: MaintabBar()
      );
  }
}