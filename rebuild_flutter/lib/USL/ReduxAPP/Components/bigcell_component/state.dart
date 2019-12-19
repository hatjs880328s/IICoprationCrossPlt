import 'package:fish_redux/fish_redux.dart';

class BigcellState implements Cloneable<BigcellState> {

  @override
  BigcellState clone() {
    return BigcellState();
  }
}

BigcellState initState(Map<String, dynamic> args) {
  return BigcellState();
}
