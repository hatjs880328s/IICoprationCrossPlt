import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'action.dart';
import 'state.dart';

Effect<GirdState> buildEffect() {
  return combineEffects(<Object, Effect<GirdState>>{
    GirdAction.action: _onAction,
    Lifecycle.initState: _onInit,
    GirdAction.onListview: _onlistView,
  });
}

void _onAction(Action action, Context<GirdState> ctx) {
}

void _onInit(Action action, Context<GirdState> ctx) {
  ctx.dispatch(GirdActionCreator.onLoadData());
}

void _onlistView(Action action, Context<GirdState> ctx) {
  Navigator.of(ctx.context).pushNamed('reduxlist');
}
