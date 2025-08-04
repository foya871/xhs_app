import 'package:get/get.dart';

import 'controller.dart';

class PicturePlayBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PicturePlayController());
  }
}
