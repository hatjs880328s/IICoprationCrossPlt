import 'package:fish_redux/fish_redux.dart';
import 'package:rebuild_flutter/MODEL/Login/nsloginglobal.dart';

class GirdState implements Cloneable<GirdState> {

  List<NSLoginGlobal> users;

  @override
  GirdState clone() {
    return GirdState()
    ..users = users;
  }
}

GirdState initState(Map<String, dynamic> args) {
  return GirdState();
}
