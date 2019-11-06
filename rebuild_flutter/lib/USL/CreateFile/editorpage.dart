import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:rebuild_flutter/BLL/GitFileBLL/gitfilebll.dart';
import 'package:rebuild_flutter/MODEL/Newfile/realgitfilemodel.dart';
import 'package:zefyr/zefyr.dart';

/// doc: https://github.com/memspace/zefyr/blob/master/doc/quick-start.md

class EditorPage extends StatefulWidget {
  @override
  EditorPageState createState() => EditorPageState();

  String filePath;

  String coperationGroupname;

  /// filepath： 如果为空就是新建一个文档；如果不为空则是需要从网络加载一个json文档
  /// coperationGroupname：协作组名称，如果有这个属性就是创建一个协同组文章；否则就是创建一个普通文章
  EditorPage(String filePath, String coperationGroupname) {
    this.filePath = filePath;
    this.coperationGroupname = coperationGroupname;
  }
}

class EditorPageState extends State<EditorPage> {
  ZefyrController _controller;
  FocusNode _focusNode;
  String titleInfo;
  TextEditingController fieldCon;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    fieldCon = TextEditingController();

    if (widget.filePath == null) {
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
    GitFileBLL bll = GitFileBLL();
    bll.createFile(contents, widget.coperationGroupname, this.fieldCon.text);
  }

  /// 加载数据，使用json数据源
  Future<NotusDocument> _loadDocumentWithJson() async {
    GitFileBLL dal = GitFileBLL();
    RealGitFileModel model = await dal.getOneFileContent(widget.filePath);  
    this.fieldCon.text = model.getTitleInfo();
    return NotusDocument.fromJson(jsonDecode(model.content));
  }
}
