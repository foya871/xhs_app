import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:xhs_app/components/easy_toast.dart';
import 'package:xhs_app/components/image_view.dart';
import 'package:xhs_app/components/text_view.dart';
import 'package:xhs_app/generate/app_image_path.dart';
import 'package:xhs_app/utils/ad_jump.dart';
import 'package:xhs_app/utils/color.dart';
import 'package:xhs_app/utils/extension.dart';

import '../../../components/app_bar/app_bar_view.dart';

class MineBloggerAuthenticationPage extends StatelessWidget {
  const MineBloggerAuthenticationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLOR.color_FAFAFA,
      appBar: AppBarView(
        titleText: '博主认证',
      ),
      body: Column(
        children: [
          ImageView(
                  src: AppImagePath.mine_blogger_description,
                  width: 332.w,
                  height: 392.w)
              .marginOnly(top: 10.w, left: 14.w, right: 14.w),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 332.w,
                height: 40.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: COLOR.hexColor("#fb2d45"),
                    borderRadius: BorderRadius.circular(20.w)),
                child: TextView(
                    text: "联系客服认证", fontSize: 14.w, color: COLOR.white),
              ).onOpaqueTap(() {
                kOnLineService();
              }).marginBottom(16.w + ScreenUtil().bottomBarHeight)
            ],
          ))
        ],
      ),
    );
  }
}
