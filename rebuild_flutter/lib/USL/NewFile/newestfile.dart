import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rebuild_flutter/UTI/COMMON/iiheader.dart';
import 'package:rebuild_flutter/UTI/COMPONENT/nssearchbar.dart';

/// 最新文章列表页面 - tab首屏
class NewestFile extends StatefulWidget {
  State<StatefulWidget> createState() => NewestFileState();
}

class NewestFileState extends State<NewestFile> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('最新'),
        actions: <Widget>[
          Icon(Icons.sync),
          IconButton(icon: Icon(Icons.search), onPressed: () {
          showSearch(context: context, delegate: nssearchbarDelegate());
        }),
        ],
      ),
      body: Container(
        //child: materialsear,
        
      ),
    );
  }
}