import 'package:flutter/material.dart';
import 'package:media_kit_video/media_kit_video.dart';

import '../../utils/extension.dart';
import '../safe_state.dart';

class GenericPlayerNormalControls extends StatefulWidget {
  final VideoState state;
  const GenericPlayerNormalControls(this.state, {super.key});

  @override
  State<GenericPlayerNormalControls> createState() => _State();
}

class _State extends SafeState<GenericPlayerNormalControls> {
  MaterialVideoControlsThemeData _theme(BuildContext context) =>
      FullscreenInheritedWidget.maybeOf(context) == null
          ? MaterialVideoControlsTheme.maybeOf(context)?.normal ??
              kDefaultMaterialVideoControlsThemeData
          : MaterialVideoControlsTheme.maybeOf(context)?.fullscreen ??
              kDefaultMaterialVideoControlsThemeDataFullscreen;

  VideoController get controller => widget.state.widget.controller;

  late bool buffering = controller.player.state.buffering;

  @override
  void initState() {
    controller.player.stream.buffering.listen((b) {
      setState(() {
        buffering = b;
      });
    });
    super.initState();
  }

  Widget _buildBuffering(BuildContext context) => IgnorePointer(
        child: Padding(
          padding: _theme(context).padding ??
              (
                  // Add padding in fullscreen!
                  isFullscreen(context)
                      ? MediaQuery.of(context).padding
                      : EdgeInsets.zero),
          child: Column(
            children: [
              Container(
                height: _theme(context).buttonBarHeight,
                margin: _theme(context).topButtonBarMargin,
              ),
              Expanded(
                child: Center(
                  child: TweenAnimationBuilder<double>(
                    tween: Tween<double>(
                      begin: 0.0,
                      end: buffering ? 1.0 : 0.0,
                    ),
                    duration: _theme(context).controlsTransitionDuration,
                    builder: (context, value, child) {
                      // Only mount the buffering indicator if the opacity is greater than 0.0.
                      // This has been done to prevent redundant resource usage in [CircularProgressIndicator].
                      if (value > 0.0) {
                        return Opacity(
                          opacity: value,
                          child: _theme(context)
                                  .bufferingIndicatorBuilder
                                  ?.call(context) ??
                              child!,
                        );
                      }
                      return const SizedBox.shrink();
                    },
                    child: const CircularProgressIndicator(
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                ),
              ),
              Container(
                height: _theme(context).buttonBarHeight,
                margin: _theme(context).bottomButtonBarMargin,
              ),
            ],
          ),
        ),
      );

  Widget _buildBtnLayer() => Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            height: _theme(context).buttonBarHeight,
            margin: _theme(context).topButtonBarMargin,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: _theme(context).topButtonBar,
            ),
          ),
          Expanded(
            child: Center(
              child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: _theme(context).primaryButtonBar),
            ),
          ),
          Container(
            height: _theme(context).buttonBarHeight,
            margin: _theme(context).bottomButtonBarMargin,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // const MaterialPositionIndicator(
                //   style: TextStyle(
                //     fontSize: 14.0,
                //     color: Colors.white,
                //   ),
                // ),
                // const SizedBox(width: 10),
                ..._theme(context).bottomButtonBar
              ],
            ),
          ),
        ],
      ).onOpaqueTap(() {
        widget.state.widget.controller.player.playOrPause();
      });

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          Positioned.fill(child: _buildBtnLayer()),
          Positioned.fill(child: Center(child: _buildBuffering(context))),
        ],
      );
}
