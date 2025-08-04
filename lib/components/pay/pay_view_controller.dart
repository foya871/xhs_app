/*
 * @Author: wangdazhuang
 * @Date: 2025-01-21 09:41:21
 * @LastEditTime: 2025-01-28 13:17:44
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /xhs_app/lib/components/pay/pay_view_controller.dart
 */
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:xhs_app/components/diolog/loading/loading_view.dart';
import 'package:xhs_app/components/pay/model/pay_link_model.dart';
import 'package:xhs_app/http/service/api_service.dart';
import 'package:xhs_app/services/user_service.dart';
import 'package:xhs_app/utils/ad_jump.dart';
import 'package:xhs_app/utils/logger.dart';
import 'package:universal_html/html.dart';

import 'model/recharge_request_model.dart';
import 'model/recharge_type_model.dart';
import 'package:universal_html/html.dart' show window;

class PayViewController extends GetxController {
  final userService = Get.find<UserService>();

  late double amount; //支付金额
  late int payId; //购买的ID
  late int payNumber; //购买的数量
  //购买类型 (1-常规充值; 2-购买VIP; 3-购买金币; 4-购买门票; 5-购买AI_VIP会员)
  late int purType;
  late double balance; //余额
  late int source; //来源 0:平台

  List<RechargeTypeModel> payType = [];
  final currentPayType = RechargeTypeModel.empty().obs;

  initController(
      double amount,
      int payId,
      int payNumber,
      int purType,
      List<RechargeTypeModel> payType,
      int source,
      bool isAddBalancePay,
      bool isDefaultSelectedFirst) {
    this.amount = amount;
    this.payId = payId;
    this.payNumber = payNumber;
    this.purType = purType;
    this.payType = payType;
    balance = userService.assets.bala ?? 0;
    this.source = source;

    if (isAddBalancePay) {
      /// 添加余额支付
      if (!payType.any((element) => element.payMent == '0001')) {
        this.payType.add(RechargeTypeModel.balance());
      }
    }
    if (isDefaultSelectedFirst) {
      currentPayType.value = this.payType.first;
    }
  }

  startPay(RechargeRequestModel request, Function()? onSuccess) async {
    await LoadingView.singleton.wrap(
        context: Get.context!,
        asyncFunction: () async {
          var newWindow;
          if (kIsWeb && request.rechType != '0') {
            newWindow = window.open('', '_blank');
          }
          try {
            final response = await httpInstance.post(
              url: 'rech/sumbit',
              body: request.toJson(),
              complete: PayLinkModel.fromJson,
            );
            if (request.rechType == "0") {
              userService.updateAll();
              onSuccess?.call();
            }
            if (response != null) {
              if (kIsWeb) {
                // WindowBase? newWindow = window.open('', '_blank');
                newWindow.location.href = response.url;
              } else {
                jumpExternalAddress(response.url, null);
              }
            }
          } catch (e) {
            logger.e(e);
          }
        });
    Get.back();
  }
}
