import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/app_service.dart';

class ShiPinTabController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late final TabController tabController;

  @override
  void onInit() {
    final appService = Get.find<AppService>();
    int initialIndex = 0;
    if (appService.shiPinTabs.length >= 2) {
      initialIndex = 1;
    }
    tabController = TabController(
      length: appService.shiPinTabs.length,
      initialIndex: initialIndex,
      vsync: this,
    );

    super.onInit();
  }
}
