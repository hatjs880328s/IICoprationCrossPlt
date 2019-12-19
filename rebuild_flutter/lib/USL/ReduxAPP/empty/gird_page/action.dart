import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum GirdAction { action, loaddata, onListview }

class GirdActionCreator {
  static Action onAction() {
    return const Action(GirdAction.action);
  }

  static Action onLoadData() {
    return const Action(GirdAction.loaddata);
  }

  static Action onListview() {
    return const Action(GirdAction.onListview);
  }
}
