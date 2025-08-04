import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../components/circle_image.dart';
import '../../../../model/attention/attenion_models.dart';
import '../../../../utils/color.dart';
import 'package:xhs_app/utils/extension.dart';
import 'package:xhs_app/routes/routes.dart';

class ShiPinRecommendUserCell extends StatelessWidget {
  static final double width = 50.w;
  static final double height = 72.w;
  final UserRecommendResp model;

  const ShiPinRecommendUserCell(this.model, {super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Column(
        children: [
          CircleImage.network(model.logo, size: width),
          3.verticalSpaceFromWidth,
          Text(
            model.nickName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: COLOR.color_808080, fontSize: 12.w),
          )
        ],
      ),
    ).onTap(() => Get.toBloggerDetail(userId: model.userId));
  }
}
