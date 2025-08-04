/*
 * @Author: wangdazhuang
 * @Date: 2025-03-04 13:43:46
 * @LastEditTime: 2025-03-04 13:46:46
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /xhs_app/lib/views/player/views/permission_ui.dart
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/routes/routes.dart';
import 'package:xhs_app/views/player/controllers/video_play_controller.dart';

import '../../../assets/styles.dart';
import '../../../components/easy_button.dart';
import '../../../utils/color.dart';
import '../../../utils/enum.dart';

class PermissionUi extends StatelessWidget {
  final VideoPlayController controller;

  const PermissionUi({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    if (!controller.showPermission.value) return const SizedBox.shrink();
    final isPay =
        controller.currentVideo.value.videoType == VideoTypeValueEnum.Pay;
    final price = controller.currentVideo.value.priceText;
    final paydesc = '$price金币购买观看完整版';
    const title = '试看结束';
    final desc = isPay ? paydesc : '开通会员观看完整版';
    final buttonText = isPay ? '$price金币购买' : '立即开通';
    final buttonBg =
        isPay ? COLOR.hexColor("#ffbe20") : COLOR.hexColor("#ffaa77");
    final buttonTextColor = COLOR.hexColor("#bb602a");

    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(color: COLOR.black.withOpacity(0.7)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: kTextStyle(Colors.white, fontsize: 15.w),
            ),
            6.w.verticalSpaceFromWidth,
            Text(
              desc,
              style: kTextStyle(Colors.white, fontsize: 15.w),
            ),
            15.w.verticalSpaceFromWidth,
            EasyButton(
              buttonText,
              width: 105.w,
              height: 36.w,
              borderRadius: BorderRadius.circular(18.w),
              backgroundColor: buttonBg,
              textStyle: kTextStyle(buttonTextColor,
                  fontsize: 15.w, weight: FontWeight.bold),
              onTap: () {
                if (isPay) {
                  ///购买
                  controller.purchaseVideoAction();
                } else {
                  Get.toVip();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
