
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rebuild_flutter/MODEL/Newfile/foldermodel.dart';

class FolderPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FolderPageState();
  }

}

class FolderPageState extends State<FolderPage> {

  List<FolderModel> folderlist = [];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: Text('最新', style: TextStyle(fontSize: 24)),
        trailing: IconButton(icon: Icon(Icons.sync), onPressed: () {

        }),
      ),
      child: ListView.builder(
        itemCount: folderlist.length,
        itemBuilder: (context, i) {

        },
      ),
    );
  }
}

