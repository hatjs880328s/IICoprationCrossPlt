import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rebuild_flutter/USL/TEST/fromtable.dart';
import 'package:rebuild_flutter/USL/TEST/testindicate.dart';
import 'package:rebuild_flutter/USL/MAIN/main.dart';
import 'package:rebuild_flutter/USL/NewFile/newestfile.dart';

class MaintabBar extends StatefulWidget {
  List<Widget> infos = [NewestFile(), IITab(), Stsate(), Stsate()];
  @override
  State<StatefulWidget> createState() {
    return MaintabBarState();
  }
}

class MaintabBarState extends State<MaintabBar> {
  
  Widget currentItem = NewestFile();
  int currentIdx = 0;
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentItem,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 4,
        child: Row(
          children: <Widget>[
            IconButton(icon: Icon(Icons.home), onPressed: () { this.selectItem(0); }),
            IconButton(icon: Icon(Icons.chat), onPressed: () {this.selectItem(1);}),
            SizedBox(),
            IconButton(icon: Icon(Icons.apps), onPressed: () {this.selectItem(2);}),
            IconButton(icon: Icon(Icons.person), onPressed: () {this.selectItem(3);})
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

  void selectItem(int idx) {
    setState(() {
      currentIdx = idx;
      currentItem = widget.infos[idx];
    });
    
  }
}

