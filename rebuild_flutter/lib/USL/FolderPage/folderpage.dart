
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rebuild_flutter/MODEL/Newfile/foldermodel.dart';
import 'package:rebuild_flutter/USL/FolderPage/folderpagecell.dart';
import 'package:rebuild_flutter/BLL/GitFileBLL/gitfilebll.dart';
import 'package:rebuild_flutter/UTI/COMPONENT/NSSearchComponent/nsnormalsearchbar.dart';
import 'package:rebuild_flutter/UTI/COMPONENT/NSSearchComponent/nssearchbar.dart';

class FolderPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FolderPageState();
  }

}

class FolderPageState extends State<FolderPage> with AutomaticKeepAliveClientMixin {

  
  List<FolderModel> folderlist = [];

  @override
  bool get wantKeepAlive => true;

  @override 
  void initState() {
    super.initState();
    this.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: Text('文件夹', style: TextStyle(fontSize: 24)),
        trailing: IconButton(icon: Icon(Icons.sync), onPressed: () {
          this.loadData();
        }),
      ),
      child: ListView.builder(
        itemCount: folderlist.length + 1,
        itemBuilder: (context, i) {
          if (i == 0) {
            NSNormalSearchBar search = NSNormalSearchBar();
              search.onTap = (int) {
                showSearch(context: context, delegate: nssearchbarDelegate());
              };
              return search;
          }
          return FolderPageCell(folderlist[i - 1].getTitleInfo(), folderlist[i - 1].getCreateTime());
        },
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
}

