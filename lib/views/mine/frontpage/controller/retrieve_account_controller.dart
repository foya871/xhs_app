import 'package:xhs_app/components/easy_toast.dart';
import 'package:xhs_app/http/api/login.dart';
import 'package:get/get.dart';

import '../../../../http/service/api_service.dart';
import '../../../../model/user/user_info_model.dart';
import '../../../../utils/loading_dialog.dart';

class RetrieveAccountController extends GetxController {
  Future<void> identifyTheQRCode(String data) async {
    if (data.isEmpty) {
      EasyToast.show('無效的二維碼');
      return;
    }
    List<String> acctr = data.split(RegExp(r'\*+'));
    if (acctr.length < 2) {
      EasyToast.show('非賬號憑證二維碼');
      return;
    }
    postRetrieve(acctr[0], int.parse(acctr[1]));
  }

  Future postRetrieve(String devId, int userId) async {
    showCustomDialog(Get.context!, "正在找回中,请稍候..");
    try {
      final u = await httpInstance.post(
          url: 'user/traveler/scan',
          body: {
            'deviceId': devId,
            'userId': userId,
          },
          complete: UserInfo.fromJson);
      if (u is UserInfo) {
        EasyToast.show("找回成功");
        localStore.setToken(u.token!);
      }
    } catch (_) {}
    closeDialog(Get.context!);
  }
}
