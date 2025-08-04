/*
 * @Author: wangdazhuang
 * @Date: 2025-01-21 19:02:29
 * @LastEditTime: 2025-01-24 09:41:29
 * @LastEditors: wangdazhuang
 * @Description:  
 * @FilePath: /xhs_app/lib/views/media_viewer/media_viewer_page.dart
 */
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:xhs_app/assets/styles.dart';
import 'package:xhs_app/components/image_view.dart';
import 'package:xhs_app/utils/logger.dart';
import 'package:xhs_app/views/media_viewer/media_viewer_controller.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:xhs_app/views/player/views/media_kit_custom_controls.dart'
    as custom;

class MediaViewerPage extends GetView<MediaViewerController> {
  const MediaViewerPage({super.key});

  Widget _buildPlayerBox(
      {required String item, required BuildContext context}) {
    final videoH = Get.width / 16.0 * 9.0;
    final controls = MaterialVideoControlsTheme(
      normal: const MaterialVideoControlsThemeData(),
      fullscreen: const MaterialVideoControlsThemeData(),
      child: custom.MediaKitCustomControls(
        buildContext: context,
        viewSize: Size(Get.width, videoH),
        texturePos: Rect.fromLTWH(0, 0, Get.width, videoH),
        hideBack: true,
      ),
    );
    return VisibilityDetector(
      key: Key(item),
      child: Center(
        child: Video(
          filterQuality: FilterQuality.none,
          controller: controller.playerVC!,
          controls: (__) => Stack(children: [controls]),
          fit: BoxFit.fitWidth,
        ),
      ),
      onVisibilityChanged: (info) {
        if (Get.isRegistered<MediaViewerController>() ||
            Get.isPrepared<MediaViewerController>()) {
          controller.visibleVideo(visible: info.visibleFraction == 1.0);
        }
      },
    );
  }


  Widget _buildImageView({required String item}) {
    return Center(
      child: SizedBox(
        width: Get.width,
        height: double.infinity,
        child: ImageView(
          src: item,
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }

  Widget _buildCenterBox() {
    final count = controller.sources.length;
    if (count == 0) return const SizedBox.shrink();
    return Positioned.fill(
      child: CarouselSlider.builder(
        itemCount: count,
        itemBuilder: (context, index, pageViewIndex) {
          final item = controller.sources[index];
          final isVideo = item.contains("m3u8");
          if (isVideo) return _buildPlayerBox(context: context, item: item);
          return _buildImageView(item: item);
        },
        options: CarouselOptions(
          autoPlay: false,
          enlargeCenterPage: true,
          viewportFraction: 1,
          onPageChanged: (index, reason) {
            controller.currentIndex.value = index + 1;
          },
        ),
      ),
    );
  }

  Widget _buildExtra() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: SafeArea(
        child: Text(
          controller.title.value,
          textAlign: TextAlign.center,
          style: kTextStyle(Colors.white, fontsize: 15.w),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final count = controller.sources.length;
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text('${controller.currentIndex.value}/$count')),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            _buildCenterBox(),
            _buildExtra(),
          ],
        ),
      ),
    );
  }
}
