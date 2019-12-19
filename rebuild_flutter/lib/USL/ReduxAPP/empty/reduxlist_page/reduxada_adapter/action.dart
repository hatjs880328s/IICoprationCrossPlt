import 'package:fish_redux/fish_redux.dart';

enum ReduxadaAction { action, add }

class ReduxadaActionCreator {
  static Action onAction() {
    return const Action(ReduxadaAction.action);
  }

  static Action add() {
    return const Action(ReduxadaAction.add);
  }
}
