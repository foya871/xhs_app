import 'package:get/get.dart';
import 'package:xhs_app/components/pay/enum_pay.dart';
import 'package:xhs_app/services/storage_service.dart';

const _source = 0;

class RechargeRequestModel {
  final String money; //充值金额
  final int nums; //数量
  //购买类型 (1-常规充值; 2-购买VIP; 3-购买金币; 4-购买门票; 5-购买AI_VIP会员)
  final int purType;

  //支付类型 (0-余额; 1-支付宝; 2-微信; 3-云闪付)
  final String rechType;
  final int source; //来源：0-平台
  final int targetId;

  RechargeRequestModel({
    required this.money,
    required this.nums,
    required this.purType,
    required this.rechType,
    required this.source,
    required this.targetId,
  });

  Map<String, dynamic> toJson([bool addDeviceId = true]) {
    final json = {
      'money': money,
      'nums': nums,
      'purType': purType,
      'rechType': rechType,
      'source': source,
      'targetId': targetId,
    };
    if (addDeviceId) {
      json['deviceId'] = Get.find<StorageService>().deviceId ?? '';
    }
    return json;
  }

  RechargeRequestModel.vip({
    required this.money,
    required PayType payType,
    required int cardId,
  })  : nums = 1,
        purType = 2,
        rechType = payType.toString(),
        source = _source,
        targetId = cardId;

  RechargeRequestModel.gold({
    required this.money,
    required PayType payType,
    required int goldId,
  })  : nums = 1,
        purType = 3,
        rechType = payType.toString(),
        source = _source,
        targetId = goldId;

  RechargeRequestModel.ticket({
    required this.money,
    required PayType payType,
    required int ticketId,
  })  : nums = 1,
        purType = 4,
        rechType = payType.toString(),
        source = _source,
        targetId = ticketId;

  RechargeRequestModel.aiVip({
    required this.money,
    required PayType payType,
    required int aiCardId,
  })  : nums = 1,
        purType = 5,
        rechType = payType.toString(),
        source = _source,
        targetId = aiCardId;

  RechargeRequestModel.groupBuying({
    required this.money,
    required PayType payType,
    required int ticketId,
  })  : nums = 1,
        purType = 5,
        rechType = payType.toString(),
        source = _source,
        targetId = ticketId;
}
