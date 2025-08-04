/*
 * @Author: wangdazhuang
 * @Date: 2024-08-19 11:56:27
 * @LastEditors: wdz
 * @Description: 
 * @FilePath: /xhs_app/lib/views/player/controllers/video_play_controller.dart
 */

import 'dart:async';
import 'dart:math';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:xhs_app/components/ad/ad_enum.dart';
import 'package:xhs_app/components/ad/ad_info_model.dart';
import 'package:xhs_app/components/ad/ad_utils.dart';
import 'package:xhs_app/components/common_permission_alert.dart';
import 'package:xhs_app/components/easy_toast.dart';
import 'package:xhs_app/http/api/api.dart';
import 'package:xhs_app/model/advertisements/ad_resp_model.dart';
import 'package:xhs_app/model/play/video_detail_model.dart';
import 'package:xhs_app/services/user_service.dart';
import 'package:xhs_app/utils/enum.dart';
import 'package:xhs_app/utils/initAdvertisementInfo.dart';
import 'package:xhs_app/utils/logger.dart';
import 'package:get/get.dart';
import '../../../components/diolog/loading/loading_view.dart';
import '../../../model/video_base_model.dart';
import '../../../routes/routes.dart';

class VideoPlayController extends GetxController with StateMixin {
  static const aspRatio = 360 / 220.0;
  static double get videoH => Get.width / aspRatio;
  final _us = Get.find<UserService>();

  bool _requesting = false;
  RxBool playerInitialized = false.obs;
  Rx<VideoDetail> currentVideo = VideoDetail.fromJson({}).obs;
  RxList<VideoBaseModel> guessLikeItems = <VideoBaseModel>[].obs;
  RxBool showPermission = false.obs;

  VideoController? playerVC;
  Player? player;

  StreamSubscription<Duration>? _currentPosSubs;
  StreamSubscription<bool>? _completePosSubs;
  StreamSubscription<Duration>? _durationSubs;
  StreamSubscription<bool>? _playingSubs;
  RxBool videoEmpty = true.obs;

  Rx<AdInfoModel> ad = AdInfoModel.fromJson({}).obs;

  ///暂停广告
  Rx<AdInfoModel> stopAd = AdInfoModel.fromJson({}).obs;
  RxBool showStopAd = false.obs;
  late Worker videoWorker;

  ///全屏倒计时广告
  int fullAdTimerCount = 0;
  bool showFullAd = false;
  Timer? fullAdTimer;
  var fullAd = adHelper.getAdInfo(AdApiTypeCompat.PLAY_WIDGET);
  bool showTimerAd = false;

  ///暂停广告
  void resetStopAd() {
    final items = adHelper.getAdLoadInOrder(AdApiTypeCompat.VIDEO_PAUSED);
    if (items.isNotEmpty) {
      final randomIndex = Random().nextInt(items.length);
      stopAd.value = items[randomIndex];
    }
  }

  ///重置全屏广告
  void resetlFullAd() {
    fullAdTimer?.cancel();
    showFullAd = false;
    fullAd = adHelper.getAdInfo(AdApiTypeCompat.PLAY_WIDGET);
    if (fullAd != null) {
      fullAdTimerCount = fullAd!.minStaySecond ?? 15;
      showFullAd = true;
    }
  }

  @override
  void onInit() {
    _us.updateAPIAssetsInfo();
    final id = int.tryParse(Get.parameters['id'] ?? '') ?? 0;
    fetchVideoDetailById(id);

    ///监听
    videoWorker = ever(currentVideo, (value) {
      final isEmpty = value == VideoDetail.fromJson({});
      if (isEmpty) {
        change(null, status: RxStatus.loading());
      } else {
        videoEmpty.value = false;
        change(null, status: RxStatus.success());
      }
    });

    super.onInit();
  }

