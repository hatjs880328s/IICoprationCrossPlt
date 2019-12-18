import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<GirdState> buildReducer() {
  return asReducer(
    <Object, Reducer<GirdState>>{
      GirdAction.action: _onAction,
    },
  );
}

GirdState _onAction(GirdState state, Action action) {
  final GirdState newState = state.clone();
  return newState;
}
