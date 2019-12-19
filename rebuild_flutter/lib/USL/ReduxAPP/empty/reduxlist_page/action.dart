import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum ReduxlistAction { action }

class ReduxlistActionCreator {
  static Action onAction() {
    return const Action(ReduxlistAction.action);
  }
}
