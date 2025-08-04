import 'package:get/get.dart';

import '../controllers/recommend_attention_page_controller.dart';

class RecommendAttentionPageBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RecommendAttentionPageController());
  }
}
