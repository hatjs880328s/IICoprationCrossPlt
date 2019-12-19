import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<BigcellState> buildReducer() {
  return asReducer(
    <Object, Reducer<BigcellState>>{
      BigcellAction.action: _onAction,
    },
  );
}

BigcellState _onAction(BigcellState state, Action action) {
  final BigcellState newState = state.clone();
  return newState;
}
