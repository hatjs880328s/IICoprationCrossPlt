import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<BigcellState> buildEffect() {
  return combineEffects(<Object, Effect<BigcellState>>{
    BigcellAction.action: _onAction,
  });
}

void _onAction(Action action, Context<BigcellState> ctx) {
}
