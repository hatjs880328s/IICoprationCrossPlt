import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rebuild_flutter/BLL/gitbll/gitfileprogressbll.dart';
import 'package:rebuild_flutter/MODEL/CoperationGroup/coperationgroupmodel.dart';
import 'package:rebuild_flutter/MODEL/Newfile/realgitfilemodel.dart';
import 'package:rebuild_flutter/UTI/COMPONENT/IIWaitAni/iiwaitani.dart';
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
    this.getSelfFolderList(true);

    observer.executeAction = (Map<String, dynamic> mapInfo) {
      this.getSelfFolderList(true);
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
           style: TextStyle(fontSize: 18, fontFamily: NSNormalConfig.fontFamily)),
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        child: RefreshIndicator(
          child: ListView.builder(
          itemCount: list.length + 1,
          itemBuilder: (context, i) {
            if (this.list.length == 0) {
              return Center();
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
                list[i - 1], (item) {
                  setState(() {
                    this.list.remove(item);
                  });
                });
          },
        ),
        onRefresh: _loadPageOne,
        )
      ),
    );
  }

  Future<void> _loadPageOne() async {
    await this.getSelfFolderList(false);
  }

  //
  // 获取最新数据
  Future<void> getSelfFolderList(bool havehud) async {
    if (havehud) {
      IIWaitAni.showWait('');
    }
    List<RealGitFileModel> lists;
    if (widget.isNewset) {
      lists = await GitFileProgressBLL().getNewestFileLists();
    } else {
      lists = await GitFileProgressBLL().getOneFolderFileLists(widget.folderid);
    }
    IIWaitAni.hideWait();
    setState(() {
      list = lists;
    });
  }
}
