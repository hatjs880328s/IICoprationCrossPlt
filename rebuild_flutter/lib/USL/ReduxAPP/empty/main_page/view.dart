import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(MainState state, Dispatch dispatch, ViewService viewService) {
  return Center(
    child: GestureDetector(
      child: Text('button'),
      onTap: () {
        dispatch(MainActionCreator.onJump2girdpage());
      },
    )
  );
}
