import 'package:fish_redux/fish_redux.dart';
import 'package:rebuild_flutter/USL/ReduxAPP/Components/bigcell_component/state.dart';
import 'package:rebuild_flutter/USL/ReduxAPP/empty/reduxlist_page/state.dart';

import 'action.dart';

Reducer<ReduxlistState> buildReducer() {
  return asReducer(
    <Object, Reducer<ReduxlistState>>{
      ReduxadaAction.action: _onAction,
      ReduxadaAction.add: _onAdd,
    },
  );
}

ReduxlistState _onAction(ReduxlistState state, Action action) {
  final ReduxlistState newState = state.clone();
  return newState;
}

ReduxlistState _onAdd(ReduxlistState state, Action action) {
  final ReduxlistState newState = state.clone();
  newState.infos = [BigcellState(), BigcellState()];
  return newState;
}
