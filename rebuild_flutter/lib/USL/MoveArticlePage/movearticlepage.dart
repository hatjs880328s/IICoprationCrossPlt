import 'dart:math';
import 'package:rebuild_flutter/BLL/AppBll/nsnormalconfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rebuild_flutter/BLL/gitbll/gitfileprogressbll.dart';
import 'package:rebuild_flutter/MODEL/CoperationGroup/coperationgroupmodel.dart';
import 'package:rebuild_flutter/USL/MoveArticlePage/movearticlepagecell.dart';
import 'package:rebuild_flutter/UTI/COMPONENT/IIWaitAni/iiwaitani.dart';
import 'package:rebuild_flutter/UTI/COMPONENT/NSSearchComponent/nsnormalsearchbar.dart';
import 'package:rebuild_flutter/UTI/COMPONENT/NSSearchComponent/nssearchbar.dart';

class MoveArticlePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MoveArticlePageState();
  }
}

class MoveArticlePageState extends State<MoveArticlePage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  List<CoperationGroupModel> folderlist = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    this.loadData(true);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('选择文件夹',
            style:
                TextStyle(fontSize: 18, fontFamily: NSNormalConfig.fontFamily)),
      ),
      body: RefreshIndicator(
        child: Container(
        color: Colors.white,
        child: ListView.builder(
          itemCount: folderlist.length + 1,
          itemBuilder: (context, i) {
            if (this.folderlist.length == 0) {
              return Center(
                      );
            }
            if (i == 0) {
              NSNormalSearchBar search = NSNormalSearchBar();
              search.onTap = (int) {
                showSearch(context: context, delegate: nssearchbarDelegate());
              };
              return search;
            }
            return MoveArticlePageCell(true, folderlist[i - 1],
             () {
                  //this.goFilelistPage(i - 1);
                });
          },
        ),
      ),
      onRefresh: this._loadPageOne,
      )
    );
  }

  Future<void> _loadPageOne() async {
    await this.loadData(false);
  }

  Future<void> loadData(bool havehud) async {
    if (havehud) {
      IIWaitAni.showWait('');
    }
    var filebll = GitFileProgressBLL();
    var infos = await filebll.getOneUsersAllFolders(true);
    IIWaitAni.hideWait();
    setState(() {
      this.folderlist = infos.dirs;
    });
  }
}
