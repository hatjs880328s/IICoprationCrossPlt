import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:rebuild_flutter/USL/ReduxAPP/empty/reduxlist_page/reduxada_adapter/action.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(ReduxlistState state, Dispatch dispatch, ViewService viewService) {

  var adapter = viewService.buildAdapter();

  return Scaffold(
    appBar: AppBar(
      title: Text('redux list view')
    ),
    body: ListView.builder(
      itemCount: adapter.itemCount,
      itemBuilder: (context, idx) {
        return Text('halo %idx');
      },
    ),
    floatingActionButton: IconButton(icon: Icon(Icons.add), onPressed: () {
      dispatch(ReduxadaActionCreator.add());
    },),
  );
}
