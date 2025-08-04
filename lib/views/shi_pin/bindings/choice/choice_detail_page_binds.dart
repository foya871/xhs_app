import 'package:get/get.dart';

import '../../controllers/choice/choice_detail_page_controller.dart';

class ChoiceDetailPageBinds extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChoiceDetailPageController());
  }
}
