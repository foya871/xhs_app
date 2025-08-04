import 'package:flutter/widgets.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:tuple/tuple.dart';
import 'package:xhs_app/components/diolog/dialog.dart';
import 'package:xhs_app/generate/app_image_path.dart';
import 'package:xhs_app/http/service/api_service.dart';
import 'package:xhs_app/model/announcement/announcement.dart';
import 'package:xhs_app/routes/routes.dart';
import 'package:xhs_app/utils/ad_jump.dart';
import 'package:xhs_app/utils/enum.dart';

import '../../services/user_service.dart';
import 'frontpage/account_credentials_page.dart';

class MinePageController extends GetxController {
  final userService = Get.find<UserService>();
  var isFirstShow = false.obs;
  List<Tuple2> myFunctions = [];
  int current_collect_index = 0;

  String appUrl = "";

  @override
  void onInit() {
    super.onInit();

    initViewDatas();
    getAppUrl();
    if (GetPlatform.isAndroid) {
      if (!isFirstShow.value &&
          (userService.user.account != null &&
              userService.user.account!.isNotEmpty)) {
        // showAccountCredentialsDialog(Get.context!);
        isFirstShow.value == true;
      }
    }
  }

  void initViewDatas() {
    ///加载 我的 相关的功能
    myFunctions.add(const Tuple2(AppImagePath.mine_mine_my_releases, "我的发布"));
    myFunctions.add(const Tuple2(AppImagePath.mine_mine_my_purchase, "我的购买"));
    if (GetPlatform.isAndroid) {
      myFunctions
          .add(const Tuple2(AppImagePath.mine_mine_my_downloader, "我的下载"));
    }
    myFunctions.add(const Tuple2(AppImagePath.mine_mine_my_favorites, "我的收藏"));
    myFunctions.add(const Tuple2(AppImagePath.mine_mine_ppchigua, "他他吃瓜"));
    myFunctions
        .add(const Tuple2(AppImagePath.mine_mine_customer_service, "男神客服"));
    myFunctions
        .add(const Tuple2(AppImagePath.mine_mine_application_center, "应用中心"));
  }

  onClick(String title) {
    switch (title) {
      case '设置':
        Get.toNamed(Routes.settingpage);
        break;
      case '签到':
        Get.toShare(tabIndex: 1);
        break;
      case '登录':
        Get.toNamed(Routes.login);
        break;
      case '注册':
        Get.toNamed(Routes.register);
        break;
      case '编辑资料':
        Get.toNamed(Routes.edituserinfo);
        break;
      case '粉丝':
        Get.toNamed(Routes.mine_fans_followers, parameters: {'title': "粉丝"});
        break;
      case '关注':
        // Get.toNamed(Routes.minebloggerauthentication, parameters: {'title': "关注"});
        Get.toNamed(Routes.mine_fans_followers, parameters: {'title': "关注"});
        break;
      case '获赞':
        break;
      case 'VIP':
        Get.toVip();
        break;
      case '金币充值':
        Get.toVip(tabInitIndex: 1);
        break;
      case '推广赚钱':
        Get.toShare();
        break;
      case '我的发布':
        Get.toNamed(Routes.minesrelease);
        break;
      case '我的购买':
        Get.toNamed(Routes.buy);
        break;
      case '我的下载':
        Get.toNamed(Routes.download);
        break;
      case '我的收藏':
        Get.toNamed(Routes.favorite);
      case '收藏':
        Get.toNamed(Routes.mine_new_followers);
        break;
      case '他他吃瓜':
        Get.toNamed(Routes.mine_fans_followers, parameters: {'title': "加群聊骚"});
        break;
      case '男神客服':
        kOnLineService();
        break;
      case '应用中心':
        if (appUrl.isEmpty) {
          showToast("暂无应用推荐");
        } else {
          jumpExternalAddress(appUrl, null);
        }
        break;
      case '兑换会员':
        Get.toNamed(Routes.exchangevippage);
        break;
      case '邀请码':
        Get.toNamed(Routes.invitecodepage);
        break;
      default:
        break;
    }
  }

  showAccountCredentialsDialog(BuildContext context) {
    SmartDialog.show(
      clickMaskDismiss: true,
      builder: (context) {
        return const AccountCredentialsPage();
      },
    );
  }

  String getVipTypeToImagePath() => VipTypeEnum.badge(userService.user.vipType);

  String getVipTypeToVipName() => VipTypeEnum.name(userService.user.vipType);

  Future<void> getAppUrl() async {
    final ann = await httpInstance.get<AnnouncementModel>(
        url: 'sys/ann', complete: AnnouncementModel.fromJson);
    if (ann is AnnouncementModel) {
      appUrl = ann.appCenterUrl!;
    }
  }
}
