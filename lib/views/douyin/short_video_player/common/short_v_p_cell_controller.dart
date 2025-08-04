import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import '../../../../http/api/api.dart';
import '../../../../model/play/cdn_model.dart';
import '../../../../routes/routes.dart';
import '../../../../services/user_service.dart';
import '../../../../utils/busy_future.dart';
import '../../../../utils/enum.dart';
import '../../../../utils/logger.dart';
import '../controllers/short_video_player_page_controller.dart';
import 'short_video_model.dart';

enum VPInitState { none, success, error }

class ShortVPCellController extends GetxController with BusyFuture, StateMixin {
  ShortVideoPlayerMode? mode;

  ///默认是本地模式
  ShortVPCellController({this.mode = ShortVideoPlayerMode.local});

  late final ShortVideoModel _video;
  final _videoInited = Completer<bool>(); // _video 是否初始化

  VideoController? playerVC;
  Player? player;

  final playerInitialized = VPInitState.none.obs;
  final showPermission = false.obs; // 是否显示购买弹窗
  final videoPaused = false.obs; // 是否显示暂停按钮
  final clearMode = false.obs; // 清屏模式
  final webVolume = 0.0.obs;
  StreamSubscription<bool>? _playingSubs;
  StreamSubscription<bool>? _completeSubs;

  // 购买之后，刷新
  void _resetAll() {
    _disposePlayer();
    playerInitialized.value = VPInitState.none;
    showPermission.value = false;
    clearMode.value = false; // 这个好像不用
  }

  void init(ShortVideoModel video) {
    logger.d('init video index:${video.index}, ${video.base.title}');
    if (!_videoInited.isCompleted) {
      _video = video;
      _videoInited.complete(true);
      initPlayer();
    }
  }

  ShortVideoModel get video => _video;

  //播放或者暂停
  void togglePlayOrPause() {
    if (player == null || playerVC == null) return;
    if (playerInitialized.value != VPInitState.success) return;
    busyCall('playOrPause', () async {
      final isPlaying = player!.state.playing;
      if (isPlaying) {
        await player!.pause();
      } else {
        await player!.play();
      }
    });
  }

  void _pause() async {
    if (player == null || playerVC == null) return;
    if (playerInitialized.value != VPInitState.success) return;
    final isPlaying = player!.state.playing;
    if (isPlaying) {
      await player!.pause();
    }
  }

  void _play() async {
    if (player == null || playerVC == null) return;
    if (playerInitialized.value != VPInitState.success) return;
    final isPlaying = player!.state.playing;
    if (!isPlaying) {
      await player!.play();
    }
  }

  String get mainRootControllerTag => mode!.index.toString();

  bool get pageVisible =>
      Get.find<ShortVideoPlayerPageController>(tag: mainRootControllerTag)
          .pageVisible;

  bool get webUnmuteTouched =>
      Get.find<ShortVideoPlayerPageController>(tag: mainRootControllerTag)
          .webUnmuteTouched
          .value;

  int get pageIndex =>
      Get.find<ShortVideoPlayerPageController>(tag: mainRootControllerTag)
          .currentIndex;

  void onPageVisibleChange(bool pageVisible) {
    logger.d('onPageVisibleChange.... ${video.index} visible:$pageVisible');
    if (pageVisible) {
      //可见状态就直接播放
      _play();
    } else {
      // 变为不可见, 直接暂停
      _pause();
      uploadWatchRC();
    }
  }

  void onPageIndexChange(int pageIndex) {
    if (pageIndex != video.index) {
      uploadWatchRC();
      return;
    }

    _play();
  }

  void onTapPermissionCancel() {
    final isPay = video.detail!.reasonType == VideoReasonTypeValueEnum.NeedPay;
    if (isPay) {
      ///上传视频
      assert(false, "??");
    } else {
      ///邀请好友
      Get.toShare();
    }
  }

  void onTapPermissionBuy() {
    if (video.detail == null) return;
    final isPay = video.detail!.reasonType == VideoReasonTypeValueEnum.NeedPay;
    if (isPay) {
      _buyAction();
    } else {
      Get.toVip();
    }
  }

  void onTapBuyDesc() => showPermission.value = true;

  void onTapSelectCdnConfirm(CdnRsp cdnRsp) {
    if (video.detail == null) return;
    if (cdnRsp.id == video.detail!.cdnRes?.id) return;
    video.base.cdnRes = cdnRsp;
    video.detail!.cdnRes = cdnRsp;
    initPlayer();
  }

  void onTapClearMode() => clearMode.value = !clearMode.value;

  bool onTapUnmute() {
    if (player == null || playerVC == null) return false;
    if (playerInitialized.value != VPInitState.success) return false;
    final volume = player!.state.volume;
    if (volume != 100) {
      player!.setVolume(100.0);
    }
    Get.find<ShortVideoPlayerPageController>(tag: mainRootControllerTag)
        .webUnmuteTouched
        .value = true;

    return true;
  }

