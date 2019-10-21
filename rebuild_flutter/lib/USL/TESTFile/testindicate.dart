import "dart:convert";
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import 'package:rebuild_flutter/USL/TESTFile/fromtable.dart';

/// 网络数据加载 - 有指示器的页面
class Testindicate extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TestindicateState();
  }
}

class TestindicateState extends State<Testindicate> {
  List widgets = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Widget showWhich() {
    if (widgets.length == 0) {
      return buildIndicate();
    }
    return buildListVw();
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('net data'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return IITab();
              }));
            },
          )
        ],
      ),
      body: showWhich(),
    );
  }

  /// list vw
  Widget buildListVw() {
    return ListView.builder(
      itemCount: widgets.length,
      itemBuilder: (context, i) {
        return GestureDetector(
          child: Padding(
              padding: EdgeInsets.all(12), child: Text(widgets[i]["title"])),
          onTap: () {
            return showDialog(
                context: context,
                builder: (context) {
                  return CupertinoAlertDialog(
                    title: Text(widgets[i]["title"]),
                    content: Text(widgets[i]["body"]),
                  );
                });
          },
        );
      },
    );
  }

  /// 指示器
  Widget buildIndicate() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  void loadData() async {
    String strInfo = "https://jsonplaceholder.typicode.com/posts";
    http.Response response = await http.get(strInfo);
    setState(() {
      widgets = json.decode(response.body);
    });
  }
}
