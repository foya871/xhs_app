/*
 * @Author: david wumingshi555888@gmail.com
 * @Date: 2025-03-02 10:51:41
 * @LastEditors: david wumingshi555888@gmail.com
 * @LastEditTime: 2025-03-02 11:53:08
 * @FilePath: /xhs_app/lib/views/mine/mine_download/mine_download_page_controller.dart
 * @Description: 
 * Copyright (c) 2025 by ${git_name} email: ${git_email}, All Rights Reserved.
 */
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xhs_app/http/api/api.dart';
import 'package:xhs_app/model/community/community_classify_model.dart';

import 'mine_download_list_page_controller.dart';

class MineDownloadPageController extends GetxController
    with GetTickerProviderStateMixin {
  var classifyItems = <CommunityClassifyModel>[].obs;
  var currentClassify = CommunityClassifyModel.fromJson({}).obs;

  TabController? tabController;

  @override
  void onInit() {
    super.onInit();
    onPageLoad();
  }

  onPageLoad() async {
    await getResourcesClassifyList();
    tabController = TabController(length: classifyItems.length, vsync: this);
  }

  Future<void> getResourcesClassifyList() async {
    final result = await Api.getResourcesClassifyList();
    if (result != null) {
      classifyItems.value = result;

      for (var item in classifyItems) {
        Get.lazyPut(() => MineDownloadListPageController(
              classifyId: item.classifyId,
              classifyTitle: item.classifyTitle,
            ),
            tag: "${item.classifyId}-${item.classifyTitle}");
      }
      update();
    }
  }
}
