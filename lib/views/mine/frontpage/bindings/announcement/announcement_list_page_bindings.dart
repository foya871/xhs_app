import 'package:get/get.dart';

import '../../controller/announcement_list_controller.dart';

class AnnouncementListPageBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AnnouncementListController());
  }
}
