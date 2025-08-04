import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xhs_app/components/diolog/loading/loading_view.dart';
import 'package:xhs_app/components/pay/model/chat_model.dart';
import 'package:xhs_app/components/pay/model/gold_model.dart';
import 'package:xhs_app/components/pay/model/vip_model.dart';
import 'package:xhs_app/components/pay/pay_view.dart';
import 'package:xhs_app/http/api/api.dart';
import 'package:xhs_app/http/service/api_service.dart';
import 'package:xhs_app/model/mine/ann_vip_model.dart';
import 'package:xhs_app/services/user_service.dart';
import 'package:xhs_app/utils/enum.dart';
import 'package:xhs_app/utils/logger.dart';

import '../../../components/diolog/dialog.dart';
import '../../../model/mine/points_redemption_model.dart';

class VipPageController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final userService = Get.find<UserService>();
  late TabController tabController;
  var tabInitIndex = 0.obs;
  var tabIndex = 0.obs;
  List<Tab> tabs = const [
    Tab(text: "会员中心"),
    Tab(text: "金币充值"),
  ];
  Rx<AnnVipModel> annVip = AnnVipModel().obs;
  Rx<PointsRedemptionModel> exchangeIntegral = PointsRedemptionModel().obs;
  RxList<PrizeList> prizes = <PrizeList>[].obs;

  RxList<VipModel> vipList = <VipModel>[].obs;
  RxList<ChatModel> chatList = <ChatModel>[].obs;
  RxList<GoldModel> goldList = <GoldModel>[].obs;
  Rx<VipModel> currentVipCard = VipModel().obs;
  Rx<ChatModel> currentChatCard = ChatModel().obs;

  Rx<GoldModel> currentGoldCard = GoldModel().obs;

  @override
  void onInit() {
    getVipCards();
    final arguments = Get.arguments;
    if (arguments != null) {
      tabInitIndex.value = Get.arguments['tabInitIndex'] ?? 0;
    }
    tabController = TabController(
        length: tabs.length, vsync: this, initialIndex: tabInitIndex.value);
    tabController.index = tabInitIndex.value;

    update();
    super.onInit();
  }

  // @override
  // void onReady() {
  //   super.onReady();
  //   // showHintDialog();
  // }

  getVipCards() async {
    try {
      final response = await Api.getVipGoldCards();
      if (response != null) {
        vipList.assignAll(response.vipCardList ?? []);
        // chatList.assignAll(response.chatVipCardList ?? []);
        goldList.assignAll(response.goldVipList ?? []);
        currentVipCard.value = vipList.first;
        // currentChatCard.value = chatList.first;
        currentGoldCard.value = goldList.first;
        // startTimer();
      }
    } catch (_) {}
    update();
  }

  ///获取积分兑换列表
  Future _getUserExchangeIntegral() async {
    try {
      final result = await httpInstance.get<PointsRedemptionModel>(
        url: 'signIn/userExchangeIntegralPrizes',
        complete: PointsRedemptionModel.fromJson,
      );
      if (result is PointsRedemptionModel) {
        exchangeIntegral.value = result;
        if (result.prizeList != null && result.prizeList!.isNotEmpty) {
          prizes.assignAll(result.prizeList!);
        }
      }
    } catch (e) {
      logger.e(e);
    }
  }

  bool _isExchangeIng = false;

  void exChangePrize(PrizeList prize) async {
    if (_isExchangeIng) {
      return;
    }

    if ((exchangeIntegral.value.integral ?? 0) < prize.needIntegral!) {
      showToast("签到积分不足~");
      return;
    }
    try {
      _isExchangeIng = true;

      await LoadingView.singleton.wrap(
        context: Get.context!,
        asyncFunction: () async {
          await httpInstance.post(url: 'signIn/exchange', body: {
            "prizeId": prize.prizeId,
          });
          showToast("兑换成功");
          _getUserExchangeIntegral();
        },
      );
    } catch (e) {
      logger.e(e);
    } finally {
      _isExchangeIng = false;
    }
  }

  void onSubmitBuy() {
    Get.bottomSheet(
      tabIndex.value == 0
          ? PayView(
              amount: (currentVipCard.value.disPrice ?? 0).toDouble(),
              payId: currentVipCard.value.cardId ?? 0,
              purType: PurTypeEnum.vip,
              payType: currentVipCard.value.types ?? [],
            )
          : PayView(
              amount: (currentChatCard.value.disPrice ?? 0).toDouble(),
              payId: currentChatCard.value.cardId ?? 0,
              purType: PurTypeEnum.vip,
              payType: currentChatCard.value.types ?? [],
            ),
    );
  }
}
