import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<GirdState> buildEffect() {
  return combineEffects(<Object, Effect<GirdState>>{
    GirdAction.action: _onAction,
  });
}

void _onAction(Action action, Context<GirdState> ctx) {
}
