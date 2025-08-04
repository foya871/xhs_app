import 'package:get/get.dart';

import '../controllers/community_discover_page_controller.dart';

class CommunityDiscoverPageBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CommunityDiscoverPageController());
  }
}
