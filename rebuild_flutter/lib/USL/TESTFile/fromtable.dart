import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IITab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => IITabState();
}

class IITabState extends State<IITab> {
  final controller = TextEditingController();

  String _errorTxt = '';

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('FORM TAB')),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: TextField(
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
              hintText: 'enter your name...', 
              labelText: '用户名',
              errorText: getErrorStr(), 
              prefixIcon: Icon(Icons.verified_user, color: Colors.red),
              suffixIcon: IconButton(icon: Icon(Icons.clear, color: Colors.red,), onPressed: () {
                setState(() {
                  controller.clear();
                });
              },)
            ),
            onSubmitted: (str) {
              setState(() {
                if (str != 'halo') {
                  _errorTxt = null;
                } else {
                  _errorTxt = '输入内容不符合标准';
                }
              });
            },
            controller:controller
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          return showDialog(
            context: context,
            builder: (context) {
              return CupertinoAlertDialog(
                title: Text('提醒', style: TextStyle(color: Colors.black, fontSize: 17, letterSpacing: 2)),
                content: Text(controller.text, style: TextStyle(color: Colors.black, fontSize: 14, letterSpacing: 1.2)),
              );
            }
          );
        },
      ),
    );
  }

  String getErrorStr() {
    return _errorTxt;
  }
}