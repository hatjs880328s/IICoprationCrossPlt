import 'package:fish_redux/fish_redux.dart';
import 'package:rebuild_flutter/USL/ReduxAPP/Components/bigcell_component/state.dart';

class ReduxlistState extends MutableSource implements Cloneable<ReduxlistState> {

  List<BigcellState> infos;

  @override
  ReduxlistState clone() {
    return ReduxlistState()
    ..infos = infos;
  }

  @override
  Object getItemData(int index) {
    return this.infos[index];
  }

  @override
  String getItemType(int index) {
    return 'item';
  }

  @override
  int get itemCount => infos?.length ?? 0;

  @override
  void setItemData(int index, Object data) {
    this.infos[index] = data;
  }
}

ReduxlistState initState(Map<String, dynamic> args) {
  return ReduxlistState();
}
