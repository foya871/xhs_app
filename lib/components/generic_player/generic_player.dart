import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

import '../../utils/color.dart';
import '../../utils/logger.dart';
import '../image_view.dart';
import '../safe_state.dart';
import 'generic_player_model.dart';
import 'generic_player_normal_controls.dart';
import 'generic_player_option.dart';

class GenericPlayerController {
  Player? _player;
  VideoState? _videoState;

  Future<void>? play() => _player?.play();
  Future<void>? pause() => _player?.pause();
  Future<void>? playOrPause() => _player?.playOrPause();
  Future<void>? setVolume(double v) => _player?.setVolume(v);
  Future<bool?>? toggleFullscreen() async {
    if (_videoState == null) return null;
    if (!_videoState!.mounted) return null;
    await _videoState!.toggleFullscreen();
    return _videoState!.isFullscreen();
  }

  Duration? get playbackDuration => _player?.state.duration;
}

class GenericPlayer extends StatefulWidget {
  final GenericPlayerModel model;
  final GenericPlayerOption? option;
  const GenericPlayer(this.model, {super.key, this.option});

  @override
  State<GenericPlayer> createState() => _GenericPlayerState();
}

class _GenericPlayerState extends SafeState<GenericPlayer> {
  late final Player _player;
  late final VideoController _videoController;
  late final GenericPlayerController _controller;
  StreamSubscription<bool>? _playingSubs;
  StreamSubscription<bool>? _completedSubs;
  StreamSubscription<double>? _volumeSubs;
  StreamSubscription<Duration>? _postionSubs;
  StreamSubscription<Duration>? _durationSubs;
  StreamSubscription<Duration>? _bufferSubs;

  GenericPlayerModel get model => widget.model;
  GenericPlayerOption? get option => widget.option;
  var _firstSeeked = false;

  @override
  void initState() {
    _player = Player(configuration: PlayerConfiguration(ready: _onPlayerReady));
    logger.d(">>>>GenericPlayer<<< init ${model.playUrl}");
    _player.open(Media(model.playUrl), play: false);
    _controller = option?.controller ?? GenericPlayerController();
    _controller._player = _player;
    _videoController = VideoController(
      _player,
      configuration: VideoControllerConfiguration(
        enableHardwareAcceleration: !GetPlatform.isAndroid,
      ),
    );
    _playingSubs = _player.stream.playing.listen(_listenPlaying);
    _completedSubs = _player.stream.completed.listen(_listenCompleted);
    _volumeSubs = _player.stream.volume.listen(_listenVolume);
    _postionSubs = _player.stream.position.listen(_listenPosition);
    _durationSubs = _player.stream.duration.listen(_listenDuration);
    _bufferSubs = _player.stream.duration.listen(_listenBuffer);

    super.initState();
  }

  @override
  void dispose() {
    _controller._player = null;
    _controller._videoState = null;
    _playingSubs?.cancel();
    _completedSubs?.cancel();
    _volumeSubs?.cancel();
    _postionSubs?.cancel();
    _durationSubs?.cancel();
    _bufferSubs?.cancel();
    _player.dispose();
    super.dispose();
  }

  void _onPlayerReady() {
    _player.setVolume(option?.initVolume ?? 100);
    // if (option?.autoLoop == true) {
    //   _player.setPlaylistMode(PlaylistMode.single); // single 不能正常回调completed
    // }
  }

  void _listenPlaying(bool playing) => option?.onPlayOrPaused?.call(playing);
  void _listenCompleted(bool completed) {
    if (option?.autoLoop == true && completed) {
      _player.play();
    }
    option?.onCompleted?.call(completed);
  }

  void _listenVolume(double volume) => option?.onVolume?.call(volume);
  void _listenPosition(Duration position) {
    option?.onPosition?.call(position);
  }

  void _listenDuration(Duration duration) => option?.onDuration?.call(duration);

  void _listenBuffer(Duration duration) async {
    if (!_firstSeeked && duration.inMilliseconds > 100) {
      await _player.seek(Duration.zero);
      _firstSeeked = true;
      if (widget.option?.autoPlay == true) {
        _player.play();
      }
    }
  }

  Widget _buildBackground(BuildContext context) =>
      option?.backgroundBuilder?.call(context, model) ??
      SizedBox.expand(
        child: Container(color: COLOR.black),
      );

  Widget _buildCover(BuildContext context) =>
      option?.coverBuilder?.call(context, model) ??
      Center(
        child: ImageView(
          src: model.coverImg,
          width: option?.width,
          height: option?.height,
        ),
      );

  Widget _buildVideo(BuildContext context) {
    // double? asp;
    // if (model.width != null &&
    //     model.height != null &&
    //     model.width != 0 &&
    //     model.height != 0) {
    //   asp = model.width! / model.height!;
    // }
    // if (asp == null) {
    //   if (option?.width != null &&
    //       option?.height != null &&
    //       option?.width != 0 &&
    //       option?.height != 0) {
    //     asp = option!.width! / option!.height!;
    //   }
    // }

    final normalTheme =
        option?.controlsThemeNormal ?? kDefaultMaterialVideoControlsThemeData;
    final fullscreenTheme = option?.controlsThemeFullscreen ??
        kDefaultMaterialVideoControlsThemeDataFullscreen;

    return MaterialVideoControlsTheme(
      normal: normalTheme,
      fullscreen: fullscreenTheme,
      child: Video(
        fill: Colors.transparent,
        width: option?.width,
        height: option?.height,
        controls: (state) {
          _controller._videoState = state;
          if (state.isFullscreen()) {
            return MaterialVideoControls(state);
          } else {
            return GenericPlayerNormalControls(state);
          }
        },
        controller: _videoController,
        // aspectRatio: asp ?? (16.0 / 9.0),
        fit: BoxFit.fitWidth,
      ),
    );
  }

  Widget _buildBody(BuildContext context) => Stack(
        children: [
          _buildBackground(context),
          Positioned.fill(child: _buildCover(context)),
          Positioned.fill(child: _buildVideo(context)),
        ],
      );
  @override
  Widget build(BuildContext context) => SizedBox(
        width: option?.width,
        height: option?.height,
        child: _buildBody(context),
      );
}
