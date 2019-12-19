import 'package:fish_redux/fish_redux.dart';
import 'package:rebuild_flutter/USL/ReduxAPP/empty/reduxlist_page/reduxada_adapter/adapter.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class ReduxlistPage extends Page<ReduxlistState, Map<String, dynamic>> {
  ReduxlistPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<ReduxlistState>(
                adapter: NoneConn<ReduxlistState>() + ReduxadaAdapter(),
                slots: <String, Dependent<ReduxlistState>>{
                }),
            middleware: <Middleware<ReduxlistState>>[
            ],);

}
