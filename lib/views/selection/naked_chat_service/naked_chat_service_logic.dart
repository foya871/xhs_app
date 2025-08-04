import 'package:get/get.dart';

import '../selection_search/product/product_list_controller.dart';
import 'naked_chat_service_state.dart';

class NakedChatServiceLogic extends GetxController {
  final NakedChatServiceState state = NakedChatServiceState();
  late var refreshController = Get.put(ProductListController(),tag: "naked_chat_service");

  @override
  void onInit() {
    refreshController.classifyId = "4";
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    Get.delete<ProductListController>(tag: "naked_chat_service");
    super.onClose();
  }


}
