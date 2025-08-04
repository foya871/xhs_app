import 'package:get/get.dart';

import 'controller.dart';

class AdultGameListByCollectionControllsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AdultGameListCollectionController());
  }
}
