import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rebuild_flutter/UTI/COMPONENT/nssearchbar.dart';
import 'package:rebuild_flutter/BLL/GitFileBLL/gitfilebll.dart';
import 'package:rebuild_flutter/MODEL/Newfile/foldermodel.dart';
import 'package:rebuild_flutter/UTI/COMPONENT/filelistcell.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text('最新'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.sync), onPressed: () {
            this.createFile();
          },),
          IconButton(icon: Icon(Icons.search), onPressed: () {
            showSearch(context: context, delegate: nssearchbarDelegate());
        }),
        ],
      ),
      body: Container(
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, i) {
            return FileListCell(title: list[i].getTitleInfo(), img: "", time: list[i].getCreateTime());
          },
        ),
      ),
    );
  }

  // 获取最新数据
  void getSelfFolderList() async {
    List<FolderModel> lists = await GitFileBLL().getNewestInfosWithUserid();
    list = lists;
    setState(() {
      list = lists;
    });
  }

  // 创建一个新文件 - 然后刷新
  void createFile() async {
    await GitFileBLL().createFile("halowor", "title is halo", "shanwzh", "最新", "flutter_file_text_create");
    this.getSelfFolderList();
  }
}