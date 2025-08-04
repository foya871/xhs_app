import 'package:get/get.dart';

import 'new_contact_logic.dart';

class NewContactBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NewContactLogic());
  }
}
