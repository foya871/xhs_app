import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../components/app_bar/extend_transparent_app_bar.dart';
import '../../../../../generate/app_image_path.dart';
import '../../../../../routes/routes.dart';
import '../../../../../utils/color.dart';
import '../../../../../utils/extension.dart';

// 视频帖子顶部
class CommunityDetailVideoAppBar extends StatelessWidget {
  const CommunityDetailVideoAppBar({super.key});

  @override
  Widget build(BuildContext context) => ExtendTransparentAppBar(
        backColor: COLOR.white,
        actions: [
          Image.asset(
            AppImagePath.community_attention_share_white,
            width: 22.w,
            height: 22.w,
          ).onTap(() => Get.toShare()),
        ],
      );
}
