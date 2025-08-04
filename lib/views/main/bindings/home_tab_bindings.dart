import 'package:get/get.dart';

import '../../community/controllers/community_discover_page_controller.dart';
import '../../community/controllers/communtiy_attention_page_controller.dart';

class HomeTabBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CommunityDiscoverPageController());
    Get.lazyPut(() => CommuntiyAttentionPageController());
  }
}
