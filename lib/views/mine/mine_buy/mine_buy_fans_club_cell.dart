import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:xhs_app/components/image_view.dart';
import 'package:xhs_app/components/text_view.dart';
import 'package:xhs_app/model/mine/fans_club_model.dart';
import 'package:xhs_app/routes/routes.dart';
import 'package:xhs_app/utils/color.dart';
import 'package:xhs_app/utils/extension.dart';

class MineBuyFansClubCell extends StatelessWidget {
  final FansClubModel model;

  const MineBuyFansClubCell({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 14.w, right: 14.w, bottom: 14.w),
      width: double.infinity,
      height: 64.w,
      child: Flex(
        direction: Axis.horizontal,
        children: [
          ImageView(
              src: model.groupLogo ?? '',
              width: 44.w,
              height: 44.w,
              borderRadius: BorderRadius.circular(50),
              fit: BoxFit.fill),
          SizedBox(width: 8.w),
          Expanded(
              child: TextView(
                  text: model.groupName ?? '',
                  fontSize: 12.w,
                  color: COLOR.white,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis)),
        ],
      ),
    ).onTap(() => Get.toBloggerPrivateGroup(userId: model.userId!));
  }
}
