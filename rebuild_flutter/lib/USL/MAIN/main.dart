
import 'package:rebuild_flutter/USL/TabbarGroup/maintabbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:rebuild_flutter/USL/TEST/testindicate.dart';
import 'package:rebuild_flutter/USL/TEST/fromtable.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
        title: "halo,world",
        theme: ThemeData(
          primaryColor: Colors.white
        ),
        home: MaintabBar(),//IITabbar(),//Stsate(),
      );
  }
}

class IITabbar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return IITabbarState();
  }
  
}

class IITabbarState extends State<IITabbar> {
  List<Widget> infos = [Testindicate(), IITab(), Stsate()];
  Widget currentWig = Testindicate();
  int currentIdx = 0;
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentWig,
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            title: Text('首页'),
            icon: Icon(Icons.home),
            activeIcon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            title: Text('应用'),
            icon: Icon(Icons.apps),
            activeIcon: Icon(Icons.apps),
          ),
          BottomNavigationBarItem(
            title: Text('我的'),
            activeIcon: Icon(Icons.person),
            icon: Icon(Icons.person),
          ),
        ],
        selectedItemColor: Colors.teal,
        currentIndex: currentIdx,
        onTap: (idx) {
          setState(() {
            getWidget(idx);
          });
        },
      ),
    );
  }

  void getWidget(int idx) {
    currentWig = infos[idx];
    currentIdx = idx;
  }
}

class Stsate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: Text('商品列表'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.list),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                    return Testindicate();
                  }));
                },
              )
          ],
          ),
          body: Center(
            child: RondamWord()
          ),
        );
  }

}

class RondamWord extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RondamWordState();
  }
}

class RondamWordState extends State<RondamWord> {
  List<WordPair> _wordsPair = <WordPair>[];

  Set<WordPair> _savedPair = Set<WordPair>();
  
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(15),
      itemBuilder: (context, i){
        if (i.isOdd) { return Divider(); }
        var idx = i ~/ 2;
        if (idx >= _wordsPair.length) {
          var generateWords2 = generateWords();
          _wordsPair.addAll(generateWords2);
        }
        return generateRow(_wordsPair[idx]);
      },
    );
  }

  Widget generateRow(WordPair pair) {
    var _isHaveIt = _savedPair.contains(pair);
    return ListTile(
      title: Text(pair.asPascalCase),
      trailing: Icon(
        _isHaveIt ? Icons.favorite : Icons.favorite_border,
        color: _isHaveIt ? Colors.red : null,
      ),
      onTap: (){
        setState(() {
          _isHaveIt ? _savedPair.remove(pair) : _savedPair.add(pair);
        });
      },
    );
  }

  List<WordPair> generateWords() {
    List<WordPair> list = <WordPair>[];
    for (var i = 0 ; i < 10 ; i++) {
      list.add(WordPair.random());
    }

    return list;
  }

}