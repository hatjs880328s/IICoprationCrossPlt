import 'package:flutter/material.dart';
import 'package:rebuild_flutter/BLL/GitFileBLL/gitfilebll.dart';
import 'package:rebuild_flutter/DAL/newlist/newlistdal.dart';
import 'package:rebuild_flutter/MODEL/Newfile/realgitfilemodel.dart';

/// 文件详情页面
class DetailPage extends StatefulWidget {

  String filepath;

  DetailPage(String filepath) {
    this.filepath = filepath;
  }

  RealGitFileModel model;

  @override 
  State<StatefulWidget> createState() {
    return DetailPageState();
  }
}

class DetailPageState extends State<DetailPage> {

  @override
  void initState() {
    super.initState();
    this.getDetailInfo();
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.model == null ? 'loading...' : widget.model.getTitleInfo())
      ),
      body: Text(
        widget.model == null ? 'loading...' : widget.model.content,
        style: TextStyle(fontSize: 14),
      ),
    );
  }

  /// 获取详情信息
  Future getDetailInfo() async {
    GitFileBLL dal = GitFileBLL();
    RealGitFileModel model = await dal.getOneFileContent(widget.filepath);
    setState(() {
      widget.model = model;
    });
  }
}