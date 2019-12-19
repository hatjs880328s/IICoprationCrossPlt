import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<ReduxlistState> buildEffect() {
  return combineEffects(<Object, Effect<ReduxlistState>>{
    ReduxlistAction.action: _onAction,
  });
}

void _onAction(Action action, Context<ReduxlistState> ctx) {
}
