import 'package:fish_redux/fish_redux.dart';
import 'package:rebuild_flutter/MODEL/Login/nsloginglobal.dart';

import 'action.dart';
import 'state.dart';

Reducer<GirdState> buildReducer() {
  return asReducer(
    <Object, Reducer<GirdState>>{
      GirdAction.action: _onAction,
      GirdAction.loaddata: _onLoadData,
    },
  );
}

GirdState _onAction(GirdState state, Action action) {
  final GirdState newState = state.clone();
  return newState;
}

GirdState _onLoadData(GirdState state, Action action) {
  final GirdState newState = state.clone()..users = [NSLoginGlobal(), NSLoginGlobal()];
  return newState;
}
