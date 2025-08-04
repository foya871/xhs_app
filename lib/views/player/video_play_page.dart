/*
 * @Author: wangdazhuang
 * @Date: 2024-08-19 11:55:58
 * @LastEditTime: 2025-06-25 19:49:31
 * @LastEditors: wdz
 * @Description: 
 * @FilePath: /xhs_app/lib/views/player/video_play_page.dart
 */
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:xhs_app/views/player/controllers/video_play_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:xhs_app/views/player/views/timer_ad.dart';
import '../../utils/color.dart';
import 'views/av_player_loading.dart';
import 'views/media_kit_custom_controls.dart' as custom;
import 'views/pause_ad.dart';
import 'views/permission_ui.dart';
import 'views/start_full_ad.dart';
import 'views/video_common_box.dart';

class VideoPlayPage extends GetView<VideoPlayController> {
  const VideoPlayPage({super.key});

  _buildPlayerBox(BuildContext context) {
    if (!controller.playerInitialized.value || controller.playerVC == null) {
      return SizedBox(
        width: Get.width,
        height: VideoPlayController.videoH,
        child: const AvPlayerLoading(),
      );
    }
    final videoH = VideoPlayController.videoH;
    const themColor = COLOR.playerThemeColor;
    final playervc = controller.playerVC!;
    final key = Key('${controller.currentVideo.value.videoId ?? 0}');
    const themeData = MaterialVideoControlsThemeData(
      seekBarPositionColor: themColor,
      seekBarThumbColor: themColor,
      seekBarAlignment: Alignment.center,
    );
    final controls = MaterialVideoControlsTheme(
      normal: themeData,
      fullscreen: themeData,
      child: custom.MediaKitCustomControls(
        buildContext: context,
        viewSize: Size(Get.width, videoH),
        texturePos: Rect.fromLTWH(0, 0, Get.width, videoH),
      ),
    );

    return Video(
      key: key,
      filterQuality: FilterQuality.none,
      controller: playervc,
      controls: (__) => controls,
      onEnterFullscreen: () async {
        _autoPlay();
        if (!kIsWeb) {
          SystemChrome.setPreferredOrientations(
              [DeviceOrientation.landscapeLeft]);
        }
      },
      onExitFullscreen: () async {
        _autoPlay();
        if (!kIsWeb) {
          SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
        }
      },
    );
  }

  ///离开或者进入该页面
  _visibleChangeAction(VisibilityInfo info) {
    if (info.visibleFraction == 0.0) {
      /// push了或者销毁了
      final isLive = Get.isRegistered<VideoPlayController>() ||
          Get.isPrepared<VideoPlayController>();
      if (isLive) {
        ///暂停
        Get.find<VideoPlayController>().player?.pause();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key('video-player'),
      onVisibilityChanged: _visibleChangeAction,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          backgroundColor: COLOR.white,
          body: controller.obx(
            (_) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: VideoPlayController.videoH,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        _buildPlayerBox(context),
                        PermissionUi(controller: controller),
                        PauseAd(controller: controller),
                        StartFullAd(vc: controller),
                        if (controller.showTimerAd)
                          Positioned(
                            left: 0,
                            bottom: 45.w,
                            child: const TimerAd(),
                          )
                      ],
                    ),
                  ),
                  VideoCommonBox(controller: controller),
                ],
              );
            },
            onLoading: const AvPlayerLoading(),
          ),
        ),
      ),
    );
  }

  void _autoPlay() {
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        controller.player?.play();
        timer.cancel();
      },
    );
  }
}
