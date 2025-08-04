/*
 * @Author: david wumingshi555888@gmail.com
 * @Date: 2025-02-20 23:07:21
 * @LastEditors: david wumingshi555888@gmail.com
 * @LastEditTime: 2025-03-03 22:08:41
 * @FilePath: /xhs_app/lib/views/mine/frontpage/controller/login_register_controller.dart
 * @Description: 
 * Copyright (c) 2025 by ${git_name} email: ${git_email}, All Rights Reserved.
 */
import 'package:xhs_app/http/service/api_service.dart';
import 'package:xhs_app/model/user/user_info_model.dart';
import 'package:get/get.dart';
import 'package:xhs_app/utils/save_account_dialog.dart';

import '../../../../components/easy_toast.dart';
import '../../../../http/api/api.dart';
import '../../../../model/mine/share_link_model.dart';
import '../../../../services/storage_service.dart';
import '../../../../services/user_service.dart';
import '../../../../utils/loading_dialog.dart';

class LoginRegisterController extends GetxController {
  final storageService = Get.find<StorageService>();
  final us = Get.find<UserService>();
  var url = ''.obs;

  @override
  void onInit() {
    _getSharedLink();
    super.onInit();
  }

  Future postLogin(String account, String password) async {
    showCustomDialog(Get.context!, "登录中,请稍候..");
    try {
      final u = await httpInstance.post(
          url: 'user/account/login',
          body: {
            'account': account.trim(),
            'password': password.trim(),
          },
          complete: UserInfo.fromJson);
      if (u is UserInfo) {
        EasyToast.show("登录成功");
        await storageService.saveUserInfo(u);
      }
      Get.back();
    } catch (_) {}
    closeDialog(Get.context!);
  }

  Future<bool> postRegister(String account, String pwd) async {
    showCustomDialog(Get.context!, "注册中,请稍候..");
    try {
      final resp = await httpInstance.post(
          url: 'user/register',
          body: {
            "account": account.trim(),
            "password": pwd.trim(),
          },
          complete: UserInfo.fromJson);
      if (resp != null) {
        await storageService.saveUserInfo(resp!);
        storageService.saveRegisterPassword(pwd.trim());
        EasyToast.show("注册成功");
        Get.back();
        return true;
      }
      return false;
    } catch (_) {
      return false;
    } finally {
      closeDialog(Get.context!);
    }
  }

  Future _getSharedLink() async {
    try {
      final result = await Api.getShareLink();
      if (result is ShareRespModel) {
        url.value = result.url ?? '';
      }
    } catch (e) {
      return null;
    }
  }

  String getMainDomainFromUrl() {
    Uri uri = Uri.parse(url.value);
    if (url.value.isEmpty) return '';
    return uri.host.split('.').length > 2
        ? '${uri.scheme}://${uri.authority}'
        : '${uri.scheme}://${uri.host}';
  }
}
