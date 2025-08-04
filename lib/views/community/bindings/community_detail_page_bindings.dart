import 'package:get/get.dart';
import 'package:xhs_app/views/community/common/base/community_detail/community_detail_brush_cell_controller.dart';

import '../controllers/community_detail_page_controller.dart';

class CommunityDetailPageBindings extends Bindings {
  @override
  void dependencies() {
    // 这里页面允许多次打开
    //  详情页->博主页->详情页->博主页->....
    Get.create(() => CommunityDetailPageController());
    Get.create(() => CommunityBrushDetailCellController());
  }
}
