import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/assets/styles.dart';
import 'package:xhs_app/model/axis_cover.dart';
import 'package:xhs_app/model/connotation/connotation_model.dart';
import 'package:xhs_app/routes/routes.dart';
import 'package:xhs_app/utils/color.dart';
import 'package:xhs_app/utils/extension.dart';

import '../image_view.dart';

class ConnotationCell extends StatelessWidget {
  final ConnotationModel item;
  const ConnotationCell({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ImageView(
          src: "${item.coverImg}",
          width: 130.w,
          height: 80.w,
          fit: BoxFit.cover,
          borderRadius: Styles.borderRaidus.m,
          axis: CoverImgAxis.horizontal,
        ),
        SizedBox(
          width: 12.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 180.w,
                  child: Text(
                    item.title ?? "",
                    maxLines: 2,
                    style: TextStyle(fontSize: 13.w, color: COLOR.color_333333),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  width: 140.w,
                  child: Text(
                    item.summary ?? "",
                    style: TextStyle(fontSize: 13.w, color: COLOR.color_333333),
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
            Container(
              width: 120.w,
              child: Text(
                item.checkAt ?? "",
                style: TextStyle(fontSize: 13.w, color: COLOR.color_999999),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        )
      ],
    ).onOpaqueTap(() {
      Get.toNamed(Routes.intensionMapDetailPage, parameters: {
        "connotationId": "${item.connotationId}",
        "title": item.title ?? ""
      });
    });
  }
}
