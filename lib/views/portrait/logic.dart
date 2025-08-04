import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../http/api/api.dart';
import '../../model/portrait/portrait_model.dart';
import 'state.dart';

class PortraitLogic extends GetxController with StateMixin, GetTickerProviderStateMixin {
  final tabs = <PortraitModel>[];
  TabController? tabController;
  final PortraitState state = PortraitState();
  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    final resp = await Api.getApiPortraitClassify();
    if (resp != null) {
      tabs.addAll(resp);
    }
    tabController = TabController(
      length: tabs.length,
      vsync: this,
      initialIndex: 0,
    );
  }
}
