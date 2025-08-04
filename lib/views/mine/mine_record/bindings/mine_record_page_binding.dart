import 'package:xhs_app/views/mine/favorite/controllers/favorite_page_controller.dart';
import 'package:get/get.dart';
import 'package:xhs_app/views/mine/mine_record/mine_record_comics_controller.dart';
import 'package:xhs_app/views/mine/mine_record/mine_record_community_controller.dart';
import 'package:xhs_app/views/mine/mine_record/mine_record_fiction_controllder.dart';
import 'package:xhs_app/views/mine/mine_record/mine_record_product_controller.dart';

import '../mine_record_connotation_controller.dart';
import '../mine_record_game_controll.dart';
import '../mine_record_picture_controller.dart';
import '../mine_record_video_controller.dart';

class MineRecordPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => MineRecordCommunityController(),
    );
    Get.lazyPut(
      () => MineRecordComicsController(),
    );
    Get.lazyPut(
      () => MineRecordFictionController(),
    );
    Get.lazyPut(
      () => MineRecordPictureController(),
    );

    Get.lazyPut(
      () => MineRecordConnotationController(),
    );
    Get.lazyPut(
      () => MineRecordVideoController(videoMark: 2),
      tag: "2",
    );
    Get.lazyPut(
      () => MineRecordVideoController(videoMark: 3),
      tag: "3",
    );
    Get.lazyPut(
      () => MineRecordProductController(),
    );
    Get.lazyPut(
      () => MineRecordGameController(),
    );
  }
}
