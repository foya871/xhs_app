import 'package:flutter/material.dart';
import 'package:xhs_app/generate/app_image_path.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommunityVideoPauseButton extends StatelessWidget {
  const CommunityVideoPauseButton({super.key});

  @override
  Widget build(BuildContext context) => Image.asset(
        AppImagePath.icons_play_white,
        width: 60.w,
        height: 60.w,
      );
}
