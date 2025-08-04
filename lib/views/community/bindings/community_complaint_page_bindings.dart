import 'package:get/get.dart';

import '../controllers/community_complaint_page_controller.dart';

class CommunityComplaintPageBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CommunityComplaintPageController());
  }
}
