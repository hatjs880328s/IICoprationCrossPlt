import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum MainAction { action, jump2girdpage }

class MainActionCreator {
  static Action onAction() {
    return const Action(MainAction.action);
  }

  static Action onJump2girdpage() {
    return const Action(MainAction.jump2girdpage);
  }
}
