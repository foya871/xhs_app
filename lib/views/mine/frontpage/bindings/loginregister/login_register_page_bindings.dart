import 'package:get/get.dart';
import '../../controller/login_register_controller.dart';

class LoginRegisterPageBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginRegisterController());
  }
}
