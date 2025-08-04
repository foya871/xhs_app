import 'package:get/get.dart';
import 'package:xhs_app/generate/app_image_path.dart';
import 'package:xhs_app/http/api/api.dart';
import 'package:xhs_app/model/mine/share_link_model.dart';
import 'package:xhs_app/services/user_service.dart';
import 'package:screenshot/screenshot.dart';

import '../../../../routes/routes.dart';

class AgentPageController extends GetxController {
  final userService = Get.find<UserService>();
  final screenshotControllers = ScreenshotController();
  final String cardBg = AppImagePath.mine_agent_share_bg;

  var inviteCode = ''.obs;
  var url = ''.obs;
  var domainFromUrl = ''.obs;

  @override
  void onInit() {
    super.onInit();
    inviteCode.value = userService.user.inviteCode ?? "";
    _getSharedLink();
  }

  Future _getSharedLink() async {
    try {
      final result = await Api.getShareLink();
      if (result is ShareRespModel) {
        url.value = result.url ?? '';
        Uri uri = Uri.parse(url.value);
        if (url.value.isEmpty) return '';
        domainFromUrl.value =
            uri.host.split('.').length > 2 ? '${uri.authority}' : uri.host;
      }
    } catch (e) {
      return null;
    }
  }

  onClick(String title) {
    switch (title) {
      case '推广数据':
        Get.toNamed(Routes.profitmain);
        break;

      default:
        break;
    }
  }
}
