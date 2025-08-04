import 'package:get/get.dart';

import 'controller.dart';

class AdultGameSearchResultControllsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AdultGameSearchResultController());
  }
}
