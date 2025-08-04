import 'package:get/get.dart';
import 'package:xhs_app/views/mine/frontpage/controller/mine_setting_controller.dart';
import 'package:xhs_app/views/mine/frontpage/controller/set_pwd_controller.dart';

import '../../controller/announcement_list_controller.dart';

class SetPwdPageBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SetPwdController());
  }
}
