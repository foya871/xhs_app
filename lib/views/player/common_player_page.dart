/*
 * @Author: wangdazhuang
 * @Date: 2024-08-29 19:08:07
 * @LastEditTime: 2025-03-12 10:05:55
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /xhs_app/lib/views/player/common_player_page.dart
 */
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:xhs_app/utils/color.dart';
import 'package:xhs_app/views/player/controllers/common_video_play_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xhs_app/views/player/views/av_player_loading.dart';
import 'views/media_kit_custom_controls.dart' as custom;

class CommonPlayerPage extends GetView<CommonVideoPlayerController> {
  const CommonPlayerPage({super.key});

  ///web上推出全屏后的自动播放
  void _autoPlayForWeb() {
    Timer.periodic(
      const Duration(milliseconds: 1000),
      (timer) {
        controller.player?.play();
        timer.cancel();
      },
    );
  }

  _buildPlayer() {
    final context = Get.context!;
    final videoH = Get.height;
    final themColor = COLOR.hexColor("#B940FF");
    final playerVC = controller.playerVC!;
    final controls = MaterialVideoControlsTheme(
      normal: MaterialVideoControlsThemeData(
        seekBarPositionColor: themColor,
        seekBarThumbColor: themColor,
        seekBarMargin: const EdgeInsets.only(bottom: 25),
      ),
      fullscreen: MaterialVideoControlsThemeData(
        seekBarPositionColor: themColor,
        seekBarThumbColor: themColor,
        seekBarMargin: const EdgeInsets.only(bottom: 15),
      ),
      child: custom.MediaKitCustomControls(
        buildContext: context,
        viewSize: Size(Get.width, videoH),
        texturePos: Rect.fromLTWH(0, 0, Get.width, videoH),
      ),
    );
    return Video(
      key: const Key('c-video-player'),
      controller: playerVC,
      filterQuality: FilterQuality.none,
      controls: (__) => Stack(
        children: [controls],
      ),
      onEnterFullscreen: () async {
        _autoPlayForWeb();
      },
      onExitFullscreen: () async {
        _autoPlayForWeb();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: COLOR.black,
        body: controller.obx((_) {
          if (!controller.playerInitialized.value ||
              controller.playerVC == null) {
            return const AvPlayerLoading();
          }
          return Center(
            child: SizedBox(
              height: Get.height,
              child: _buildPlayer(),
            ),
          );
        }),
      ),
    );
  }
}
