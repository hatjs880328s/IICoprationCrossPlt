import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ReduxlistState> buildReducer() {
  return asReducer(
    <Object, Reducer<ReduxlistState>>{
      ReduxlistAction.action: _onAction,
    },
  );
}

ReduxlistState _onAction(ReduxlistState state, Action action) {
  final ReduxlistState newState = state.clone();
  return newState;
}
