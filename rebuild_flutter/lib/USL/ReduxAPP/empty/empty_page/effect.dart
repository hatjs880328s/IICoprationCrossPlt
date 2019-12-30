import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<EmptyState> buildEffect() {
  return combineEffects(<Object, Effect<EmptyState>>{
    EmptyAction.action: _onAction,
  });
}

void _onAction(Action action, Context<EmptyState> ctx) {
}
