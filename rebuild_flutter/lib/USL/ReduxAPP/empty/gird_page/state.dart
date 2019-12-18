import 'package:fish_redux/fish_redux.dart';

class GirdState implements Cloneable<GirdState> {

  @override
  GirdState clone() {
    return GirdState();
  }
}

GirdState initState(Map<String, dynamic> args) {
  return GirdState();
}
