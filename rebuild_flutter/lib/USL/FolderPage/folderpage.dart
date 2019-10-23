import 'dart:ffi';
import 'dart:math';
import 'package:flutter/src/scheduler/ticker.dart';
import 'package:rebuild_flutter/BLL/AppBll/nsnormalconfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rebuild_flutter/MODEL/Newfile/foldermodel.dart';
import 'package:rebuild_flutter/USL/FolderPage/folderpagecell.dart';
import 'package:rebuild_flutter/BLL/GitFileBLL/gitfilebll.dart';
import 'package:rebuild_flutter/USL/NewFile/newestfile.dart';
import 'package:rebuild_flutter/UTI/COMPONENT/NSSearchComponent/nsnormalsearchbar.dart';
import 'package:rebuild_flutter/UTI/COMPONENT/NSSearchComponent/nssearchbar.dart';
import 'package:rebuild_flutter/UTI/COMPONENT/IIAnimationColor/iianimationcolor.dart';

class FolderPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FolderPageState();
  }
}

class FolderPageState extends State<FolderPage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  List<FolderModel> folderlist = [];

  @override
  bool get wantKeepAlive => true;

  AnimationController controller;
  Animation<double> animationIns;
  CurvedAnimation curve;
  bool isForward = false;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);
    curve = CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);
    animationIns = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    controller.forward();
    this.loadData();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('文件夹',
            style:
                TextStyle(fontSize: 24, fontFamily: NSNormalConfig.fontFamily)),
        actions: <Widget>[
          Transform.rotate(
              angle: curve.value * pi,
              child: IconButton(
                  icon: Icon(Icons.sync),
                  onPressed: () {
                    isForward ? controller.reverse() : controller.forward();
                    isForward = !isForward;
                    this.loadData();
                  }))
        ],
      ),
      body: Container(
        color: Colors.white,
        child: ListView.builder(
          itemCount: folderlist.length + 1,
          itemBuilder: (context, i) {
            if (this.folderlist.length == 0) {
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
            return FolderPageCell(folderlist[i - 1].getTitleInfo(),
                folderlist[i - 1].getCreateTime(), () {
                  this.goFilelistPage(i - 1);
                });
          },
        ),
      ),
    );
  }

  void loadData() async {
    GitFileBLL bll = GitFileBLL();
    List<FolderModel> models = await bll.getUserFolders();
    setState(() {
      this.folderlist = models;
    });
  }

  void goFilelistPage(int idx) {
    NewestFile page = NewestFile(false, folderlist[idx].name, folderlist[idx].name);

    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return page;
    }));
  }
}
