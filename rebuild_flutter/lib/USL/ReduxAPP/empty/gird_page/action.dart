import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum GirdAction { action, loaddata }

class GirdActionCreator {
  static Action onAction() {
    return const Action(GirdAction.action);
  }

  static Action onLoadData() {
    return const Action(GirdAction.loaddata);
  }
}
