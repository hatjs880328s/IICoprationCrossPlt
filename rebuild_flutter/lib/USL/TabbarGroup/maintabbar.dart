import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rebuild_flutter/USL/TEST/fromtable.dart';
import 'package:rebuild_flutter/USL/TEST/testindicate.dart';
import 'package:rebuild_flutter/USL/MAIN/main.dart';
import 'package:rebuild_flutter/USL/NewFile/newestfile.dart';

class MaintabBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MaintabBarState();
  }
}

class MaintabBarState extends State<MaintabBar> {
  List<Widget> infos = [NewestFile(), IITab(), Stsate()];
  Widget currentItem = NewestFile();
  int currentIdx = 0;
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentItem,
      bottomNavigationBar: CupertinoTabBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('首页'), activeIcon: Icon(Icons.home)),
          BottomNavigationBarItem(icon: Icon(Icons.apps), title: Text('应用'), activeIcon: Icon(Icons.apps)),
          BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('我的'), activeIcon: Icon(Icons.person))
        ],
        currentIndex: currentIdx,
        onTap: (idx) {
          this.selectItem(idx);
        },
      ),
    );
  }

  void selectItem(int idx) {
    setState(() {
      currentIdx = idx;
      currentItem = infos[idx];
    });
    
  }
}

