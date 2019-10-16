import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rebuild_flutter/USL/fromtable.dart';
import 'package:rebuild_flutter/USL/testindicate.dart';
import 'package:rebuild_flutter/main.dart';

class MaintabBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MaintabBarState();
  }
}

class MaintabBarState extends State<MaintabBar> {
  List<Widget> infos = [Testindicate(), IITab(), Stsate()];
  Widget currentItem = Stsate();
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

