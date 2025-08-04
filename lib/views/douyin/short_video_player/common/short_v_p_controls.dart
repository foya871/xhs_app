/*
 * @Author: wangdazhuang
 * @Date: 2024-09-30 16:06:33
 * @LastEditTime: 2025-01-17 13:52:09
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /xhs_app/lib/views/douyin/short_video_player/common/short_v_p_controls.dart
 */
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:xhs_app/utils/extension.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../../../utils/color.dart';
import '../../../player/chewie/chewie.dart';
import '../../../player/chewie/src/helpers/utils.dart';
import '../../../player/chewie/src/notifiers/index.dart';

class SpControls extends StatefulWidget {
  final VoidCallback? tap;
  const SpControls({super.key, this.tap});
  @override
  State<StatefulWidget> createState() {
    return _SpControlsState();
  }
}

class _SpControlsState extends State<SpControls>
    with SingleTickerProviderStateMixin {
  late PlayerNotifier notifier;
  late VideoPlayerValue _latestValue;
  Timer? _initTimer;
  // ignore: unused_field
  bool _dragging = false;
  Timer? _bufferingDisplayTimer;
  bool _displayBufferingIndicator = false;

  final barHeight = 48.0 * 1.5;
  final marginSize = 5.0;

  late VideoPlayerController controller;
  ChewieController? _chewieController;

  // We know that _chewieController is set in didChangeDependencies
  ChewieController get chewieController => _chewieController!;

  @override
  void initState() {
    super.initState();
    notifier = Provider.of<PlayerNotifier>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    if (_latestValue.hasError) {
      return chewieController.errorBuilder?.call(
            context,
            chewieController.videoPlayerController.value.errorDescription!,
          ) ??
          const Center(
            child: Icon(
              Icons.error,
              color: Colors.white,
              size: 42,
            ),
          );
    }

    return Stack(
      children: [
        if (_displayBufferingIndicator)
          _chewieController?.bufferingBuilder?.call(context) ??
              const Center(child: CircularProgressIndicator()),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            _buildBottomBar(context),
          ],
        ),
      ],
    ).onOpaqueTap(() {
      if (widget.tap != null) {
        widget.tap!();
      }
    });
  }

  @override
  void dispose() {
    _dispose();
    super.dispose();
  }

  void _dispose() {
    controller.removeListener(_updateState);
    _initTimer?.cancel();
  }

  @override
  void didChangeDependencies() {
    final oldController = _chewieController;
    _chewieController = ChewieController.of(context);
    controller = chewieController.videoPlayerController;

    if (oldController != chewieController) {
      _dispose();
      _initialize();
    }

    super.didChangeDependencies();
  }

  AnimatedOpacity _buildBottomBar(
    BuildContext context,
  ) {
    // final iconColor = Theme.of(context).textTheme.labelLarge!.color;

    return AnimatedOpacity(
      opacity: 1.0,
      duration: const Duration(milliseconds: 300),
      child: Container(
        height: barHeight + (chewieController.isFullScreen ? 10.0 : 0),
        padding: EdgeInsets.only(
          left: 12,
          bottom: !chewieController.isFullScreen ? 10.0 : 0,
        ),
        child: SafeArea(
          top: false,
          bottom: chewieController.isFullScreen,
          minimum: chewieController.controlsSafeAreaMinimum,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Flexible(
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: <Widget>[
              //       _buildPosition(iconColor),
              //       const Spacer(),
              //       if (chewieController.allowFullScreen) _buildExpandButton(),
              //     ],
              //   ),
              // ),
              // SizedBox(
              //   height: chewieController.isFullScreen ? 15.0 : 0,
              // ),
              // if (!chewieController.isLive)
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildTimeTxt(_latestValue.position),
                    const SizedBox(width: 5.0),
                    _buildProgressBar(),
                    const SizedBox(width: 5.0),
                    _buildTimeTxt(_latestValue.duration),
                    const SizedBox(width: 5.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeTxt(Duration v) {
    return Text(
      formatDuration(v),
      textAlign: TextAlign.left,
      style: const TextStyle(
        fontSize: 12.0,
        color: Colors.white,
        fontWeight: FontWeight.normal,
      ),
    );
  }

  Future<void> _initialize() async {
    controller.addListener(_updateState);

    _updateState();

    if (chewieController.showControlsOnInitialize) {
      _initTimer = Timer(const Duration(milliseconds: 200), () {
        if (!mounted) {
          return;
        }
        setState(() {
          notifier.hideStuff = false;
        });
      });
    }
  }

  void _bufferingTimerTimeout() {
    _displayBufferingIndicator = true;
    if (mounted) {
      setState(() {});
    }
  }

  void _updateState() {
    if (!mounted) return;
    if (chewieController.progressIndicatorDelay != null) {
      if (controller.value.isBuffering) {
        _bufferingDisplayTimer ??= Timer(
          chewieController.progressIndicatorDelay!,
          _bufferingTimerTimeout,
        );
      } else {
        _bufferingDisplayTimer?.cancel();
        _bufferingDisplayTimer = null;
        _displayBufferingIndicator = false;
      }
    } else {
      _displayBufferingIndicator = controller.value.isBuffering;
    }

    if (!mounted) {
      return;
    }
    setState(() {
      _latestValue = controller.value;
    });
  }

  Widget _buildProgressBar() {
    return Expanded(
      child: MaterialVideoProgressBar(
        handleHeight: 8,
        barHeight: 3,
        controller,
        onDragStart: () {
          if (!mounted) {
            return;
          }
          setState(() {
            _dragging = true;
          });
        },
        onDragUpdate: () {},
        onDragEnd: () {
          if (!mounted) {
            return;
          }
          setState(() {
            _dragging = false;
          });
        },
        colors: chewieController.materialProgressColors ??
            ChewieProgressColors(
              playedColor: COLOR.hexColor("#F40302"),
              handleColor: COLOR.hexColor("#F40302"),
              bufferedColor:
                  Theme.of(context).colorScheme.surface.withOpacity(0.5),
              backgroundColor: const Color.fromRGBO(255, 255, 255, 1.0),
            ),
        draggableProgressBar: chewieController.draggableProgressBar,
      ),
    );
  }
}
