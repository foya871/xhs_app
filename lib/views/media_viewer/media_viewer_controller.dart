/*
 * @Author: wangdazhuang
 * @Date: 2025-01-21 19:02:39
 * @LastEditTime: 2025-01-22 09:11:44
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /xhs_app/lib/views/media_viewer/media_viewer_controller.dart
 */
import 'package:get/get.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:xhs_app/utils/utils.dart';

///目前只支持一个视频的情况，多个视频的情况 需要单独管理每个player
class MediaViewerController extends GetxController {
  var title = ''.obs;
  var images = <String>[].obs;
  var playPath = ''.obs;
  var currentIndex = 1.obs;
  var sources = <String>[].obs;

  VideoController? playerVC;
  Player? player;

  @override
  void onInit() {
    final args = Utils.asType<Map>(Get.arguments);
    assert(args != null, 'data initialized error');
    final video = args!["video"];
    if (video != null) {
      final videoPath = Utils.asType<String>(video, defaultValue: '') ?? '';
      if (videoPath.isNotEmpty) {
        playPath.value = videoPath;
        sources.add(playPath.value);
        const config = PlayerConfiguration(
          muted: false,
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
        player?.open(Media(playPath.value), play: false);
      }
    }

    final imgs = args["images"];
    if (imgs != null) {
      images.value = Utils.asType<List<String>>(imgs, defaultValue: []) ?? [];
      sources.addAll(images);
    }

    final extra = Get.parameters["extra"];
    if (extra != null) {
      title.value = Utils.asType<String>(extra, defaultValue: '') ?? '';
    }
    super.onInit();
  }

  void visibleVideo({required bool visible}) {
    if (visible) {
      player?.play();
    } else {
      player?.pause();
    }
  }

  @override
  void onClose() {
    player?.dispose();
    super.onClose();
  }
}
