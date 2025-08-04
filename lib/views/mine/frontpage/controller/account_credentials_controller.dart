import 'package:get/get.dart';
import '../../../../http/service/api_service.dart';
import '../../../../model/mine/share_link_model.dart';
import '../../../../services/storage_service.dart';
import '../../../../services/user_service.dart';

class AccountCredentialsController extends GetxController {
  final us = Get.find<UserService>();
  var share = ShareRespModel();

  get userInfo => us.user;

  final storageService = Get.find<StorageService>();

  Future getShareInfo() async {
    share = await httpInstance.get(
        url: "user/shared/link", complete: ShareRespModel.fromJson);
    if (share == null) return;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    getShareInfo();
  }
}
