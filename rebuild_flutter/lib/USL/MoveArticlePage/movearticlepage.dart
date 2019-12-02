import 'dart:math';
import 'package:rebuild_flutter/BLL/AppBll/nsnormalconfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rebuild_flutter/BLL/gitbll/gitfilemoveprogressbll.dart';
import 'package:rebuild_flutter/BLL/gitbll/gitfileprogressbll.dart';
import 'package:rebuild_flutter/MODEL/CoperationGroup/coperationgroupmodel.dart';
import 'package:rebuild_flutter/MODEL/Newfile/foldermodel.dart';
import 'package:rebuild_flutter/MODEL/Newfile/realgitfilemodel.dart';
import 'package:rebuild_flutter/USL/MoveArticlePage/movearticlepagecell.dart';
import 'package:rebuild_flutter/UTI/COMPONENT/IIWaitAni/iiwaitani.dart';
import 'package:rebuild_flutter/UTI/COMPONENT/NSSearchComponent/nsnormalsearchbar.dart';
import 'package:rebuild_flutter/UTI/COMPONENT/NSSearchComponent/nssearchbar.dart';

class MoveArticlePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MoveArticlePageState();
  }

  RealGitFileModel originFile;

  MoveArticlePage(RealGitFileModel originFile) {
    this.originFile = originFile;
  }
}

class MoveArticlePageState extends State<MoveArticlePage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  List<FolderModel> folderlist = [];

  List<int> selectedIdx = [];

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
              return Center();
            }
            if (i == 0) {
              NSNormalSearchBar search = NSNormalSearchBar();
              search.onTap = (int) {
                showSearch(context: context, delegate: nssearchbarDelegate());
              };
              return search;
            }
            return MoveArticlePageCell(this.selectedIdx.contains(i - 1), folderlist[i - 1],
             () {
                 selectOrDeselect(i - 1); 
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

  /// 选中与取消选中
  void selectOrDeselect(int idx) {
    if (this.selectedIdx.contains(idx)) {
      this.selectedIdx.remove(idx);
    } else {
      this.selectedIdx.add(idx);
    }
    this.moveAction(idx);
    setState(() {
      
    });
  }

  /// 移动处理
  Future<void> moveAction(int idx) async {
    IIWaitAni.showWait('移动中,请稍候');
    FolderModel currentFolder = this.folderlist[idx];
    var originFile = this.widget.originFile;
    var bll = GitFileMoveProgressBLL();
    await bll.moveFileProgress(originFile, currentFolder);
    IIWaitAni.hideWait();
  }

  Future<void> loadData(bool havehud) async {
    if (havehud) {
      IIWaitAni.showWait('');
    }
    var filebll = GitFileProgressBLL();
    var infos = await filebll.getOneUsersAllFolders(true);
    IIWaitAni.hideWait();
    setState(() {
      this.folderlist = infos;
    });
  }
}
