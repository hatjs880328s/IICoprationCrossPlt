import 'package:rebuild_flutter/BLL/gitbll/gitfileprogressbll.dart';
import 'package:rebuild_flutter/USL/CoperationGroup/coperationgroup.dart';
import 'package:rebuild_flutter/USL/CreateFile/createNewestFile.dart';
import 'package:rebuild_flutter/USL/PersonCenter/personcenter.dart';
import 'package:rebuild_flutter/USL/TabbarGroup/maintabitem.dart';
import 'package:rebuild_flutter/UTI/COMPONENT/NSActionSheet/nsactionfield.dart';
import 'package:rebuild_flutter/UTI/COMPONENT/NSActionSheet/nsactionsheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rebuild_flutter/USL/NewFile/newestfile.dart';
import 'package:rebuild_flutter/USL/FolderPage/folderpage.dart';
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
  List<Widget> infos = [
    NewestFile(true, "最新", ""),
    FolderPage(),
    CoperationGroup(),
    PersonCenter()
  ];

  /// 选中与非选中背景色
  List<Color> itemColor = [
    Colors.blue[300],
    Colors.white,
    Colors.white,
    Colors.white
  ];

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  Widget build(BuildContext contexts) {
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
            MainTabItem(this.itemColor[0], 0, '首页', "images/main_tab_main.png", (idx) {
              onTap(idx);
            }),
            MainTabItem(this.itemColor[1], 1, '文件夹', "images/main_tab_bookstore.png", (idx) {
              onTap(idx);
            }),
            SizedBox(),
            MainTabItem(this.itemColor[2], 2, '协作', "images/main_tab_group.png", (idx) {
              onTap(idx);
            }),
            MainTabItem(this.itemColor[3], 3, '我的', "images/main_tab_person.png", (idx) {
              onTap(idx);
            }),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          return showCupertinoModalPopup(
              context: contexts,
              builder: (context) {
                NSActionSheet sheet = NSActionSheet();
                sheet.actionOne = (idx) {
                  //文件
                  this.createNewFile(contexts);
                };
                sheet.actionTwo = (idx) {
                  //书架
                  return showCupertinoDialog(
                      context: context,
                      builder: (context) {
                        NSActionField fid =
                            NSActionField("创建文件夹", "请输入文件夹名称", "创建");
                        fid.actionOne = (String foldername) {
                          this.createNewFolder(foldername);
                        };
                        return fid;
                      });
                };
                return sheet;
              });
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void onTap(int index) {
    _controller.jumpToPage(index);
    this.changeBgColor(index);
  }

  void _pageChange(int index) {
    if (index != _currentIndex) {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  void changeBgColor(int idx) {
    for (var i = 0 ; i < this.itemColor.length ; i++) {
      if ( idx == i ) {
        this.itemColor[idx] = Colors.blue[300];
      } else {
        this.itemColor[i] = Colors.white;
      }
    }
    setState(() {
      
    });
  }

  // 新建一个文件夹
  Future<void> createNewFolder(String foldername) async {
    var bll = GitFileProgressBLL();
    await bll.createFolder(true, foldername);
    NSNotificationCenter.getInstance().postNotification(
        NSNormalNotificationObserver().notificationKey, {"result": true});
  }

  // 新建一个文件
  Future<void> createNewFile(BuildContext context) async {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return CreatNewestFile();
    }));
  }
}
