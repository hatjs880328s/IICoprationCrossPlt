import 'package:fish_redux/fish_redux.dart';
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
  Widget currentItem = NewestFile();
  int _currentIndex = 0;
  PageController _controller;
  List<Widget> infos = [NewestFile(), IITab(), Stsate(), Stsate()];

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
            IconButton(
                icon: Icon(Icons.home),
                onPressed: () {
                  onTap(0);
                }),
            IconButton(
                icon: Icon(Icons.folder),
                onPressed: () {
                  onTap(1);
                }),
            SizedBox(),
            IconButton(
                icon: Icon(Icons.new_releases),
                onPressed: () {
                  onTap(2);
                }),
            IconButton(
                icon: Icon(Icons.person),
                onPressed: () {
                  onTap(3);
                })
          ],
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
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
}
