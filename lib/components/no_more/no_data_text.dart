import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xhs_app/assets/colorx.dart';

class NoDataText extends StatelessWidget {
  final String tips;
  final int height;
  const NoDataText({super.key, this.tips = '空空如也~~', this.height = 50});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: height.h,
      child: Text(
        tips,
        style: TextStyle(color: ColorX.color_666666, fontSize: 14.w),
      ),
    );
  }
}
