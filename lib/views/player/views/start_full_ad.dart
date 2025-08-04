/*
 * @Author: wdz
 * @Date: 2025-06-25 09:29:50
 * @LastEditTime: 2025-06-25 19:44:39
 * @LastEditors: wdz
 * @Description: 
 * @FilePath: /xhs_app/lib/views/player/views/start_full_ad.dart
import '../controllers/video_play_controller.dart';s/player/views/start_full_ad.dart
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xhs_app/utils/extension.dart';

import '../../../assets/styles.dart';
import '../../../components/easy_button.dart';
import '../../../components/image_view.dart';
import '../../../utils/ad_jump.dart';
import '../controllers/video_play_controller.dart';

class StartFullAd extends StatelessWidget {
  final VideoPlayController vc;
  const StartFullAd({super.key, required this.vc});

  VideoPlayController get _ => vc;

  bool get hasAd =>
      _.playerInitialized.value && _.fullAd != null && _.showFullAd;

  ///跳转
  void jumpForceAd() {
    jumpExternalAddress(_.fullAd?.adJump ?? '', {
      "adId": _.fullAd?.adId ?? 0,
      "forceAd": _.currentVideo.value.forceAd ?? false,
    });
  }

  void _dismissForceAd() {
    _.showFullAd = false;
    _.player?.play();
    _.showTimerAd = true;
    _.update();
  }

  @override
  Widget build(BuildContext context) {
    if (!hasAd) return const SizedBox.shrink();
    final buttonTxt = _.fullAdTimerCount > 0 ? '${_.fullAdTimerCount}s' : '跳过';
    return SizedBox(
      height: VideoPlayController.videoH,
      width: double.infinity,
      child: Stack(
        children: [
          ImageView(
            src: _.fullAd?.adImage ?? '',
            width: double.infinity,
            height: VideoPlayController.videoH,
            fit: BoxFit.fill,
          ).onTap(() => jumpForceAd()),
          Positioned(
            right: 12.w,
            bottom: 12.w,
            child: EasyButton(
              buttonTxt,
              textStyle: kTextStyle(Colors.white, fontsize: 14.w),
              width: 80.w,
              height: 30.w,
              backgroundColor: Colors.black.withOpacity(0.8),
              borderRadius: BorderRadius.circular(15.w),
              onTap: () {
                final count = _.fullAdTimerCount;
                if (count > 0) {
                  jumpForceAd();
                  return;
                }
                final force = _.currentVideo.value.forceAd ?? false;
                if (force) {
                  jumpForceAd();
                  _dismissForceAd();
                  return;
                }
                _dismissForceAd();
              },
            ),
          )
        ],
      ),
    );
  }
}
