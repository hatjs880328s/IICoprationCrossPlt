import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<EmptyState> buildReducer() {
  return asReducer(
    <Object, Reducer<EmptyState>>{
      EmptyAction.action: _onAction,
    },
  );
}

EmptyState _onAction(EmptyState state, Action action) {
  final EmptyState newState = state.clone();
  return newState;
}
