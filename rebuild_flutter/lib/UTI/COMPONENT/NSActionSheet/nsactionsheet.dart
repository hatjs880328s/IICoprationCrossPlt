import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class NSActionSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      title: Text("创建文件与文件夹", style: TextStyle(fontSize: 16)),
      message: Text("新建文件默认放到最新目录下", style: TextStyle(fontSize: 14, color: Colors.grey)),
      cancelButton: Container(
        height: 35,
        padding: EdgeInsets.all(5),
        child: Text(
          "取消", 
          style: TextStyle(
            fontSize: 16, 
            decoration: TextDecoration.none),
          textAlign: TextAlign.center,),
      ),
      actions: <Widget>[
        GestureDetector(
          onTap: () {

          },
          child: Container(
            padding: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.filter_1),
                Container(width: 15,),
                Text(
                  "新建文件", 
                  style: TextStyle(
                    fontSize: 15, 
                    decoration: TextDecoration.none, 
                    color: Colors.black), 
                  textAlign: TextAlign.center),
              ],
            ),
          ),
        ),
        Divider(height: 0.5, color: Colors.grey, endIndent: 0.0),
        GestureDetector(
          onTap: () {
            
          },
          child: Container(
            padding: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.folder_open),
                Container(width: 15,),
                Text(
                  "新建书架", 
                  style: TextStyle(
                    fontSize: 15, 
                    decoration: TextDecoration.none, 
                    color: Colors.black), 
                  textAlign: TextAlign.center,),
              ],
            ),
          ),
        )
      ],
    );
  }
}