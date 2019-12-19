import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class BigcellComponent extends Component<BigcellState> {
  BigcellComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<BigcellState>(
                adapter: null,
                slots: <String, Dependent<BigcellState>>{
                }),);

}
