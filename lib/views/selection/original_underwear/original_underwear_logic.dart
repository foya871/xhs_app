import 'package:get/get.dart';
import 'package:xhs_app/views/selection/selection_search/product/product_list_controller.dart';

import '../recommend/recommend_video_controller.dart';
import 'original_underwear_state.dart';

class OriginalUnderwearLogic extends GetxController {
  final OriginalUnderwearState state = OriginalUnderwearState();
  late var refreshController = Get.put(ProductListController(),tag: "original_underwear");

  @override
  void onInit() {
    refreshController.classifyId = "7";
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    Get.delete<ProductListController>(tag: "original_underwear");
    super.onClose();
  }
}
