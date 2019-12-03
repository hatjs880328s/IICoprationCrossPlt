import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rebuild_flutter/BLL/gitbll/gitfileprogressbll.dart';
import 'package:rebuild_flutter/MODEL/CoperationGroup/coperationgroupmodel.dart';
import 'package:rebuild_flutter/MODEL/Newfile/realgitfilemodel.dart';
import 'package:rebuild_flutter/USL/CoperationGroup/coperationfilelistfirstcell.dart';
import 'package:rebuild_flutter/USL/CoperationGroup/coperationfilelistforthcell.dart';
import 'package:rebuild_flutter/USL/CoperationGroup/coperationfilelistsecondcell.dart';
import 'package:rebuild_flutter/USL/CoperationGroup/coperationfilelistthirdcell.dart';

class CoperationFileList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CoperationFileListState();
  }

  CoperationFileList(String coperid, String uid) {
    this.coperid = coperid;
    this.uid = uid;
  }

  String coperid;

  String uid; 
}

class CoperationFileListState extends State<CoperationFileList> {
  CoperationGroupModel list;

  ScrollController scrollCon;

  @override
  void initState() {
    super.initState();
    this.getGroupinfo();
    this.scrollCon = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 220,
              child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 0.5, color: Colors.grey)),
                  child: Image(
                      image: AssetImage('images/cop_128.png'),
                      fit: BoxFit.fill))),
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: 0,
              child: ListView(
                controller: this.scrollCon,
                children: this.list == null ? [] : [
                  //第一部分（返回按钮 & 顶部分享、邀请等按钮）
                  CoperationFileListFirstCell(this.list.name, this.list),
                  //第二部分协同组基本信息
                  CoperationFileListSecondCell(this.list.realFiles.length, this.list.realUsers.length, this.list.createtime),
                  //第三部分协同成员信息
                  CoperationFileListCell(this.list.realUsers),
                  //第四部分协同组文章
                  CoperationFileListForthCell(this.list),
                ]
              )),
        ],
      ),
    ));
  }

  /// 获取协同组信息
  Future<void> getGroupinfo() async {
    Fluttertoast.showToast(
      msg: "数据加载,请稍后.",
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.grey
    );
    var filebll = GitFileProgressBLL();
    CoperationGroupModel result = await filebll.getOneCoperationGroupInfo(widget.coperid);
    setState(() {
      Fluttertoast.cancel();
      this.list = result;
    });
  }
}
