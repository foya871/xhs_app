import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../components/easy_toast.dart';
import '../../../http/api/api.dart';
import '../../../http/service/api_service.dart';
import '../../../model/mine/share_link_model.dart';
import '../../../utils/loading_dialog.dart';

class InviteCodePageController extends GetxController {
  var inviteUserNum = 0.obs;
  var inviteCode = ''.obs;
  var url = ''.obs;
  final node = FocusNode();

  @override
  void onInit() {
    _getSharedLink();
  }

  Future _getSharedLink() async {
    try {
      final result = await Api.getShareLink();
      if (result is ShareRespModel) {
        inviteUserNum.value = result.inviteUserNum ?? 0;
        inviteCode.value = result.inviteCode ?? '';
        url.value = result.url ?? '';
      }
    } catch (e) {
      return null;
    }
  }

  Future<void> postInviteCode(String inviteCode) async {
    showCustomDialog(Get.context!, "提交中,请稍候..");
    try {
      if (inviteCode.isNotEmpty) {
        await httpInstance.post(url: 'user/bind/inviteCode', body: {
          'inviteCode': inviteCode,
        });
      }
      EasyToast.show('绑定成功');
      Get.back();
    } catch (_) {}
    closeDialog(Get.context!);
  }
}
