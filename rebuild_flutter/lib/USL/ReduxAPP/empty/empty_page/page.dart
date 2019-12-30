import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class EmptyPage extends Page<EmptyState, Map<String, dynamic>> {
  EmptyPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<EmptyState>(
                adapter: null,
                slots: <String, Dependent<EmptyState>>{
                }),
            middleware: <Middleware<EmptyState>>[
            ],);

}
