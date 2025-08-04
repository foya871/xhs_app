/*
 * @Author: wangdazhuang
 * @Date: 2025-03-03 16:48:58
 * @LastEditTime: 2025-03-03 18:53:30
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /xhs_app/lib/views/launch/launch_classify_page.dart
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/assets/styles.dart';
import 'package:xhs_app/components/easy_button.dart';
import 'package:xhs_app/components/image_view.dart';
import 'package:xhs_app/generate/app_image_path.dart';
import 'package:xhs_app/utils/color.dart';
import 'package:xhs_app/utils/extension.dart';
import 'package:xhs_app/launch_classify_controller.dart';

class LaunchClassifyPage extends GetView<LaunchClassifyController> {
  const LaunchClassifyPage({super.key});

  Widget _buildList() {
    final containerW = 310.w;
    final gap = 12.w;
    final itemW = (containerW - gap * 2) / 3.0;
    return Expanded(
      child: SizedBox(
        width: containerW,
        child: Obx(
          () => SingleChildScrollView(
            child: Wrap(
              runSpacing: gap,
              spacing: gap,
              children: controller.list.map((e) {
                final selected = controller.selectedItems.contains(e);
                final img = selected
                    ? AppImagePath.icons_check_y
                    : AppImagePath.icons_check_white;
                return Container(
                  width: itemW,
                  height: itemW,
                  clipBehavior: Clip.hardEdge,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(6.w)),
                  child: Stack(
                    children: [
                      ImageView(
                        src: e.classifyImg,
                        width: itemW,
                        height: itemW,
                      ),
                      Positioned(
                        left: 5.w,
                        bottom: 5.w,
                        child: Text(
                          e.classifyTitle,
                          style: kTextStyle(Colors.white,
                              fontsize: 14.w, weight: FontWeight.w500),
                        ),
                      ),
                      Positioned(
                        top: 5.w,
                        right: 5.w,
                        child: Image.asset(
                          img,
                          width: 18.w,
                          height: 18.w,
                        ),
                      )
                    ],
                  ),
                ).onTap(() => controller.toggleItem(e));
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBtn() {
    return Obx(() {
      final count = controller.selectedItems.length;
      final enable = controller.selectedItems.length >= 4;
      final bgColor = enable
          ? COLOR.playerThemeColor
          : COLOR.playerThemeColor.withOpacity(0.6);
      return EasyButton(
        "至少关注4个兴趣($count/4)",
        textStyle:
            kTextStyle(Colors.white, fontsize: 14.w, weight: FontWeight.w500),
        width: 310.w,
        height: 40.w,
        borderRadius: BorderRadius.circular(20.w),
        backgroundColor: bgColor,
        onTap: () {
          if (enable) {
            controller.savePreferenceClassifyList();
          }
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('选择感兴趣内容',
                  style: kTextStyle(Colors.black,
                      fontsize: 18.w, weight: FontWeight.bold)),
              15.w.verticalSpaceFromWidth,
              Text('根据兴趣，为你推送个性化的内容',
                  style: kTextStyle(COLOR.color_999999, fontsize: 13.w)),
              10.w.verticalSpaceFromWidth,
              _buildList(),
              15.w.verticalSpaceFromWidth,
              _buildBtn(),
              10.w.verticalSpaceFromWidth,
            ],
          ),
        ),
      ),
      backgroundColor: COLOR.color_FAFAFA,
    );
  }
}
