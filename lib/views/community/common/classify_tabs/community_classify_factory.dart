import 'package:get/get.dart';
import 'package:xhs_app/model/community/community_classify_model.dart';
import 'package:xhs_app/utils/enum.dart';
import 'package:xhs_app/views/community/common/classify_tabs/community_tab_base_widget.dart';
import 'package:xhs_app/views/community/common/classify_tabs/community_tab_empty_widget.dart';
import 'package:xhs_app/views/community/common/classify_tabs/community_tab_tui_jian_widget.dart';
import 'package:xhs_app/views/community/common/classify_tabs/community_tab_tui_jian_controller.dart';

abstract class CommunityClassifyFactory {
  static String _buildTag(CommunityClassifyModel classify) =>
      '${classify.classifyId}';

  static CommunityTabBaseWidget create(CommunityClassifyModel classify) {
    final tag = _buildTag(classify);

    return switch (classify.type) {
      CommunityClassifyTypeEnum.tuiJian ||
      CommunityClassifyTypeEnum.fix ||
      CommunityClassifyTypeEnum.optional =>
        CommunityTabTuiJianWidget(controllerTag: tag),
      _ => CommunityTabEmptyWidget(controllerTag: tag)
    };
  }

  static void bind(CommunityClassifyModel classify) {
    final tag = _buildTag(classify);
    switch (classify.type) {
      case CommunityClassifyTypeEnum.tuiJian ||
            CommunityClassifyTypeEnum.fix ||
            CommunityClassifyTypeEnum.optional:
        Get.lazyPut(() => CommunityTabTuiJianController(classify), tag: tag);
        break;
      default:
        assert(false, 'unknown community classifyType ${classify.type}');
    }
  }
}
