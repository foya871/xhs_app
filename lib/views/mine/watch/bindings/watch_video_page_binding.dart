import 'package:xhs_app/views/mine/watch/controllers/watch_video_page_controller.dart';
import 'package:get/get.dart';

class WatchVideoPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => WatchVideoPageController(),
    );
  }
}
