import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/widgets.dart';

import '../../safe_state.dart';
import '../base_data_keeper.dart';
import '../base_refresh_data_keeper.dart';
import '../base_refresh_page_counter.dart';

abstract class BaseRefreshSimpleState<T extends StatefulWidget, E>
    extends SafeState<T>
    with BaseDataKeeper<E>, BaseRefreshPageCounter, BaseRefreshDataKeeper {
  final refreshController = EasyRefreshController();
  @override
  bool get useObs => false;

  @override
  void onDataChange() {
    setState(() {});
    super.onDataChange();
  }

  @override
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }
}
