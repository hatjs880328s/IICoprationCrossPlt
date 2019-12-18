import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum GirdAction { action }

class GirdActionCreator {
  static Action onAction() {
    return const Action(GirdAction.action);
  }
}
