/*
 * @Author: wangdazhuang
 * @Date: 2025-01-13 14:52:40
 * @LastEditTime: 2025-03-12 09:16:52
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /xhs_app/lib/views/douyin/short_video_player/common/media_kit_short_controls.dart
 */

import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:media_kit_video/media_kit_video_controls/src/controls/methods/video_state.dart';
import 'package:media_kit_video/media_kit_video_controls/src/controls/widgets/video_controls_theme_data_injector.dart';
import 'package:xhs_app/assets/styles.dart';
import 'package:xhs_app/utils/color.dart';

import '../../../player/views/av_player_loading.dart';

// ignore: must_be_immutable
class MediaKitShortControls extends StatefulWidget {
  final BuildContext buildContext;
  Size? viewSize;
  Rect? texturePos;
  BuildContext? pageContent;
  String? playerTitle;
  final bool showDuration;
  final double? seekBarHeight;
  final EdgeInsets? seekBarPadding;
  final double? bottomHeight;

  MediaKitShortControls({
    super.key,
    required this.buildContext,
    this.viewSize,
    this.texturePos,
    this.pageContent,
    this.playerTitle,
    this.showDuration = true,
    this.seekBarHeight,
    this.seekBarPadding,
    this.bottomHeight,
  });

  @override
  // ignore: library_private_types_in_public_api
  _MediaKitShortControlsState createState() => _MediaKitShortControlsState();
}

class _MediaKitShortControlsState extends State<MediaKitShortControls> {
  // Player get player => controller(context).player;
  Duration _durationPos = const Duration(seconds: 0);
  Duration _currentPos = const Duration(seconds: 0);
  Duration _bufferPos = const Duration(seconds: 0);

  bool _playing = false;

  double startPosX = 0;
  double startPosY = 0;
  Size playerBoxSize = Size.zero;

  StreamSubscription<Duration>? _currentPosSubs;

  StreamSubscription? _bufferPosSubs;

  StreamSubscription? _bufferingStateSubs;
  StreamSubscription<bool>? _playingSubs;

  bool _isBuffering = false;

  final barHeight = 55.0;
  final barContainerHeight = 35.0;

  final centerSeekBarHeight = 5.0;

  final centerBtnSize = 45.0;
  final thumbSize = 18.0;

  bool tapped = false;
  double slider = 0.0;

  ///简单的时间转换方法
  String _duration2String(Duration duration) {
    if (duration.inMilliseconds < 0) {
      return "-: negtive value and ilegal value!";
    }
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    int inHours = duration.inHours;
    return inHours > 0
        ? "$inHours:$twoDigitMinutes:$twoDigitSeconds"
        : "$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  void didChangeDependencies() {
    _addSubscriptionListeners();
    super.didChangeDependencies();
  }

  ///监听器
  void _addSubscriptionListeners() {
    Player player = controller(context).player;
    // ///当前进度
    _currentPosSubs = player.stream.position.listen((v) {
      if (mounted) {
        setState(() {
          _currentPos = v;
        });
      }
    });

    ///是否正在缓冲
    _bufferingStateSubs = player.stream.buffering.listen((v) {
      if (mounted) {
        setState(() {
          _isBuffering = v;
        });
      }
    });
  }

  @override
  void dispose() {
    _currentPosSubs?.cancel();
    _bufferPosSubs?.cancel();
    _bufferingStateSubs?.cancel();
    _playingSubs?.cancel();

    super.dispose();
  }

  void _togglePlayPause() {
    final player = controller(context).player;
    if (player.state.playing) {
      player.pause();
    } else {
      player.play();
    }
    return;
  }

  // 底部左下按钮
  Widget _buildPlayStateBtn() {
    return const Padding(
      padding: EdgeInsets.only(left: 5),
      child: MaterialPlayOrPauseButton(
        iconColor: Colors.white,
        iconSize: 22,
      ),
    );
  }

