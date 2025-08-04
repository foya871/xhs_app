import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SharePageController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  var tabIndex = 0;

  List<Tab> tabs = const [
    Tab(text: "代理赚钱"),
    Tab(text: "福利任务"),
    Tab(text: "应用推荐"),
  ];

  @override
  void onInit() {
    tabIndex = Get.arguments['tabIndex'] ?? 0;
    tabController =
        TabController(length: tabs.length, vsync: this, initialIndex: tabIndex);
    super.onInit();
  }

  /// 新增的切换 Tab 页面函数
  void switchTab(int index) {
    if (index >= 0 && index < tabs.length) {
      tabController.animateTo(index);
      tabIndex = index;
    }
  }
}
