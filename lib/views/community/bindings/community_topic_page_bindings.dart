import 'package:get/get.dart';

import '../controllers/community_topic_page_controller.dart';

class CommunityTopicPageBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CommunityTopicPageController());
  }
}
