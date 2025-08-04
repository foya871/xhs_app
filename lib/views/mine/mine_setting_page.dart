/*
 * @Author: david wumingshi555888@gmail.com
 * @Date: 2025-03-02 16:34:13
 * @LastEditors: david wumingshi555888@gmail.com
 * @LastEditTime: 2025-03-03 22:12:32
 * @FilePath: /xhs_app/lib/views/mine/mine_setting_page.dart
 * @Description: 我的设置
 * Copyright (c) 2025 by ${git_name} email: ${git_email}, All Rights Reserved.
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/assets/styles.dart';
import 'package:xhs_app/components/app_bar/app_bar_view.dart';
import 'package:xhs_app/components/image_view.dart';
import 'package:xhs_app/components/text_view.dart';
import 'package:xhs_app/generate/app_image_path.dart';
import 'package:xhs_app/routes/routes.dart';
import 'package:xhs_app/utils/extension.dart';
import 'package:xhs_app/views/mine/frontpage/controller/mine_setting_controller.dart';

import '../../assets/colorx.dart';
import '../../utils/color.dart';

class MineSettingPage extends GetView<MineSettingController> {
  const MineSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLOR.color_FAFAFA,
      appBar: AppBarView(
        titleText: "设置",
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 14.w, right: 14.w),
            height: 64.w,
            alignment: Alignment.centerLeft,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: COLOR.color_F0F0F0,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                TextView(
                  text: "账号密码",
                  fontSize: 14.w,
                  fontWeight: FontWeight.w400,
                  color: COLOR.color_333333,
                ),
                Expanded(
                    child: Text(
                  controller.us.user.account ?? '未设置',
                  textAlign: TextAlign.right,
                  style: kTextStyle(Colors.black, fontsize: 15.w),
                )),
                SizedBox(width: 5.w),
                ImageView(
                  src: AppImagePath.icons_icon_right,
                  width: 6.w,
                  height: 10.w,
                )
              ],
            ),
          ).onOpaqueTap(() {
            Get.toNamed(Routes.login);
          }),
          Container(
            margin: EdgeInsets.only(left: 14.w, right: 14.w),
            height: 64.w,
            alignment: Alignment.centerLeft,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: COLOR.color_F0F0F0,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextView(
                  text: "找回账号",
                  fontSize: 14.w,
                  fontWeight: FontWeight.w400,
                  color: COLOR.color_333333,
                ),
                ImageView(
                  src: AppImagePath.icons_icon_right,
                  width: 6.w,
                  height: 10.w,
                )
              ],
            ),
          ).onOpaqueTap(() {
            Get.toNamed(Routes.retrieveaccount);
          }),
          Container(
            margin: EdgeInsets.only(left: 14.w, right: 14.w),
            height: 64.w,
            alignment: Alignment.centerLeft,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: COLOR.color_F0F0F0,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextView(
                  text: "清除缓存",
                  fontSize: 14.w,
                  fontWeight: FontWeight.w400,
                  color: COLOR.color_333333,
                ),
                Row(
                  children: [
                    Obx(
                      () => Text(
                        controller.imageCachesize.value,
                        style: TextStyle(
                          fontSize: 14.w,
                          color: ColorX.color_999999,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    ImageView(
                      src: AppImagePath.icons_icon_right,
                      width: 6.w,
                      height: 10.w,
                    ).paddingLeft(9.w)
                  ],
                )
              ],
            ),
          ).onOpaqueTap(() {
            controller.onClick(3);
          }),
          Container(
            margin: EdgeInsets.only(left: 14.w, right: 14.w),
            height: 64.w,
            alignment: Alignment.centerLeft,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: COLOR.color_F0F0F0,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextView(
                  text: "检查更新",
                  fontSize: 14.w,
                  fontWeight: FontWeight.w400,
                  color: COLOR.color_333333,
                ),
                Row(
                  children: [
                    Obx(() => Text(
                          '${controller.version.value}',
                          style: TextStyle(
                            fontSize: 14.w,
                            color: ColorX.color_999999,
                            fontWeight: FontWeight.w600,
                          ),
                        )),
                    ImageView(
                      src: AppImagePath.icons_icon_right,
                      width: 6.w,
                      height: 10.w,
                    ).paddingLeft(9.w)
                  ],
                )
              ],
            ),
          )
        ],
      ).marginTop(6.w),
    );
  }
}
