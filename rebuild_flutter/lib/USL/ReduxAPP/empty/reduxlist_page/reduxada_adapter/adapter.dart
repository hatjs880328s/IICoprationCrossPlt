import 'package:fish_redux/fish_redux.dart';
import 'package:rebuild_flutter/USL/ReduxAPP/Components/bigcell_component/component.dart';
import 'package:rebuild_flutter/USL/ReduxAPP/empty/reduxlist_page/state.dart';

import 'reducer.dart';

class ReduxadaAdapter extends SourceFlowAdapter<ReduxlistState> {
  ReduxadaAdapter()
      : super(
          pool: <String, Component<Object>>{
            'item': BigcellComponent(),
          },
          reducer: buildReducer(),
        );
}
