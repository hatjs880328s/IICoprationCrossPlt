import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:rebuild_flutter/BLL/gitbll/coperationfilelockbll.dart';
import 'package:rebuild_flutter/BLL/gitbll/gitfileprogressbll.dart';
import 'package:rebuild_flutter/MODEL/CoperationGroup/coperationgroupmodel.dart';
import 'package:rebuild_flutter/MODEL/Newfile/realgitfilemodel.dart';
import 'package:zefyr/zefyr.dart';

/// doc: https://github.com/memspace/zefyr/blob/master/doc/quick-start.md

class UpdateFile extends StatefulWidget {
  @override
  UpdateFileState createState() => UpdateFileState();

  CoperationGroupModel oldGroupInfo;

  RealGitFileModel oldItemmodel;

  bool isNormalFolder;

  /// oldGroupInfo : 协同组旧的info-model 如果更新文件需要更新它使用它
  UpdateFile(CoperationGroupModel oldGroupInfo, RealGitFileModel oldItem, bool isNormalFolder) {
    this.oldGroupInfo = oldGroupInfo;
    this.oldItemmodel = oldItem;
    this.isNormalFolder = isNormalFolder;
  }
}

class UpdateFileState extends State<UpdateFile> {
  ZefyrController _controller;
  FocusNode _focusNode;
  String titleInfo;
  TextEditingController fieldCon;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    fieldCon = TextEditingController();

    // 此处注释为加载一个JSON文档；
      _loadDocumentWithJson().then((document) {
        setState(() {
          _controller = ZefyrController(document);
        });
      });
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
        leading: IconButton(
          icon: Image(image: AssetImage('images/app_back.png'), width: 24, height: 35),
          onPressed: () {
            this._justGoback();
          },
        ),
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

  /// 发表文章
  Future<void> _saveDocument(BuildContext context) async {
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
    bool editresult = await bll.updateOneFile(contents, title, subTtitle, widget.oldItemmodel);
    if (editresult) {
      Navigator.of(context).pop();
    } else {
      Fluttertoast.showToast(
        msg: '保存失败，请稍候再试',
        gravity: ToastGravity.CENTER
      );
    }
  }

  Future<void> _justGoback() async {
    var unlock = await CoperationFileLockBLL().unlockfile(widget.oldItemmodel.fileid);
    if (unlock) {
      Navigator.of(context).pop();
    } else {
      Fluttertoast.showToast(
        msg: '释放文件失败，请重试',
        gravity: ToastGravity.CENTER
      );
    }
  }

  /// 加载数据，使用json数据源
  Future<NotusDocument> _loadDocumentWithJson() async {
    var item = await GitFileProgressBLL().getFileContent(widget.oldItemmodel);
    RealGitFileModel model = item;  
    this.fieldCon.text = model.getTitleInfo();
    return NotusDocument.fromJson(jsonDecode(model.content));
  }
}