  ///当前位置
  Widget _buildCurrentTime() {
    // return Padding(
    //   padding: const EdgeInsets.only(right: 5.0, left: 5),
    //   child: Text(
    //     _duration2String(_currentPos),
    //     style: const TextStyle(
    //       fontSize: 14.0,
    //       color: Colors.white,
    //     ),
    //   ),
    // );
    return const MaterialPositionIndicator(
      style: TextStyle(
        fontSize: 14.0,
        color: Colors.white,
      ),
    );
  }

  ///进度条
  Widget _buildSliderBar(BuildContext context) {
    final bottomH = isFullscreen(context)
        ? kIsWeb && Get.width < Get.height
            ? 25.0
            : 15.0
        : 27.0;
    return Expanded(
      child: Padding(
        padding: widget.seekBarPadding ??
            EdgeInsets.only(right: 5, left: 5, bottom: bottomH),
        child: const MaterialSeekBar(),
      ),
    );
  }

  ///全屏按钮
  // _buildFullScreenBtn() {
  //   return IconButton(
  //     icon: const Icon(Icons.fullscreen),
  //     padding: const EdgeInsets.only(left: 5.0, right: 10.0),
  //     color: Colors.white,
  //     splashColor: Colors.transparent,
  //     highlightColor: Colors.transparent,
  //     onPressed: () {
  //       // final context = Get.context!;
  //       // if (isFullscreen(context)) {
  //       //   exitFullscreen(context);
  //       // } else {
  //       //   enterFullscreen(context);
  //       // }
  //     },
  //   );
  // }

