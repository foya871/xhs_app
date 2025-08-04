import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/assets/styles.dart';
import 'package:xhs_app/model/axis_cover.dart';
import 'package:xhs_app/model/picture_cell_model/picture_cell_model.dart';
import 'package:xhs_app/routes/routes.dart';
import 'package:xhs_app/utils/color.dart';
import 'package:xhs_app/utils/extension.dart';

import '../image_view.dart';

class PortrayCell extends StatelessWidget {
  final PictureCellModel item;
  const PortrayCell({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            ImageView(
              src: item.coverImg ?? "",
              width: double.infinity,
              height: 140.h,
              fit: BoxFit.cover,
              borderRadius: Styles.borderRaidus.m,
              axis: CoverImgAxis.horizontal,
            ),
            Positioned(
                right: 5.w,
                bottom: 5.w,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(80),
                    borderRadius: BorderRadius.all(Radius.circular(35)),
                  ),
                  child: Text(
                    "${item.imgNum}张",
                    style: TextStyle(fontSize: 10.w, color: Colors.white),
                  ),
                ))
          ],
        ),
        SizedBox(
          height: 5.h,
        ),
        Text(
          item.title ?? "",
          style: TextStyle(fontSize: 13.w, color: COLOR.color_333333),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ).onOpaqueTap(() {
      Get.toPortrayPlay(portrayPicId: item.portrayPicId ?? 0);
    });
  }
}
