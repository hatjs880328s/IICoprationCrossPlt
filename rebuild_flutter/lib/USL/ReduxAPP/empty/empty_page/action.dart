import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum EmptyAction { action }

class EmptyActionCreator {
  static Action onAction() {
    return const Action(EmptyAction.action);
  }
}
