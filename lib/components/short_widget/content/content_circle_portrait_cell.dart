import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../model/content_model.dart';
import '../../../routes/routes.dart';
import '../../../utils/extension.dart';
import '../../circle_image.dart';

class ContentCirclePortraitCell extends StatelessWidget {
  final PornographyModel model;
  final double? width;
  final TextStyle? textStyle;

  const ContentCirclePortraitCell(
    this.model, {
    super.key,
    this.textStyle,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 70.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          CircleImage.network(model.headImg, size: width ?? 70.w),
          SizedBox(height: 4.w),
          Text(
            model.contentName,
            maxLines: 1,
            style: textStyle ??
                TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontSize: 12.w,
                ),
          ),
        ],
      ),
    ).onTap(() => Get.toBloggerDetail(userId: model.contentId));
  }
}
