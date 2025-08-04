/*
 * @Author: david wumingshi555888@gmail.com
 * @Date: 2025-02-28 21:47:59
 * @LastEditors: wangdazhuang
 * @LastEditTime: 2025-03-05 17:55:41
 * @FilePath: /xhs_app/lib/views/main/controllers/main_controller.dart
 * @Description: 
 * Copyright (c) 2025 by ${git_name} email: ${git_email}, All Rights Reserved.
 */
import 'package:get/get.dart';
import 'package:xhs_app/components/easy_toast.dart';
import 'package:xhs_app/http/api/login.dart';
import 'package:xhs_app/views/mine/mine_page_controller.dart';

import '../../../components/announcement/announcement.dart';
import '../../../http/api/api.dart';
import '../../../routes/routes.dart';
import '../../../services/user_service.dart';
import '../../../utils/ad_jump.dart';
import '../../../utils/utils.dart';
import '../../community/common/base/community_utils.dart';

class MainController extends GetxController {
  final userService = Get.find<UserService>();
  static const int homeIndex = 0;
  static const int jingXuan = 1;
  static const int huoDong = 2;
  static const int world = 3;
  static const int mine = 4;

  final currentIndex = 2.obs;
  final _communityPushedMessageCount = 0.obs;

  int get communityPushedMessageCount => _communityPushedMessageCount.value;
  void clearCommunityPushedMessageCount() =>
      _communityPushedMessageCount.value = 0;

  void changeMainTabIndex(int i) {
    if (i < homeIndex || i > mine) return;
    if (i != currentIndex.value) {
      currentIndex.value = i;
      if (i == 3) {
        Get.find<UserService>().updateAPIUserInfo();
      }
    }
  }

  void _fetchCommunityPushMessage() async {
    final messages = await Api.getCommunityPushMessage();
    if (messages == null) return;
    messages.forEach(CommunityUtils.showPushSnackbar);
    _communityPushedMessageCount.value = messages.length;
  }

  @override
  void onInit() {
    final index = Utils.asType<int>(Get.arguments) ?? huoDong;
    showAllEntranceAds();

    ///在线客服地址
    fetchOnLine();
    changeMainTabIndex(index);
    // 太快了，延迟一点
    Future.delayed(const Duration(seconds: 60)).then((_) {
      _fetchCommunityPushMessage();
    });
    super.onInit();
  }

  onClick(String title) {
    switch (title) {
      case '私人团':
        Get.toNamed(Routes.minefansclub);
        break;
      case '博主认证':
        Get.toNamed(Routes.minebloggerauthentication);
        break;
      case '我的购买':
        Get.toNamed(Routes.buy);
        break;
      case '作品中心':
        Get.toNamed(Routes.minesrelease);
        break;
      case '开车群':
        Get.toNamed(Routes.minegroup);
        break;
      case '我的下载':
        Get.toNamed(Routes.download);
        break;
      case '应用中心':
        var controler = Get.find<MinePageController>();
        if (controler.appUrl.isEmpty) {
          EasyToast.show("暂无应用推荐");
        } else {
          jumpExternalAddress(controler.appUrl, null);
        }
        break;
      default:
        break;
    }
  }
}
