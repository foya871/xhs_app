/*
 * @Author: wangdazhuang
 * @Date: 2025-03-05 13:40:15
 * @LastEditTime: 2025-03-07 15:18:21
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /xhs_app/lib/launch/launch_classify_controller.dart
 */
import 'package:get/get.dart';
import 'package:xhs_app/routes/routes.dart';

import 'components/diolog/loading/loading_view.dart';
import 'http/api/api.dart';
import 'model/community/community_classify_model.dart';

class LaunchClassifyController extends GetxController {
  RxList<CommunityClassifyModel> list = <CommunityClassifyModel>[].obs;
  RxList<CommunityClassifyModel> selectedItems = <CommunityClassifyModel>[].obs;

  @override
  void onInit() {
    _fetchClassiyList();
    super.onInit();
  }

  Future _fetchClassiyList() async {
    final arr = await Api.getCommunityClassifyOptionalList();
    if (arr != null) {
      list.value = arr;
    }
  }

  void toggleItem(CommunityClassifyModel item) {
    if (selectedItems.contains(item)) {
      selectedItems.remove(item);
    } else {
      selectedItems.add(item);
    }
  }

  savePreferenceClassifyList() async {
    if (selectedItems.isEmpty) return;
    final ids = selectedItems.map((e) => e.classifyId).toList();
    final flag = await LoadingView.singleton.wrap<bool>(
        context: Get.context!,
        asyncFunction: () async {
          final resp = await Api.saveCommunityClassifySelected(ids);
          return resp;
        });
    if (flag == true) {
      Get.offHome();
    }
  }
}
