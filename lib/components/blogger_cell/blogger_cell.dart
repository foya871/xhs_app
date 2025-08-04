/*
 * @Author: wangdazhuang
 * @Date: 2025-01-27 15:16:19
 * @LastEditTime: 2025-02-21 20:33:45
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /xhs_app/lib/components/blogger_cell/blogger_cell.dart
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/assets/styles.dart';
import 'package:xhs_app/generate/app_image_path.dart';
import 'package:xhs_app/model/blogger_base_model.dart';
import 'package:xhs_app/routes/routes.dart';
import 'package:xhs_app/services/user_service.dart';
import 'package:xhs_app/utils/color.dart';
import 'package:xhs_app/utils/extension.dart';

import '../image_view.dart';

class BloggerCell extends StatelessWidget {
  final int index;
  final BloggerBaseModel model;
  const BloggerCell({super.key, required this.index, required this.model});

  @override
  Widget build(BuildContext context) {
    final userService = Get.find<UserService>();
    return Stack(
      children: [
        Container(
          width: 120.w,
          height: 120.w,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.w)),
          child: ImageView(
            src: model.logo ?? "",
            width: 120.w,
            height: 120.w,
            borderRadius: BorderRadius.circular(8.w),
          ),
        ),
        if ((model.chatVipType ?? 0) > 0)
          Positioned(
            right: 4.w,
            top: 4.w,
            child: ImageView(
              src: AppImagePath.mine_mine_chat_vip,
              height: 19.5.w,
              width: 19.5.w,
            ),
          ),
        if (model.online == true)
          Positioned(
              left: 4.w,
              top: 4.w,
              child: Container(
                width: 10.w,
                height: 10.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.w),
                    color: COLOR.hexColor("#00EC66")),
              )),
        Positioned(
            bottom: 4,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(left: 4.w, bottom: 4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${model.cityName}",
                    style: kTextStyle(COLOR.white, fontsize: 10.w),
                  ),
                  Text(
                    "${model.nickName}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: kTextStyle(COLOR.white, fontsize: 11.w),
                  ),
                ],
              ),
            ))
      ],
    ).onOpaqueTap(() {
      if (index >= 12) {
        if (userService.isVIP) {
          Get.toBloggerDetail(userId: model.userId ?? 0);
        } else {
          Get.toVip(tabInitIndex: 1);
        }
      } else {
        Get.toBloggerDetail(userId: model.userId ?? 0);
      }

      // Get.toBloggerDetail(userId: 1);
    });
  }
}