  // 底部
  AnimatedOpacity _buildBottomBar(BuildContext context) {
    final isInner = !isFullscreen(context);
    final bottomH = isInner ? 0.0 : MediaQuery.of(context).padding.bottom;
    return AnimatedOpacity(
      opacity: 1.0,
      duration: const Duration(milliseconds: 400),
      child: Container(
        height: widget.seekBarHeight ?? barHeight,
        padding: EdgeInsets.only(bottom: bottomH),
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            colors: [
              Color.fromRGBO(0, 0, 0, 0),
              Color.fromRGBO(0, 0, 0, 0.7),
            ],
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // 按钮 - 播放/暂停
            // _buildPlayStateBtn(),
            const SizedBox(width: 5),
            // 已播放时间
            if (widget.showDuration) _buildCurrentTime(),
            // 播放进度
            _buildSliderBar(context),
            // 总播放时间
            // _buildDuration(),
            const SizedBox(width: 5),
            // 按钮 - 全屏/退出全屏
            // _buildFullScreenBtn(),
            // const MaterialFullscreenButton()
          ],
        ),
      ),
    );
  }

  // 播放器顶部 返回 + 标题
  AnimatedOpacity _buildTopBar(BuildContext context) {
    final isFull = isFullscreen(context);
    final fullButtonTop = MediaQuery.of(widget.buildContext).padding.top + 15;
    final opac = isFull ? 1.0 : 0.0;
    return AnimatedOpacity(
      opacity: opac,
      duration: const Duration(milliseconds: 400),
      child: Container(
        margin: const EdgeInsets.only(
            // top: isFull
            //     ? fullButtonTop
            //     : MediaQuery.of(widget.buildContext).padding.top),
            top: 15),
        height: 44.0,
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 25,
                color: COLOR.white,
              ),
              color: Colors.white,
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: () {
                if (isFullscreen(context)) {
                  exitFullscreen(context);
                } else {
                  Get.back();
                }
              },
            ),
            Text(
              widget.playerTitle ?? '',
              textAlign: TextAlign.left,
              style: kTextStyle(
                Colors.white,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }

// 暂停 + 播放
  _buildPlayPauseBtn() {
    return MaterialPlayOrPauseButton(
        iconSize: centerBtnSize, iconColor: Colors.white);
  }

  ///快退快进
  _forwardOrBackAction(bool back, BuildContext _) async {
    final player = controller(_).player;
    var current = _currentPos.inSeconds;
    if (back) {
      ///快退
      current = current - 10;
      if (current < 0) current = 0;
      await player.seek(Duration(seconds: current));
    } else {
      ///快进
      current = current + 10;
      if (current > _durationPos.inSeconds && _durationPos != Duration.zero) {
        current = _durationPos.inSeconds;
      }
      await player.seek(Duration(seconds: current));
    }
  }

//快退
  _buildBack10Btn(BuildContext _) {
    // return EasyButton.child(
    // Icon(
    //   Icons.replay_10_outlined,
    //   color: Colors.white,
    //   size: centerBtnSize,
    // ),
    //     width: centerBtnSize,
    //     height: centerBtnSize,
    //     onTap: () => _forwardOrBackAction(true));
    return MaterialCustomButton(
      onPressed: () => _forwardOrBackAction(true, _),
      icon: Icon(
        Icons.replay_10_outlined,
        color: Colors.white,
        size: centerBtnSize,
      ),
      iconSize: centerBtnSize,
    );
  }

  ///快进
  _buildForward10Btn(BuildContext _) {
    return MaterialCustomButton(
      onPressed: () => _forwardOrBackAction(false, _),
      icon: Icon(
        Icons.forward_10_outlined,
        color: Colors.white,
        size: centerBtnSize,
      ),
      iconSize: centerBtnSize,
    );
  }

  // 居中按钮
  Widget _buildCenterBtns(BuildContext _) {
    return Container(
      color: Colors.transparent,
      height: double.infinity,
      width: double.infinity,
      child: Center(
        child: _currentPos.inMilliseconds > 0
            ? AnimatedOpacity(
                opacity: 0.7,
                duration: const Duration(milliseconds: 400),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildBack10Btn(_),
                    const SizedBox(width: 20),
                    _buildPlayPauseBtn(),
                    const SizedBox(width: 20),
                    _buildForward10Btn(_),
                  ],
                ),
              )
            : const AvPlayerLoading(),
      ),
    );
  }

  ///中间
  _buildCenterBox(BuildContext context) {
    // 中间按钮
    return Expanded(
      child: GestureDetector(
        onTap: () {
          _togglePlayPause();
        },
        child: SizedBox(
          child: Stack(
            children: <Widget>[
              // 中间按钮
              Visibility(
                visible: !_isBuffering,
                child: Align(
                  alignment: Alignment.center,
                  child: _buildCenterBtns(context),
                ),
              ),
              Visibility(
                visible: _isBuffering,
                child: const Align(
                  alignment: Alignment.center,
                  child: AvPlayerLoading(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Rect rect = isFullscreen(context)
        ? Rect.fromLTWH(
            0,
            0,
            Get.width,
            Get.height,
          )
        : Rect.fromLTRB(
            max(0.0, widget.texturePos?.left ?? 0),
            max(0.0, widget.texturePos?.top ?? 0),
            min(widget.viewSize?.width ?? 0, widget.texturePos?.right ?? 0),
            min(widget.viewSize?.height ?? 0, widget.texturePos?.bottom ?? 0),
          );

    double? bottomHeight = widget.bottomHeight;
    if (bottomHeight == null) {
      if (isFullscreen(context) ||
          (widget.viewSize?.height ?? 0) < Get.height) {
        bottomHeight = null;
      } else {
        bottomHeight = ScreenUtil().bottomBarHeight + 15;
      }
    }

    return VideoControlsThemeDataInjector(
      child: SizedBox.fromSize(
        size: Size(rect.width, rect.height),
        child: GestureDetector(
          onTap: _togglePlayPause,
          child: AbsorbPointer(
            absorbing: false,
            child: Stack(
              children: [
                Column(
                  children: <Widget>[
                    // 播放器顶部控制器
                    _buildTopBar(context),
                    //中间
                    _buildCenterBox(context),
                    // 播放器底部控制器
                    _buildBottomBar(context),
                    //底部间隙
                    if (bottomHeight != null) SizedBox(height: bottomHeight),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
