import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../components/popup/dialog/base_confirm_dialog.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/enum.dart';

class CommunityReasonTypeDialog<T> extends BaseConfirmDialog {
  static bool uniqueOpen = false;

  static String tips(CommunityReasonType reasonType) => switch (reasonType) {
        CommunityReasonTypeEnum.noCount ||
        CommunityReasonTypeEnum.needBuy =>
          '购买视频观看即可观看完整版',
        CommunityReasonTypeEnum.needVip => '免费观看次数已经用完，购买会员可观看',
        CommunityReasonTypeEnum.needFans => '开通粉丝团观看博主粉丝专属视频',
        _ => '',
      };

  static String btnName(CommunityReasonType type) => switch (type) {
        CommunityReasonTypeEnum.noCount ||
        CommunityReasonTypeEnum.needBuy =>
          '前往购买',
        CommunityReasonTypeEnum.needVip => '开通会员',
        CommunityReasonTypeEnum.needFans => '加粉丝团',
        _ => '',
      };

  static VoidCallback getOnConfirm(CommunityReasonType type, int userId) =>
      switch (type) {
        CommunityReasonTypeEnum.noCount ||
        CommunityReasonTypeEnum.needBuy =>
          () => Get.toVip(tabInitIndex: 1),
        CommunityReasonTypeEnum.needVip => () => Get.toVip(),
        CommunityReasonTypeEnum.needFans => () =>
            Get.toBloggerPrivateGroup(userId: userId),
        _ => () => Get.toVip(),
      };

  CommunityReasonTypeDialog(CommunityReasonType reasonType,
      {required int userId})
      : super(
          titleText: '温馨提示',
          descText: tips(reasonType),
          cancelText: '取消',
          confirmText: btnName(reasonType),
          onConfirm: getOnConfirm(reasonType, userId),
        );

  Future<T?> showUnique() async {
    if (uniqueOpen) return null;
    uniqueOpen = true;
    try {
      return await show();
    } finally {
      uniqueOpen = false;
    }
  }
}
