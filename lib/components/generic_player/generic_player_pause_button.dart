import 'dart:async';

import 'package:flutter/material.dart';
import 'package:media_kit_video/media_kit_video.dart';

import '../safe_state.dart';

class GenericPlayOrPauseButton extends StatefulWidget {
  final Widget pause;
  final Widget? play;
  const GenericPlayOrPauseButton({
    super.key,
    required this.pause,
    this.play,
  });

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends SafeState<GenericPlayOrPauseButton>
    with SingleTickerProviderStateMixin {
  VideoController controller(BuildContext context) =>
      VideoStateInheritedWidget.of(context).state.widget.controller;

  StreamSubscription<bool>? subscription;
  bool _playing = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    subscription ??=
        controller(context).player.stream.playing.listen((playing) {
      setState(() {
        _playing = playing;
      });
    });
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_playing) return widget.play ?? const SizedBox();
    return widget.pause;
  }
}
