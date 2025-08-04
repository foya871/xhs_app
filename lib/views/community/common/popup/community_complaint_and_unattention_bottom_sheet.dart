import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/routes/routes.dart';

import '../../../../assets/styles.dart';
import '../../../../components/circle_image.dart';
import '../../../../components/popup/bottomsheet/abstract_bottom_sheet.dart';
import '../../../../components/popup/dialog/future_loading_dialog.dart';
import '../../../../generate/app_image_path.dart';
import '../../../../http/api/api.dart';
import '../../../../model/community/community_base_model.dart';
import '../../../../utils/color.dart';
import '../../../../utils/extension.dart';
import 'community_unattention_confirm_dialog.dart';

// 投诉、取消关注
class CommunityComplaintAndUnattentionBottomSheet extends AbstractBottomSheet {
  final CommunityBaseModel model;
  CommunityComplaintAndUnattentionBottomSheet(this.model);
  Widget _buildOne(
          {required String asset, required String text, VoidCallback? onTap}) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleImage.asset(asset, size: 50.w),
          8.verticalSpaceFromWidth,
          Text(
            text,
            style: TextStyle(color: COLOR.color_666666, fontSize: 13.w),
          ),
        ],
      ).onOpaqueTap(onTap);

  @override
  Widget build() => Container(
        height: 154.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: COLOR.color_F8F8F8,
          borderRadius: Styles.borderRadius.top(12.w),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildOne(
              asset: AppImagePath.community_discover_complaint,
              text: '投诉',
              onTap: () {
                Get.back();
                Get.toCommunityComplaint(model);
              },
            ),
            80.horizontalSpace,
            _buildOne(
              asset: AppImagePath.community_discover_unattention,
              text: '取消关注',
              onTap: () {
                Get.back();
                CommunityUnattentionConfirmDialog(
                  onConfirm: () {
                    Get.back();
                    FutureLoadingDialog(Api.cancelAttentionUser(model.userId))
                        .show();
                  },
                ).show();
              },
            ),
          ],
        ),
      );
}
