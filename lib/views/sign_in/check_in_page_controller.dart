import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xhs_app/generate/app_image_path.dart';
import 'package:xhs_app/http/api/api.dart';
import 'package:xhs_app/model/check_in/check_in_model.dart';
import 'package:xhs_app/model/check_in/check_in_tasks_model.dart';

class CheckInPageController extends GetxController
    with GetSingleTickerProviderStateMixin {
  var isExpanded = false.obs;
  Rx<CheckInInfoModel> checkInModel = CheckInInfoModel().obs;
  RxList<DailySignInTasks> checkInList = <DailySignInTasks>[].obs;

  //萌新任务
  RxList<SingleTasks> singleTasks = <SingleTasks>[].obs;

  //每日任务
  RxList<DailyTasks> dailyTasks = <DailyTasks>[].obs; //
  //福利兑换
  RxList<IntegralPrizes> integralPrizes = <IntegralPrizes>[].obs;
  late TabController tabController;
  var tabIndex = 0.obs;
  List<Tab> tabs = const [
    Tab(text: "萌新任务"),
    Tab(text: "每日任务"),
    Tab(text: "福利兑换"),
  ];

  @override
  void onInit() {
    tabController = TabController(length: tabs.length, vsync: this);
    tabController.addListener(() {
      if (!tabController.indexIsChanging) {
        tabIndex.value = tabController.index;
      }
    });
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    getUserCheckInInfo();
    getUserCheckInTasks();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getUserCheckInInfo() {
    Api.getUserCheckInInfo().then((response) {
      if (response != null) {
        checkInModel.value = response;
        checkInList.assignAll(checkInModel.value.dailySignInTasks ?? []);
      }
    });
  }

  getUserCheckInTasks() {
    Api.getDailySignInTasks().then((response) {
      if (response != null) {
        singleTasks.assignAll(response.singleTasks ?? []);
        dailyTasks.assignAll(response.dailyTasks ?? []);
        integralPrizes.assignAll(response.integralPrizes ?? []);
      }
    });
  }

  getCheckInStatusImagePath(int status) {
    switch (status) {
      case 1: //会员折扣券
        return AppImagePath.home_check_in_un_check_in;
      case 2: //ai 去衣
        return AppImagePath.home_check_in_ai_out_clothes;
      case 3: //观影券
        return AppImagePath.home_check_in_ticket;
      case 4: //金币会员
        return AppImagePath.home_check_in_vip;
      case 5: //金币
        return AppImagePath.home_check_in_gold;
      case 6: //萝莉岛
        return AppImagePath.home_check_in_vip;
      // case 7: //ai 换脸
      //   return AppImagePath.home_check_in_ai_face_change;

      default: //未签到
        return AppImagePath.home_check_in_un_check_in;
    }
  }

  getCheckInDesc(int status, int count) {
    switch (status) {
      case 0: //未签到
        return "10积分";
      case 1: //会员折扣券
        return "会员折扣券${count > 0 ? "*$count" : ""}";
      case 2: //ai 去衣
        return "ai去衣${count > 0 ? "*$count" : ""}";
      case 3: //观影券
        return "观影券${count > 0 ? "*$count" : ""}";
      case 4: //金币会员
        return "金币会员${count > 0 ? "*$count" : ""}";
      case 5: //金币
        return "金币${count > 0 ? "*$count" : ""}";
      case 6: //萝莉岛
        return "萝莉岛${count > 0 ? "*$count" : ""}";
      // case 7: //ai 换脸
      //   return "ai 换脸";

      default: //未签到
        return "10积分";
    }
  }

  getCheckInWelfareTypeImagePath(int status) {
    switch (status) {
      case 1: //会员
        return AppImagePath.home_check_in_welfare_vip_bg;
      case 2: //ai 换脸
        return AppImagePath.home_check_in_welfare_ai_change_bg;
      case 3: //金币
        return AppImagePath.home_check_in_welfare_gold_bg;
      case 4: //观影券
        return AppImagePath.home_check_in_welfare_ticket_bg;
      case 5: //ai 去衣
        return AppImagePath.home_check_in_welfare_ai_out_bg;
      case 6: //萝莉会员
        return AppImagePath.home_check_in_welfare_luoli_vip_bg;
      default:
        return AppImagePath.home_check_in_welfare_gold_bg;
    }
  }

  ///签到
  startCheckIn() {
    Api.checkInStart().then((value) {
      if (value) {
        getUserCheckInInfo();
      }
    });
  }

  ///积分领取
  getIntegralPrizes(int prizeId) {
    Api.getIntegralPrizes(prizeId).then((value) {
      if (value) {
        getUserCheckInTasks();
      }
    });
  }

  ///积分兑换
  exchangeIntegralPrizes(int prizeId) {
    Api.exchangeIntegralPrizes(prizeId).then((value) {
      if (value) {
        getUserCheckInTasks();
      }
    });
  }
}
