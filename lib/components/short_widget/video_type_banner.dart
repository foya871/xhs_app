import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xhs_app/generate/app_image_path.dart';
import 'package:xhs_app/utils/color.dart';

import '../../assets/styles.dart';
import '../../utils/enum.dart';
import '../../utils/extension.dart';

class VideoTypeBanner extends StatelessWidget {
  final VideoTypeEnum videoType;
  final double? price;
  final bool? showFree;
  const VideoTypeBanner(
      {super.key, required this.videoType, required this.price, this.showFree});
  @override
  Widget build(BuildContext context) {
    Widget? child;
    if (videoType == VideoTypeValueEnum.Pay) {
      final gold = (price ?? .0).toStringAsShort();
      child = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(AppImagePath.icons_gold, width: 13.w, height: 13.w),
          SizedBox(width: 3.w),
          Text(
            gold,
            style: TextStyle(
              fontSize: Styles.fontSize.xs,
              color: COLOR.white,
            ),
          )
        ],
      );
    } /* else if (videoType == VideoTypeValueEnum.VIP) {
      text = 'VIP';
    } else if (showFree == true && videoType == VideoTypeValueEnum.Commmon) {
      text = '免费';
    }*/
    else {
      return const SizedBox.shrink();
    }

    return Container(
      width: 38.w,
      height: 18.w,
      decoration: BoxDecoration(
        borderRadius: Styles.borderRadius.mDiagonalRight,
        color: COLOR.color_F52443,
      ),
      child: Center(child: child),
    );
  }
}
