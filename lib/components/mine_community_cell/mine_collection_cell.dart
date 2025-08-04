/*
 * @Author: david wumingshi555888@gmail.com
 * @Date: 2025-02-26 21:24:00
 * @LastEditors: david wumingshi555888@gmail.com
 * @LastEditTime: 2025-03-03 20:59:24
 * @FilePath: /xhs_app/lib/components/mine_community_cell/mine_collection_cell.dart
 * @Description: 
 * Copyright (c) 2025 by ${git_name} email: ${git_email}, All Rights Reserved.
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xhs_app/components/image_view.dart';
import 'package:xhs_app/model/community/collection_base_model.dart';
import 'package:xhs_app/utils/extension.dart';

import '../../generate/app_image_path.dart';
import '../../utils/color.dart';
import '../text_view.dart';

class MineCollectionCell extends StatelessWidget {
  final CollectionBaseModel model;
  final int from;
  const MineCollectionCell(
      {super.key, required this.model, required this.from});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 332.w,
      height: 72.w,
      // margin: EdgeInsets.only(bottom: 10.w),
      padding: EdgeInsets.only(left: 8.w, right: 8.w),
      decoration: BoxDecoration(
          color: COLOR.white, borderRadius: BorderRadius.circular(8.w)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ImageView(
                src: model.collectionCoverImg ?? "",
                width: 48.w,
                height: 48.w,
                borderRadius: BorderRadius.circular(6.w),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextView(
                    text: "${model.collectionName}",
                    color: COLOR.hexColor("#333333"),
                    fontSize: 13.w,
                    fontWeight: FontWeight.w500,
                  ),
                  TextView(
                    text: "收录${model.dynamicNum}个笔记",
                    color: COLOR.hexColor("#999999"),
                    fontSize: 12.w,
                    fontWeight: FontWeight.w400,
                  ).marginTop(4.w),
                ],
              ).marginLeft(8.w)
            ],
          ),
          if (from == 1)
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
    );
  }
}
