import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rebuild_flutter/BLL/gitbll/gitfileprogressbll.dart';
import 'package:rebuild_flutter/MODEL/CoperationGroup/coperationgroupmodel.dart';
import 'package:zefyr/zefyr.dart';

/// doc: https://github.com/memspace/zefyr/blob/master/doc/quick-start.md

/// 创建一个新的文件
class CreatNewestFile extends StatefulWidget {
  @override
  CreatNewestFileState createState() => CreatNewestFileState();
}

class CreatNewestFileState extends State<CreatNewestFile> {
  ZefyrController _controller;
  FocusNode _focusNode;
  String titleInfo;
  TextEditingController fieldCon;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    fieldCon = TextEditingController();
    final document = _loadDocument();
    _controller = ZefyrController(document);
  }

  @override
  Widget build(BuildContext context) {
    final Widget body = (_controller == null)
        ? Center(child: CircularProgressIndicator())
        : ZefyrScaffold(
      child: ZefyrEditor(
            padding: EdgeInsets.all(16),
            controller: _controller,
            focusNode: _focusNode,
          ),
    );
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          ///textAlign: TextAlign.center,
          controller: this.fieldCon,
          decoration: InputDecoration(
            hintText: "请输入标题",
          ),
        ),
        actions: <Widget>[
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.save),
              onPressed: () => _saveDocument(context),
            ),
          )
        ],
      ),
      body: body,
    );
  }

  /// 预加载一个文档（空文档）
  NotusDocument _loadDocument() {
    return NotusDocument();
  }

  /// 发表文章
  void _saveDocument(BuildContext context) {
    if (this.fieldCon.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "标题不可为空",
        gravity: ToastGravity.CENTER,
      );
      return;
    }
    final contents = jsonEncode(_controller.document);
    String plainTxt = _controller.document.toPlainText();
    String subTtitle = plainTxt.length > 10 ? plainTxt.substring(0, 9) : plainTxt;
    String title = this.fieldCon.text;
    var bll = GitFileProgressBLL();
    try {
      bll.createNewestFolderFile(contents, title, subTtitle);
      Fluttertoast.showToast(
        msg: "创建成功",
      );
    } on Exception {
      
    }
  }
}
