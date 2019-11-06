import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:rebuild_flutter/BLL/GitFileBLL/gitfilebll.dart';
import 'package:zefyr/zefyr.dart';

/// doc: https://github.com/memspace/zefyr/blob/master/doc/quick-start.md

class EditorPage extends StatefulWidget {

  @override
  EditorPageState createState() => EditorPageState();

  List<dynamic> jsonDatas;

  EditorPage(List<dynamic> jsonData) {
    this.jsonDatas = jsonData;
  }
}

class EditorPageState extends State<EditorPage> {
  ZefyrController _controller;
  FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();

    if (widget.jsonDatas == null) {
      // 此处注释为加载一个空文档；
      final document = _loadDocument();
      _controller = ZefyrController(document);
    } else {
      // 此处注释为加载一个JSON文档；
      _loadDocumentWithJson().then((document) {
        setState(() {
          _controller = ZefyrController(document);
        });
      });
    }
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
        title: Text("Editor page"),
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

  /// 存储文件
  void _saveDocument(BuildContext context) {
    final contents = jsonEncode(_controller.document);
    GitFileBLL bll = GitFileBLL();
    bll.createFile(contents, "最新", "haloworld");
    final file = File(Directory.systemTemp.path + "/quick_start.json");
    file.writeAsString(contents).then((_) {
      Fluttertoast.showToast(
        msg: "存储成功!",
        gravity: ToastGravity.CENTER,
      );
    });
  }

  /// 加载数据，使用json数据源
  Future<NotusDocument> _loadDocumentWithJson() async {
    final file = File(Directory.systemTemp.path + "/quick_start.json");
    if (await file.exists()) {
      final contents = await file.readAsString();
      return NotusDocument.fromJson(jsonDecode(contents));
    }
    return NotusDocument();
  }
}