  ///全屏广告倒计时
  _fullAdCountDown() {
    if (fullAd == null || !showFullAd) return;
    fullAdTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (fullAdTimerCount > 0) {
          fullAdTimerCount -= 1;
        } else {
          fullAdTimer?.cancel();
        }
        update();
      },
    );
  }

  _resetBeforePlay() {
    playerInitialized.value = false;
    showPermission.value = false;
    resetStopAd();
    resetlFullAd();
    final ad = adHelper.getAdInfo(AdApiType.INSERT_IMAGE);
    if (ad != null) {
      this.ad.value = ad;
    }
  }

  ///切换播放源
  fetchVideoDetailById(int videoId) async {
    if (_requesting) return;
    _requesting = true;
    _resetBeforePlay();
    final resp = await Api.fetchVideoDetailById(videoId: videoId);
    _requesting = false;
    if (resp == null) return;
    currentVideo.value = resp;
    final playPath = currentVideo.value.authPlayUrl;
    _changePlayPath(playPath);
    _getGuessLikeList(videoId: videoId);
  }

  ///更换播放源
  _changePlayPath(String playPath) async {
    logger.d("playPath:>>>>$playPath");
    if (player == null) {
      _initPlayerController(playPath);
    } else {
      await _uploadWatchRC();
      await player?.stop();
      player?.open(Media(playPath), play: !showFullAd);
    }
    playerInitialized.value = true;
    _fullAdCountDown();
  }

  _initPlayerController(String playPath) {
    const config = PlayerConfiguration(
      muted: false, //web下静音可以实现自动播放
      title: '',
      osc: true,
    );
    player = Player(configuration: config);
    playerVC = VideoController(
      player!,
      configuration: VideoControllerConfiguration(
        enableHardwareAcceleration: !GetPlatform.isAndroid,
      ),
    );
    player!.open(Media(playPath), play: !showFullAd);
    _addVideoListeners();
  }

  ///添加监听器
  void _addVideoListeners() {
    ///是否正在播放
    _playingSubs = player!.stream.playing.listen((event) {
      if (!event && player!.state.position.inMilliseconds > 500) {
        showStopAd.value = true;
        update();
      }
    });

    ///播放完成
    _completePosSubs = player!.stream.completed.listen((event) {
      if (event) {
        if (!videoEmpty.value && currentVideo.value.canWatch == false) {
          showPermission.value = true;
        }
      }
    });
  }

  ///卸载监听器
  void _unLoadSubscriptions() {
    _currentPosSubs?.cancel();
    _durationSubs?.cancel();
    _playingSubs?.cancel();
    _completePosSubs?.cancel();
  }

  @override
  void onClose() {
    logger.d("destroy called,release memory!");
    fullAdTimer?.cancel();
    _uploadWatchRC();
    _unLoadSubscriptions();
    videoWorker.dispose();
    player?.dispose();
    super.onClose();
  }

  ///业务操作接口处理

  ///猜你喜欢
  Future _getGuessLikeList({required int videoId}) async {
    final items = await Api.fetchGuessLikeVideoList(videoId: videoId);
    if (items != null) {
      guessLikeItems.assignAll(items);
      update();
    }
  }

  ///充值弹框
  void rechargeTip() {
    permission_alert(
      Get.context!,
      desc: "余额不足,请前往充值",
      oktitle: "去充值",
      okAction: () {
        Get.toVip(tabInitIndex: 1);
      },
    );
  }

  /// 购买
  purchaseVideoAction() async {
    if (videoEmpty.value) return;
    final price = currentVideo.value.price ?? 0;
    final gold = _us.assets.gold ?? 0;
    if (gold < price) {
      rechargeTip();
      return;
    }
    final videoId = currentVideo.value.videoId ?? 0;
    final buyResult = await LoadingView.singleton.wrap(
        context: Get.context!,
        asyncFunction: () => Api.purchaseVideo(videoId: videoId));
    if (buyResult) {
      EasyToast.show('购买成功!');
      fetchVideoDetailById(videoId);
      _us.updateAPIAssetsInfo();
    }
  }

  ///上报观影记录
  _uploadWatchRC() async {
    if (!playerInitialized.value) return;
    if (videoEmpty.value) return;
    if (currentVideo.value.canWatch == false) return;
    final currentSeconds = player!.state.position.inSeconds;
    if (currentSeconds < 5) return;
    //上报
    await Api.uploadWatchRc(
        duration: currentVideo.value.playTime ?? 0,
        lookType: _lookType(),
        videoId: currentVideo.value.videoId ?? 0,
        progress: currentSeconds);
  }

  ///观看方式 1:免费次数 2：vip观看 3： 金币观看 4：试看
  int _lookType() {
    /////视频类型：0-普通视频 1-VIP视频 2-付费视频
    int n = currentVideo.value.videoType ?? 1;
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
}
