import 'package:get/get.dart';

import 'selection_search_logic.dart';

class SelectionSearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SelectionSearchLogic());
  }
}
