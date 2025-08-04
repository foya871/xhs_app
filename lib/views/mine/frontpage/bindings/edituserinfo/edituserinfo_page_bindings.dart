import 'package:get/get.dart';
import 'package:xhs_app/views/mine/frontpage/controller/edit_userinfo_controller.dart';

class EditUserInfoPageBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditUserInfoController());
  }
}
