import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rebuild_flutter/UTI/COMPONENT/NSSearchComponent/nssearchbar.dart';
import 'package:rebuild_flutter/BLL/GitFileBLL/gitfilebll.dart';
import 'package:rebuild_flutter/MODEL/Newfile/foldermodel.dart';
import 'package:rebuild_flutter/USL/NewFile/filelistcell.dart';
import 'package:rebuild_flutter/UTI/COMPONENT/NSSearchComponent/nsnormalsearchbar.dart';
import 'package:rebuild_flutter/BLL/AppBll/nsnormalconfig.dart';

/// 最新文章列表页面 - tab首屏
class NewestFile extends StatefulWidget {
  State<StatefulWidget> createState() => NewestFileState();
}

class NewestFileState extends State<NewestFile> with AutomaticKeepAliveClientMixin {

  List<FolderModel> list = [];

  @override
  bool get wantKeepAlive => true;

  @override 
  initState() {
    super.initState();
    this.getSelfFolderList();
  }

  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: Colors.white,
        border: Border(bottom: BorderSide.none),
        leading: Text('最新', style: TextStyle(fontSize: 24, fontFamily: NSNormalConfig.fontFamily)),
        trailing: IconButton(icon: Icon(Icons.sync), onPressed: () {
            this.getSelfFolderList();
          }),
      ),
      child: Container(
        child: ListView.builder(
          itemCount: list.length + 1,
          itemBuilder: (context, i) {
            if (i == 0) {
              NSNormalSearchBar search = NSNormalSearchBar();
              search.onTap = (int) {
                showSearch(context: context, delegate: nssearchbarDelegate());
              };
              return search;
            }
            return FileListCell(title: list[i - 1].getTitleInfo(), img: "", time: list[i - 1].getCreateTime());
          },
        ),
      ),
    );
  }

  // 
  // 获取最新数据
  void getSelfFolderList() async {
    List<FolderModel> lists = await GitFileBLL().getNewestInfosWithUserid();
    list = lists;
    setState(() {
      list = lists;
    });
  }

  // 创建一个新文件 - 然后刷新
  // void createFile() async {
  //   await GitFileBLL().createFile("halowor", "title is halo", "shanwzh", "最新", "flutter_file_text_create");
  //   this.getSelfFolderList();
  // }
}