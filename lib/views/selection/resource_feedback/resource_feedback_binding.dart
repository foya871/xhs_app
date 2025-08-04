import 'package:get/get.dart';

import 'resource_feedback_logic.dart';

class ResourceFeedbackBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ResourceFeedbackLogic());
  }
}
