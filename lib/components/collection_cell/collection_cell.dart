/*
 * @Author: david wumingshi555888@gmail.com
 * @Date: 2025-02-20 23:07:21
 * @LastEditors: david wumingshi555888@gmail.com
 * @LastEditTime: 2025-03-01 19:45:28
 * @FilePath: /xhs_app/lib/components/collection_cell/collection_cell.dart
 * @Description: 
 * Copyright (c) 2025 by ${git_name} email: ${git_email}, All Rights Reserved.
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/assets/styles.dart';
import 'package:xhs_app/components/text_view.dart';
import 'package:xhs_app/generate/app_image_path.dart';
import 'package:xhs_app/routes/routes.dart';
import 'package:xhs_app/utils/extension.dart';

import '../../model/community/collection_base_model.dart';
import '../../utils/color.dart';
import '../image_view.dart';

class CollectionCell extends StatelessWidget {
  final CollectionBaseModel model;
  final int index;
  final bool? isManage;
  const CollectionCell(
      {super.key,
      required this.model,
      required this.index,
      this.isManage = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isManage == true ? 316.w : 332.w,
      height: 72.w,
      padding: EdgeInsets.only(left: 8.w, right: 8.w),
      margin: EdgeInsets.only(bottom: 10.w),
      decoration: BoxDecoration(
        color: COLOR.white,
        borderRadius: BorderRadius.circular(8.w),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Stack(
                children: [
                  ImageView(
                    src: model.collectionCoverImg ?? "",
                    width: 48.w,
                    height: 48.w,
                    borderRadius: BorderRadius.circular(8.w),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("${model.collectionName}",
                      style: kTextStyle(COLOR.color_333333, fontsize: 13.w)),
                  Text(
                    "收录${model.dynamicNum}个笔记",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: kTextStyle(COLOR.color_999999, fontsize: 12.w),
                  ).marginOnly(top: 3.w),
                ],
              ).marginLeft(8.w),
            ],
          ),
          Row(
            children: [
              TextView(
                text: "详情",
                color: COLOR.hexColor("#999999"),
                fontSize: 13.w,
                fontWeight: FontWeight.w500,
              ).marginRight(8.w),

              // const Spacer(),
              ImageView(
                src: AppImagePath.icons_icon_right,
                width: 6.w,
                height: 10.w,
              )
            ],
          ),
        ],
      ),
    ).onOpaqueTap(() {
      Get.toBloggerCollectionDetail(model.collectionId ?? 0);
    });
  }
}
