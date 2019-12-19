import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum BigcellAction { action }

class BigcellActionCreator {
  static Action onAction() {
    return const Action(BigcellAction.action);
  }
}
