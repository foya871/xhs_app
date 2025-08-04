import 'package:flutter/material.dart';
import 'package:media_kit_video/media_kit_video.dart';

import '../../utils/color.dart';
import '../../utils/enum.dart';
import 'generic_player.dart';
import 'generic_player_model.dart';
import 'generic_player_pause_button.dart';

class FutureGenericPlayerOption extends GenericPlayerOption {
  // load model时
  final Widget Function(BuildContext context)? loadingBuilder;
  // load model 失败时
  final Widget Function(BuildContext context, Object? err)? loadFailBuilder;
  FutureGenericPlayerOption({
    this.loadingBuilder,
    this.loadFailBuilder,
    super.controller,
    super.autoPlay,
    super.autoLoop,
    super.width,
    super.height,
    super.backgroundBuilder,
    super.coverBuilder,
    super.pausedBuilder,
    super.onPlayOrPaused,
    super.onCompleted,
    super.controlsThemeNormal,
    super.controlsThemeFullscreen,
  });
}

// 内部不是MaterialVideoControls,不是所有的都支持

typedef GenericPlayerBuilder = Widget Function(
    BuildContext context, GenericPlayerModel model);

// normal情况下，不是MaterialVideoControls
// 自定义
class GeneriVideoControlsNormalThemeData
    extends MaterialVideoControlsThemeData {
  GeneriVideoControlsNormalThemeData({
    required Widget pause,
    //SEEK BAR
    super.displaySeekBar,
    super.seekBarAlignment,
    super.seekBarBufferColor,
    super.seekBarColor,
    super.seekBarContainerHeight,
    super.seekBarHeight,
    super.seekBarMargin,
    super.seekBarPositionColor = COLOR.playerThemeColor,
    super.seekBarThumbColor = COLOR.playerThemeColor,
    super.seekBarThumbSize,
    super.buttonBarHeight, // 对 TOP 和 BOTTOM 同时生效
    // TOP
    super.topButtonBar,
    super.topButtonBarMargin,
    // BOTTOM
    super.bottomButtonBar,
    super.bottomButtonBarMargin,
    // BUFFERING
    super.bufferingIndicatorBuilder,
    super.visibleOnMount,
  }) : super(primaryButtonBar: [GenericPlayOrPauseButton(pause: pause)]);
}

List<Widget> defaultFullscreenPrimaryButtonBar(Widget pause, Widget play) => [
      const Spacer(flex: 2),
      const MaterialSkipPreviousButton(),
      const Spacer(),
      GenericPlayOrPauseButton(
        pause: pause,
        play: play,
      ),
      const Spacer(),
      const MaterialSkipNextButton(),
      const Spacer(flex: 2),
    ];

class GenericPlayerOption {
  final GenericPlayerController? controller;
  final bool autoPlay;
  final bool autoLoop;
  final double? width;
  final double? height;
  final double? initVolume; // 初始音量 [0,100]
  final GenericPlayerBuilder? backgroundBuilder; //背景
  final GenericPlayerBuilder? coverBuilder; // 封面图
  final GenericPlayerBuilder? pausedBuilder; // 暂停
  final ValueCallback<bool>? onPlayOrPaused; // 播放、暂停
  final ValueCallback<bool>? onCompleted; // 播放完时
  final ValueCallback<double>? onVolume; // 音量
  final ValueCallback<Duration>? onPosition; //播放进度
  final ValueCallback<Duration>? onDuration; // 总时长
  final ValueCallback<bool>? onFullscreenChange;

  GeneriVideoControlsNormalThemeData? controlsThemeNormal;
  MaterialVideoControlsThemeData controlsThemeFullscreen;

  GenericPlayerOption({
    this.controller,
    this.autoPlay = true,
    this.autoLoop = true,
    this.width,
    this.height,
    this.initVolume,
    this.backgroundBuilder,
    this.coverBuilder,
    this.pausedBuilder,
    this.onPlayOrPaused,
    this.onCompleted,
    this.onVolume,
    this.onPosition,
    this.onDuration,
    this.onFullscreenChange,
    this.controlsThemeNormal,
    MaterialVideoControlsThemeData? controlsThemeFullscreen,
  }) : controlsThemeFullscreen = controlsThemeFullscreen ??
            kDefaultMaterialVideoControlsThemeDataFullscreen.copyWith(
              seekBarThumbColor: COLOR.playerThemeColor,
              seekBarPositionColor: COLOR.playerThemeColor,
            );
}
