import 'package:get/get.dart';

import 'new_address_logic.dart';

class NewAddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NewAddressLogic());
  }
}
