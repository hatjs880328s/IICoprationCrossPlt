import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rebuild_flutter/BLL/CoperationGroupBLL/coperationgroupbll.dart';
import 'package:rebuild_flutter/MODEL/Newfile/foldermodel.dart';
import 'package:rebuild_flutter/USL/CoperationGroup/coperationfilelistfirstcell.dart';
import 'package:rebuild_flutter/USL/CoperationGroup/coperationfilelistforthcell.dart';
import 'package:rebuild_flutter/USL/CoperationGroup/coperationfilelistsecondcell.dart';
import 'package:rebuild_flutter/USL/CoperationGroup/coperationfilelistthirdcell.dart';
import 'package:rebuild_flutter/USL/CoperationGroup/coperitiongroupcell.dart';
import 'package:rebuild_flutter/UTI/COMPONENT/IIAnimationColor/iianimationcolor.dart';
import 'package:rebuild_flutter/UTI/COMPONENT/NSActionSheet/nsactionfield.dart';

class CoperationFileList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CoperationFileListState();
  }

  CoperationFileList(String coperid) {
    this.coperid = coperid;
  }

  String coperid;
}

class CoperationFileListState extends State<CoperationFileList> {
  List<String> list = [];

  @override
  void initState() {
    super.initState();
    this.getGroupinfo();
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
              decoration: BoxDecoration(border: Border.all(width: 0.5, color: Colors.grey)),
              child: Image(image: AssetImage('images/cop_128.png'), fit: BoxFit.fill)
            )
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: 0,
              child: ListView(
            children: <Widget>[
              //第一部分（返回按钮 & 顶部分享、邀请等按钮）
              CoperationFileListFirstCell(),
              //第二部分协同组基本信息
              CoperationFileListSecondCell(),
              //第三部分协同成员信息
              CoperationFileListCell(),
              //第四部分协同组文章
              CoperationFileListForthCell(),
            ],
          )),
        ],
      ),
    ));
  }

  /// 获取协同组信息
  Future<void> getGroupinfo() async {
    CoperationGroupBLL bll = CoperationGroupBLL();
    List<String> list = await bll.getGroups(widget.coperid);
    setState(() {
      this.list = list;
    });
  }
}
