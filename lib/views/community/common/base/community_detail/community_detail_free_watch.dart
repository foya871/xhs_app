import 'package:flutter/material.dart';
import 'package:xhs_app/generate/app_image_path.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// 免费观看
class CommunityDetailFreeWatch extends StatelessWidget {
  const CommunityDetailFreeWatch({super.key});

  @override
  Widget build(BuildContext context) => Image.asset(
        AppImagePath.community_detail_free_watch,
        width: 66.w,
        height: 25.w,
      );
}
