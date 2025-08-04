/*
 * @Author: david wumingshi555888@gmail.com
 * @Date: 2025-03-02 12:23:45
 * @LastEditors: david wumingshi555888@gmail.com
 * @LastEditTime: 2025-03-02 12:29:46
 * @FilePath: /xhs_app/lib/components/resource_cell/resource_cell.dart
 * @Description: 
 * Copyright (c) 2025 by ${git_name} email: ${git_email}, All Rights Reserved.
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/assets/colorx.dart';
import 'package:xhs_app/assets/styles.dart';
import 'package:xhs_app/model/axis_cover.dart';
import 'package:xhs_app/model/download_resource_model.dart';
import 'package:xhs_app/routes/routes.dart';

import '../image_view.dart';

class ResourceCell extends StatelessWidget {
  final DownloadResourceModel item;
  const ResourceCell({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toResourceDetail(id: item.resourcesId ?? 0);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageView(
            src: "${item.coverImg}",
            width: double.infinity,
            height: 90.h,
            fit: BoxFit.cover,
            borderRadius: Styles.borderRaidus.m,
            axis: CoverImgAxis.horizontal,
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(
            item.resourcesTitle ?? "",
            style: TextStyle(fontSize: 13.w, color: ColorX.color_333333),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
