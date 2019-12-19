import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(GirdState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    appBar: AppBar(
      title: Text('gird list'),
    ),
    body: new GridView.count(
      crossAxisCount: 2,//列数
      crossAxisSpacing: 20.0,// 左右间隔
      mainAxisSpacing: 20.0,// 上下间隔
      childAspectRatio: 1 / 1, //宽高比
      padding: EdgeInsets.all(20),
      children: new List.generate(state.users.length, (index) {//使用state里面的models生成列表
        return Center(
          child: Card(
            color: Colors.lightBlueAccent,
            child: InkWell(
              splashColor: Colors.blue.withAlpha(100),
              onTap: () {
                dispatch(GirdActionCreator.onListview());
              },
              child: Container(
                width: 200,
                height: 200,
                child: Center(
                  child: Text(state.users[index].userInfoKey),//展示name字段
                ),
              ),
            ),
          ));
      }),
  ));
}
