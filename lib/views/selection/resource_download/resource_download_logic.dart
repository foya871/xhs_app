import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xhs_app/views/selection/resource_download/resource_download_controller.dart';
import '../../../model/video/community_resource_classify_model.dart';

import '../../../http/api/api.dart';
import 'resource_download_state.dart';

class ResourceDownloadLogic extends GetxController
    with GetTickerProviderStateMixin {
  final ResourceDownloadState state = ResourceDownloadState();
  TabController? tabController;
  final refreshController = Get.put(ResourceDownloadController());

  @override
  void onInit() {
    loadResourceClassify();
    super.onInit();
  }

  void loadResourceClassify() {
    Api.getCommunityResourceClassifyList().then((resp) {
      tabController?.dispose();
      tabController = TabController(
        length: (resp?.data ?? []).length,
        vsync: this,
        initialIndex: 0,
      );
      state.tabs.assignAll(resp?.data ?? []);

      if (state.tabs.isNotEmpty) {
        onChangeTab(state.tabs[0]);
        refreshController.classifyTitle = state.tabs.first.classifyTitle ?? "";
        refreshController.refreshController.callRefresh();
      }
    });
  }

  void onChangeTab(Data tab) {
    refreshController.classifyTitle = tab.classifyTitle ?? "";
    refreshController.getResourceList(isRefresh: true);
  }

  @override
  void onClose() {
    tabController?.dispose();
    tabController = null;
  }
}
