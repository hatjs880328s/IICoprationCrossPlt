import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter/widgets.dart' hide Action;
import 'action.dart';
import 'state.dart';

Effect<MainState> buildEffect() {
  return combineEffects(<Object, Effect<MainState>>{
    MainAction.action: _onAction,
    MainAction.jump2girdpage: _onJump2girdpage,
  });
}

void _onAction(Action action, Context<MainState> ctx) {
}

void _onJump2girdpage(Action action, Context<MainState> ctx) {
  Navigator.of(ctx.context).pushNamed('girdpage', arguments: null);
}
