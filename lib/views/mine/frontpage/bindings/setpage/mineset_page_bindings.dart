import 'package:get/get.dart';
import 'package:xhs_app/views/mine/frontpage/controller/mine_setting_controller.dart';

import '../../controller/announcement_list_controller.dart';

class MineSetPageBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MineSettingController());
  }
}
