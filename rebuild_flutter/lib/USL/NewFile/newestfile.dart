import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rebuild_flutter/BLL/gitbll/gitfileprogressbll.dart';
import 'package:rebuild_flutter/MODEL/CoperationGroup/coperationgroupmodel.dart';
import 'package:rebuild_flutter/MODEL/Newfile/realgitfilemodel.dart';
import 'package:rebuild_flutter/UTI/COMPONENT/NSSearchComponent/nssearchbar.dart';
import 'package:rebuild_flutter/USL/NewFile/filelistcell.dart';
import 'package:rebuild_flutter/UTI/COMPONENT/NSSearchComponent/nsnormalsearchbar.dart';
import 'package:rebuild_flutter/BLL/AppBll/nsnormalconfig.dart';
import 'package:rebuild_flutter/UTI/COMPONENT/IIAnimationColor/iianimationcolor.dart';
import 'package:rebuild_flutter/UTI/NSNotificationCenter/nsnotificationcenter.dart';

/// 最新文章列表页面 - tab首屏
class NewestFile extends StatefulWidget {

  bool isNewset = false;

  String titleInfo = "";

  String folderid = "";

  NewestFile(bool isnew, String titleinfo, String folderid) {
    this.isNewset = isnew;
    this.titleInfo = titleinfo;
    this.folderid = folderid;
  }

  State<StatefulWidget> createState() => NewestFileState();
}

class NewestFileState extends State<NewestFile>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  List<RealGitFileModel> list = [];

  CoperationGroupModel overinfo;

  AnimationController controller;

  Animation<double> animation;

  CurvedAnimation curve;

  bool isforward = false;

  NSNormalNotificationObserver observer = NSNormalNotificationObserver();

  @override
  bool get wantKeepAlive => true;

  @override
  initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000));
    curve = CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);
    animation = Tween(begin: 0.0, end: 1.0).animate(controller);
    animation.addListener(() {
      setState(() {});
    });
    this.getSelfFolderList();

    observer.executeAction = (Map<String, dynamic> mapInfo) {
      this.getSelfFolderList();
    };
    NSNotificationCenter.getInstance().addOneItem2SomeTable(observer, observer.notificationKey);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    this.observer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: widget.isNewset ? false : true,
        title: Text(
          widget.titleInfo,
           style: TextStyle(fontSize: 20, fontFamily: NSNormalConfig.fontFamily)),
        elevation: 0,
        actions: <Widget>[
          Transform.rotate(
            angle: animation.value * pi,
            child: IconButton(
                icon: Icon(Icons.sync),
                onPressed: () {
                  if (!isforward) {
                    controller.forward();
                  } else {
                    controller.reverse();
                  }
                  isforward = !isforward;
                  this.getSelfFolderList();
                }),
          )
        ],
      ),
      body: Container(
        color: Colors.white,
        child: ListView.builder(
          itemCount: list.length + 1,
          itemBuilder: (context, i) {
            if (this.list.length == 0) {
              return Center(
                  child: LinearProgressIndicator(
                      backgroundColor: Colors.white,
                      valueColor: IIAnimationColor()));
            }
            if (i == 0) {
              NSNormalSearchBar search = NSNormalSearchBar();
              search.onTap = (int) {
                showSearch(context: context, delegate: nssearchbarDelegate());
              };
              return search;
            }
            return FileListCell(
                this.overinfo,
                list[i - 1]);
          },
        ),
      ),
    );
  }

  //
  // 获取最新数据
  void getSelfFolderList() async {
    List<RealGitFileModel> lists;
    if (widget.isNewset) {
      overinfo = await GitFileProgressBLL().getOneFolderFileLists(true, "最新");
    } else {
      overinfo = await GitFileProgressBLL().getOneFolderFileLists(true, widget.folderid);
    }
    lists = overinfo.files;
    list = lists;
    setState(() {
      list = lists;
    });
  }
}