  // 购买
  Future _buyAction() async {
    if (video.detail == null) return;
    final detail = video.detail!;
    final ok = Get.find<UserService>().checkGold(detail.price!);
    if (!ok) {
      SmartDialog.showToast('余额不足!', alignment: Alignment.center);
      return;
    }
    busyCall('buyAction', () async {
      SmartDialog.showLoading(msg: "购买中...");
      final r = await Api.buyVideoAction(videoId: detail.videoId!);
      SmartDialog.dismiss();
      if (r == true) {
        SmartDialog.showToast("购买成功!", alignment: Alignment.center);
        video.fetchDetail(forceRetry: true);
        waitLoadingDetail();
        initPlayer();
        Get.find<UserService>().updateAPIAssetsInfo();
      }
    });
  }

  Future<void> toggleMute() async {
    final volume = webVolume.value;
    if (volume != 100) {
      await player?.setVolume(100);
      webVolume.value = 100;
    } else {
      await player?.setVolume(0);
      webVolume.value = 0;
    }
  }

  Future<void> initPlayer() async {
    final detail = await _video.fetchDetail();
    if (isClosed) return;
    if (detail == null) return;
    _resetAll();
    final videoURL = detail.authPlayUrl.toString();
    logger.d('播放地址>>>>>$videoURL');
    // change(null, status: RxStatus.loading());
    playerInitialized.value = VPInitState.none;
    final config = PlayerConfiguration(
      muted: kIsWeb, //web下静音可以实现自动播放
      title: '',
      osc: true,
      ready: () async {
        if (playerInitialized.value == VPInitState.none) {
          playerInitialized.value = VPInitState.success;
          // 页面可见，并且主页面的index是这个才播放
          // 上下拖动很慢的情况，会出现下面播放器初始化完成，index还没改变的情况，这里暂停
          if (kIsWeb) {
            await player!.setVolume(0.0);
          }
          if (pageVisible && pageIndex == video.index) {
            player?.play();
          }
        }
      },
    );
    player = Player(configuration: config);
    playerVC = VideoController(
      player!,
      configuration: VideoControllerConfiguration(
        enableHardwareAcceleration: !GetPlatform.isAndroid,
      ),
    );
    player!.open(Media(videoURL), play: false);

    //播放或者暂停
    _playingSubs = player!.stream.playing.listen((e) {
      final playable = playerInitialized.value == VPInitState.success;
      if (e) {
        videoPaused.value = false;
        if (pageVisible && pageIndex != video.index) {
          player?.pause();
        }
      } else {
        ///初始化完成
        if (playable) {
          videoPaused.value = true;
        } else {
          videoPaused.value = false;
        }
      }
    });

    //播放结束了
    _completeSubs = player!.stream.completed.listen((e) {
      if (e) {
        player!.seek(const Duration(seconds: 0)).then((_) {
          player!.play();
        });
        if (showPermission.value || video.detail == null) return;
        showPermission.value = video.detail!.canWatch == false;
      }
    });
  }

  void _disposePlayer() {
    uploadWatchRC();
    _playingSubs?.cancel();
    _completeSubs?.cancel();
    player?.dispose();
    player = null;
  }

  ///上报观影记录
  void uploadWatchRC() {
    if (playerInitialized.value != VPInitState.success) return;
    if (video.detail?.canWatch == false) return;
    final currentSeconds = player?.state.position.inSeconds ?? 0;
    if (currentSeconds < 1) return;
    //上报
    logger.d('upload watchRc called!');
    Api.uploadWatchRc(
        duration: player?.state.duration.inSeconds ?? 0,
        lookType: _lookType(),
        videoId: video.detail?.videoId ?? 0,
        progress: currentSeconds);
  }

  int _lookType() {
    /////视频类型：0-普通视频 1-VIP视频 2-付费视频
    int n = video.detail?.videoType ?? 0;
    switch (n) {
      case 0:
        return 1;
      case 1:
        return 2;
      case 2:
        return 3;
      default:
        return 0;
    }
  }

  void waitLoadingDetail({bool forceRetry = false}) async {
    change(null, status: RxStatus.loading());
    await _videoInited.future;
    await _video.fetchDetail(forceRetry: forceRetry);
    if (isClosed) return;
    if (_video.detail == null) {
      change(null, status: RxStatus.error());
    } else {
      change(null, status: RxStatus.success());
    }
  }

  @override
  void onInit() {
    logger.d('Short cell set onInit ...');
    waitLoadingDetail();
    super.onInit();
  }

  @override
  void onClose() {
    logger
        .d('short player dispose index:${_video.index}, ${_video.base.title}');
    _disposePlayer();
    super.onClose();
  }
}
