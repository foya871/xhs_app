/*
 * @Author: david wumingshi555888@gmail.com
 * @Date: 2025-03-01 16:56:06
 * @LastEditors: david wumingshi555888@gmail.com
 * @LastEditTime: 2025-03-01 19:15:20
 * @FilePath: /xhs_app/lib/views/mine/mine_group/mine_group_page_controller.dart
 * @Description:  
 * Copyright (c) 2025 by ${git_name} email: ${git_email}, All Rights Reserved.
 */
import 'package:get/get.dart';
import 'package:xhs_app/model/mine/official_community_model.dart';

import '../../../http/service/api_service.dart';

class MineGroupPageController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getOfficialCommunity();
  }

  RxList<OfficialCommunityModel> ocLists = <OfficialCommunityModel>[].obs;

  Future<void> getOfficialCommunity() async {
    final response = await httpInstance.get(
      url: 'sys/group/list',
      complete: OfficialCommunityModel.fromJson,
    );
    if (response != null) {
      ocLists.addAll(response);
    }
    update();
  }
}
