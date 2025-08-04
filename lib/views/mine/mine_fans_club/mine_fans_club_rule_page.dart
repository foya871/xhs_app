import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/components/app_bar/app_bar_view.dart';
import 'package:xhs_app/components/image_view.dart';
import 'package:xhs_app/components/text_view.dart';
import 'package:xhs_app/generate/app_image_path.dart';
import 'package:xhs_app/utils/color.dart';

class MineFansClubRulePage extends StatelessWidget {
  const MineFansClubRulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLOR.color_FAFAFA,
      appBar: AppBarView(
        titleText: "私人团规则",
      ),
      body: Column(
        children: [
          ImageView(
            src: AppImagePath.mine_icon_fans_rule,
            width: 338.w,
            height: 264.w,
          ),
        ],
      ).marginOnly(left: 11.w, right: 11.w, top: 16.w),
    );
  }
}
