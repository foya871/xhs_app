/*
 * @Author: david wumingshi555888@gmail.com
 * @Date: 2025-03-01 17:50:07
 * @LastEditors: david wumingshi555888@gmail.com
 * @LastEditTime: 2025-03-01 18:02:20
 * @FilePath: /xhs_app/lib/components/comics_cell/comics_cell.dart
 * @Description: 
 * Copyright (c) 2025 by ${git_name} email: ${git_email}, All Rights Reserved.
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/assets/styles.dart';
import 'package:xhs_app/components/ad_banner/insert_ad.dart';
import 'package:xhs_app/model/axis_cover.dart';
import 'package:xhs_app/model/comics/comics_base.dart';
import 'package:xhs_app/routes/routes.dart';
import 'package:xhs_app/utils/color.dart';
import '../image_view.dart';

class ComicsCell extends StatelessWidget {
  final ComicsBaseModel model;

  const ComicsCell({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    if (model.isAd) {
      return InsertAd(
        adress: model.ad!,
        height: 120.w,
        showMark: false,
        showName: true,
        borderRadius: Styles.borderRaidus.m,
        spacing: 5.w,
      );
    }

    return InkWell(
      onTap: () {
        Get.toComicsDetail(comicsId: model.comicsId ?? 0);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ImageView(
                src: "${model.coverImg}",
                width: double.infinity,
                height: 120.w,
                fit: BoxFit.cover,
                borderRadius: Styles.borderRaidus.m,
                axis: CoverImgAxis.horizontal,
              ),
              Positioned(
                  top: 6.w,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: (model.isEnd ?? false)
                            ? Color(0xFFFF8652)
                            : Color(0xFFFF4B5F),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20.w),
                            bottomRight: Radius.circular(20.w))),
                    width: 40.w,
                    height: 16.w,
                    child: Text(
                      (model.isEnd ?? false) ? "已完结" : "连载中",
                      style: TextStyle(fontSize: 10.w, color: Colors.white),
                    ),
                  ))
            ],
          ),
          SizedBox(height: 5.w),
          Text(
            model.comicsTitle ?? "",
            style: TextStyle(fontSize: 13.w, color: COLOR.color_333333),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
