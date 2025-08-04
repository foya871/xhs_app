import 'package:get/get.dart';

import 'controller.dart';

class PictureListBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PictureListParamsManagerController());
    Get.lazyPut(() => PictureListController());
  }
}
