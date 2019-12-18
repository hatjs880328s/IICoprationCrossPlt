import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class GirdPage extends Page<GirdState, Map<String, dynamic>> {
  GirdPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<GirdState>(
                adapter: null,
                slots: <String, Dependent<GirdState>>{
                }),
            middleware: <Middleware<GirdState>>[
            ],);

}
