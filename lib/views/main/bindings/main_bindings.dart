import 'package:get/get.dart';
import 'package:xhs_app/views/main/bindings/home_tab_bindings.dart';

import '../../mine/mine_page_controller.dart';
import '../controllers/main_controller.dart';

class MainBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(() => MainController());
    Get.lazyPut<MinePageController>(() => MinePageController());

    
    HomeTabBindings().dependencies();
  }
}
