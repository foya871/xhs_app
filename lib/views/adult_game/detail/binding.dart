import 'package:get/get.dart';

import 'controller.dart';

class AdultGameDetailControllBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AdultGameDetailController());
  }
}
