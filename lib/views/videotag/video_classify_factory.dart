import 'package:get/get.dart';
import 'package:xhs_app/utils/enum.dart';
import 'package:xhs_app/views/community/common/classify_tabs/community_tab_base_widget.dart';
import 'package:xhs_app/views/community/common/classify_tabs/community_tab_empty_widget.dart';
import 'package:xhs_app/views/community/common/classify_tabs/community_tab_tui_jian_widget.dart';
import 'package:xhs_app/views/community/common/classify_tabs/community_tab_tui_jian_controller.dart';
import 'package:xhs_app/views/videotag/video_tab_tui_jian_controller.dart';

import '../../model/video/video_classify_model.dart';

abstract class VideoClassifyFactory {
  static String _buildTag(VideoClassifyModel classify) =>
      '${classify.classifyId}';

  static CommunityTabBaseWidget create(VideoClassifyModel classify) {
    final tag = _buildTag(classify);

    return switch (classify.type) {
      CommunityClassifyTypeEnum.tuiJian ||
      CommunityClassifyTypeEnum.fix ||
      CommunityClassifyTypeEnum.optional =>
        CommunityTabTuiJianWidget(controllerTag: tag),
      _ => CommunityTabEmptyWidget(controllerTag: tag)
    };
  }

  // static void bind(VideoClassifyModel classify) {
  //   final tag = _buildTag(classify);
  //   switch (classify.type) {
  //     case CommunityClassifyTypeEnum.tuiJian ||
  //           CommunityClassifyTypeEnum.fix ||
  //           CommunityClassifyTypeEnum.optional:
  //       Get.lazyPut(() => VideoTabTuiJianController(classify), tag: tag);
  //       break;
  //     default:
  //       assert(false, 'unknown community classifyType ${classify.type}');
  //   }
  // }
}
