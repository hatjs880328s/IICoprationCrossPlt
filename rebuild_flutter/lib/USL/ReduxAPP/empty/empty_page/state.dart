import 'package:fish_redux/fish_redux.dart';

class EmptyState implements Cloneable<EmptyState> {

  @override
  EmptyState clone() {
    return EmptyState();
  }
}

EmptyState initState(Map<String, dynamic> args) {
  return EmptyState();
}
