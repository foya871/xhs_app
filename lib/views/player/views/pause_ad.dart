import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xhs_app/components/ad/ad_info_model.dart';
import 'package:xhs_app/utils/ad_jump.dart';
import 'package:xhs_app/utils/extension.dart';
import 'package:xhs_app/views/player/controllers/video_play_controller.dart';

import '../../../components/image_view.dart';

class PauseAd extends StatelessWidget {
  final VideoPlayController controller;
  const PauseAd({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    if (controller.stopAd.value == AdInfoModel.fromJson({})) {
      return const SizedBox.shrink();
    }
    if (!controller.showStopAd.value) return const SizedBox.shrink();
    final ad = controller.stopAd.value;
    return Positioned.fill(
      child: Container(
        color: Colors.black.withOpacity(0.6),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageView(
              src: ad.adImage ?? '',
              fit: BoxFit.fill,
              clipWidth: null,
              width: 230.w,
              height: 135.w,
            ).onTap(() {
              kAdjump(ad);
            }),
            12.horizontalSpace,
            Icon(
              Icons.cancel_outlined,
              color: Colors.white,
              size: 30.w,
            ).onTap(() {
              controller.showStopAd.value = false;
              controller.update();
            }),
          ],
        ),
      ),
    );
  }
}
