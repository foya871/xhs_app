import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:xhs_app/components/image_view.dart';
import 'package:xhs_app/generate/app_image_path.dart';
import '../../../../components/base_page/base_error_widget.dart';
import '../../../../utils/color.dart';
import '../../../../utils/extension.dart';
import '../../../player/views/av_player_loading.dart';
import '../controllers/short_video_player_page_controller.dart';
import 'short_v_p_cell_controller.dart';
import 'short_v_p_desc_area.dart';
import 'short_v_p_operation_area.dart';
import 'short_v_p_permission.dart';
import 'short_video_model.dart';
import './media_kit_short_controls.dart' as short;

// ignore: must_be_immutable
class ShortVPCell extends StatelessWidget {
  final ShortVideoModel video;
  final ShortVPCellController controller;

  ShortVPCell(this.video, {super.key, required this.controller});

  late VideoState? _videoState;

  ///根控制器的tag
  String get mainControllerTag => controller.mode!.index.toString();

  Widget _buildPlayOrPauseBtn() {
    return Obx(
      () => Visibility(
        visible: controller.videoPaused.value,
        child: Image.asset(
          AppImagePath.short_short_play_btn,
          width: 71.w,
          height: 71.w,
          fit: BoxFit.cover,
        ).onTap(controller.togglePlayOrPause),
      ),
    );
  }

  Widget _buildPlayerInitState() {
    return Obx(() {
      final state = controller.playerInitialized.value;
      if (state == VPInitState.none) {
        return const AvPlayerLoading();
      } else if (state == VPInitState.error) {
        return BaseErrorWidget(onTap: () => controller.initPlayer());
      } else {
        return const SizedBox.shrink();
      }
    });
  }

  Widget _buildPermission() {
    return Obx(() {
      if (controller.showPermission.value == false || video.detail == null) {
        return const SizedBox.shrink();
      }
      return ShortVPPermission(
        video.detail!,
        onTapCancel: controller.onTapPermissionCancel,
        onTapBuy: controller.onTapPermissionBuy,
      );
    });
  }

  Widget _buildCover(BuildContext context) {
    // if (controller.playerInitialized.value == VPInitState.none) {
    return Positioned.fill(
        child: Center(
      child: ImageView(src: video.detail?.vCover ?? ''),
    ));
    // }
    // return const SizedBox.shrink();
  }

  Widget _buildPlayer(BuildContext context) {
    final themColor = COLOR.hexColor("#B940FF");
    final themData = MaterialVideoControlsThemeData(
      seekBarPositionColor: themColor,
      seekBarThumbColor: themColor,
    );
    final controls = MaterialVideoControlsTheme(
      normal: themData,
      fullscreen: themData,
      child: short.MediaKitShortControls(
        buildContext: context,
        viewSize: Size(Get.width, Get.height),
        texturePos: Rect.fromLTWH(0, 0, Get.width, Get.height),
        playerTitle: video.detail?.title ?? '',
      ),
    );
    return SizedBox(
      width: 1.sw,
      height: 1.sh,
      child: Video(
        key: Key('${video.detail?.videoId ?? 0}'),
        filterQuality: FilterQuality.none,
        fill: Colors.transparent,
        width: Get.width,
        height: 1.sh,
        controls: (state) {
          _videoState = state;
          return controls;
        },
        controller: controller.playerVC!,
      ),
    );
  }

  // void onTapSelectCdn() {
  //   final lines =
  //       Get.find<ShortVideoPlayerPageController>(tag: mainControllerTag)
  //           .cdnLines;
  //   if (lines.isEmpty) return;
  //   SelectCdnLineDialog(
  //     lines,
  //     currentId: video.detail!.cdnRes?.id ?? '',
  //     onTap: controller.onTapSelectCdnConfirm,
  //   ).show();
  // }

  bool _showFullScreenBtn() {
    if (video.detail == null) return false;
    var w = video.detail!.width ?? Get.width;
    if (w == 0) {
      w = Get.width;
    }
    var h = video.detail!.height ?? Get.height;
    if (h == 0) {
      h = Get.height;
    }

    double asp = w / h;
    return asp > 1.7;
  }

  Widget _buildBody(BuildContext context) {
    return Stack(
      children: [
        _buildCover(context),
        // 播放器
        _buildPlayer(context),
        // videoPlayer initialize
        Positioned.fill(child: Center(child: _buildPlayerInitState())),
        // 暂停/播放
        Positioned.fill(child: Center(child: _buildPlayOrPauseBtn())),
        // 左边下 标签/title

        if (video.detail != null)
          Obx(() {
            if (!controller.clearMode.value) {
              return Positioned(
                bottom: 70.w,
                left: 10.w,
                width: 305.w,
                child: ShortVPDescArea(
                  video.detail!,
                  onTapBuy: controller.onTapBuyDesc,
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          }),
        // 右边 收藏/评论等
        if (video.detail != null)
          Positioned(
            right: 10.w,
            bottom: 70.w,
            height: 1.sh,
            child: Obx(() {
              // final webUnmuteTouched = Get.find<ShortVideoPlayerPageController>(
              //         tag: mainControllerTag)
              //     .webUnmuteTouched
              //     .value;
              final clearMode = controller.clearMode.value;
              return ShortVPOperationArea(
                video.detail!,
                topHeight: 190.w,
                clearMode: clearMode,
                onTapSelectCdn: () {},
                onTapClearMode: controller.onTapClearMode,
                // webUnmuteTouched: webUnmuteTouched,
                webMuted: controller.webVolume.value != 100,
                onTapUnmute: controller.toggleMute,
              );
            }),
          ),
        if (video.detail != null &&
            controller.playerInitialized.value == VPInitState.success &&
            _showFullScreenBtn())
          Positioned(
            left: Get.width / 2.0 - 55,
            bottom: 230.w,
            child: Image.asset(
              AppImagePath.short_short_full,
              width: 101,
              height: 34,
            ).onTap(() {
              _videoState?.enterFullscreen();
            }),
          ),
        // 购买
        Positioned.fill(child: _buildPermission()),
      ],
    ).onTap(() {
      controller.togglePlayOrPause();
    });
  }

  @override
  Widget build(BuildContext context) {
    controller.init(video);
    return controller.obx(
      (_) => _buildBody(context),
      onLoading: const AvPlayerLoading(),
      onError: (_) => BaseErrorWidget(
        onTap: () => controller.waitLoadingDetail(forceRetry: true),
      ),
    );
  }
}
