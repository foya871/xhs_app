import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/assets/styles.dart';
import 'package:xhs_app/generate/app_image_path.dart';
import 'package:xhs_app/model/choice/choice_models.dart';
import 'package:xhs_app/routes/routes.dart';
import 'package:xhs_app/utils/ad_jump.dart';
import 'package:xhs_app/utils/color.dart';
import 'package:xhs_app/utils/extension.dart';

class ShiPinChoiceCell extends StatelessWidget {
  final VideoChoiceModel model;

  const ShiPinChoiceCell(this.model, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 87.w,
      height: 32.w,
      decoration: BoxDecoration(
        borderRadius: Styles.borderRadius.all(4.w),
        color: COLOR.color_393939,
      ),
      alignment: Alignment.center,
      child: model.isAi
          ? Image.asset(
              AppImagePath.shi_pin_ai_entry,
              width: 47.w,
              height: 17.w,
            )
          : Text(
              model.choiceName,
              style: TextStyle(color: COLOR.white, fontSize: 14.w),
            ),
    ).onTap(() {
      if (model.isAi) {
       jump2Ai();
      } else {
        Get.toChoiceDetail(model);
      }
    });
  }
}
