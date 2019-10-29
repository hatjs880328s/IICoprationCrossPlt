import 'package:path/path.dart';
import 'package:rebuild_flutter/BLL/GitFileBLL/gitfilebll.dart';
import 'package:rebuild_flutter/BLL/GitFolderBLL/gitfolderbll.dart';
import 'package:rebuild_flutter/MODEL/Login/nsloginglobal.dart';
import 'package:rebuild_flutter/USL/Login/loginpage.dart';
import 'package:rebuild_flutter/USL/TabbarGroup/maintabitem.dart';
import 'package:rebuild_flutter/UTI/COMPONENT/NSActionSheet/nsactionfield.dart';
import 'package:rebuild_flutter/UTI/COMPONENT/NSActionSheet/nsactionsheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rebuild_flutter/USL/TESTFile/fromtable.dart';
import 'package:rebuild_flutter/USL/NewFile/newestfile.dart';
import 'package:rebuild_flutter/USL/FolderPage/folderpage.dart';
//AnimationPage03
import 'package:rebuild_flutter/USL/FolderPage/newani.dart';
import 'package:rebuild_flutter/UTI/NSNotificationCenter/nsnotificationcenter.dart';

class MaintabBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MaintabBarState();
  }
}

class MaintabBarState extends State<MaintabBar> {
  Widget get currentItem {
    return infos[_currentIndex];
  }

  int _currentIndex = 0;
  PageController _controller;
  List<Widget> infos = [NewestFile(true, "最新", ""), FolderPage(), AnimationPage03(), LoginPage()];

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: _pageChange,
          controller: _controller,
          itemCount: infos.length,
          itemBuilder: (context, index) => this.infos[index]),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 4,
        child: Row(
          children: <Widget>[
            MainTabItem(0, '首页', "images/main_tab_main.png", (idx) {
              onTap(idx);
            }),
            MainTabItem(1, '文件夹', "images/main_tab_bookstore.png", (idx) {
              onTap(idx);
            }),
            SizedBox(),
            MainTabItem(2, '协作', "images/main_tab_group.png", (idx) {
              onTap(idx);
            }),
            MainTabItem(3, '我的', "images/main_tab_person.png", (idx) {
              onTap(idx);
            }),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          return showCupertinoModalPopup(
            context: context,
            builder: (context) {
              NSActionSheet sheet = NSActionSheet();
              sheet.actionOne = (idx) {
                //文件
                this.createNewFile();
              };
              sheet.actionTwo = (idx) {
                //书架
                return showCupertinoDialog(
                  context: context, 
                  builder: (context) {
                    NSActionField fid = NSActionField();
                    fid.actionOne = (String foldername) {
                      this.createNewFolder(foldername);
                    };
                    return fid;
                  }
                );
              };
              return sheet;
            } 
          );
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void onTap(int index) {
    _controller.jumpToPage(index);
  }

  void _pageChange(int index) {
    if (index != _currentIndex) {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  // 新建一个文件夹
  Future<void> createNewFolder(String foldername) async {
    await GitFolderBLL().createFolder(foldername);
    NSNotificationCenter.getInstance().postNotification(NSNormalNotificationObserver().notificationKey, {"result": true});
  }

  // 新建一个文件
  Future<void> createNewFile() async {
    // var model = await NSLoginGlobal.getInstance().getUserInfo();
    // await GitFileBLL().createFile("halowor", "title is halo", model.uid, "最新", "flutter_file_text_create1qqq");
    // NSNotificationCenter.getInstance().postNotification(NSNormalNotificationObserver().notificationKey, {"result": true});
  }
}
