import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/components/app_bg_view.dart';
import 'package:xhs_app/components/image_view.dart';
import 'package:xhs_app/components/save_screen/save_screen.dart';
import 'package:xhs_app/components/text_view.dart';
import 'package:xhs_app/generate/app_image_path.dart';
import 'package:xhs_app/utils/app_utils.dart';
import 'package:xhs_app/utils/extension.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';

import '../../../../utils/color.dart';
import 'agent_page_controller.dart';

///代理赚钱
class AgentPage extends GetView<AgentPageController> {
  const AgentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBodyView(),
    );
  }

  _buildBodyView() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ///二维码推广
            10.verticalSpace, _buildAgentShareView(),

            ///保存和分享
            24.verticalSpace, _buildSaveAndShareView(),

            40.verticalSpace,
          ],
        ),
      ),
    );
  }

  ///二维码推广
  _buildAgentShareView() {
    return Screenshot(
      controller: controller.screenshotControllers,
      child: Column(
        children: [
          AppBgView(
            width: 326.w,
            height: 364.w,
            imagePath: controller.cardBg,
            alignment: Alignment.bottomCenter,
          ),
          AppBgView(
              imagePath: AppImagePath.mine_icon_share_bg,
              child: AppBgView(
                width: 310.w,
                height: 139.w,
                imagePath: AppImagePath.mine_icon_qrcode_bg,
                padding: EdgeInsets.only(bottom: 8.w, top: 9.w, left: 16.w),
                margin: EdgeInsets.symmetric(horizontal: 9.w, vertical: 12.w),
                child: Row(
                  children: [
                    Container(
                        margin: EdgeInsets.only(right: 9.w),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: COLOR.hexColor("dedede")),
                            borderRadius: BorderRadius.circular(6.w)),
                        width: 102.w,
                        height: 102.w,
                        child: Center(
                          child: Obx(() => QrImageView(
                                padding: EdgeInsets.all(1.w),
                                data: controller.url.value,
                                size: 102.w,
                                backgroundColor: Colors.white,
                              )),
                        )),
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextView(
                          text: "我的推广码：",
                          color: COLOR.color_333333,
                          fontSize: 15.w,
                        ),
                        3.verticalSpace,
                        TextView(
                          text: controller.inviteCode.value,
                          color: COLOR.color_333333,
                          fontSize: 20.w,
                        ),
                        8.verticalSpace,
                        Obx(() => TextView(
                              text: controller.domainFromUrl.value,
                              color: COLOR.color_333333,
                              fontSize: 16.w,
                            )),
                      ],
                    )),
                  ],
                ),
              ))
        ],
      ),
    );
  }

  ///保存和分享
  _buildSaveAndShareView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image.asset(
          AppImagePath.mine_agent_save_picture,
          height: 44.w,
          width: 150.w,
          fit: BoxFit.fitHeight,
        ).onTap(() {
          SaveScreen.onCaptureClick(
              Get.context!, controller.screenshotControllers,
              isBack: false);
        }),
        Image.asset(
          AppImagePath.mine_agent_copy_link,
          height: 44.w,
          width: 150.w,
          fit: BoxFit.fitHeight,
        ).onTap(() {
          AppUtils.copyToClipboard(controller.url.value);
        }),
      ],
    );
  }
}
