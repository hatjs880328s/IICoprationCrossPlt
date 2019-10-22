import 'package:rebuild_flutter/USL/TabbarGroup/maintabitem.dart';
import 'package:rebuild_flutter/UTI/COMPONENT/NSActionSheet/nsactionsheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rebuild_flutter/USL/TESTFile/fromtable.dart';
import 'package:rebuild_flutter/USL/NewFile/newestfile.dart';
import 'package:rebuild_flutter/USL/FolderPage/folderpage.dart';
//AnimationPage03
import 'package:rebuild_flutter/USL/FolderPage/newani.dart';

class MaintabBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MaintabBarState();
  }
}

class MaintabBarState extends State<MaintabBar> {
  Widget currentItem = NewestFile();
  int _currentIndex = 0;
  PageController _controller;
  List<Widget> infos = [NewestFile(), FolderPage(), AnimationPage03(), IITab()];

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
            MainTabItem(0, '首页', Icon(Icons.home), (idx) {
              onTap(idx);
            }),
            MainTabItem(1, '书架', Icon(Icons.folder), (idx) {
              onTap(idx);
            }),
            SizedBox(),
            MainTabItem(2, '协作', Icon(Icons.new_releases), (idx) {
              onTap(idx);
            }),
            MainTabItem(3, '我的', Icon(Icons.person), (idx) {
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
              return NSActionSheet();
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
  void createNewFolder() {

  }

  // 新建一个文件
  void createNewFile() {

  }
}
