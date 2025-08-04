import 'package:get/get.dart';
import 'package:xhs_app/components/diolog/dialog.dart';

import '../../../http/api/api.dart';
import '../resource_detail/resource_detail_logic.dart';
import 'resource_feedback_state.dart';

class ResourceFeedbackLogic extends GetxController {
  final ResourceFeedbackState state = ResourceFeedbackState();

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  void submitReport(){
    if(state.selectItem.value == 4 && state.textController.text.isEmpty){
      showToast("请输入反馈内容");
      return;
    }
    var resourcesId = Get.arguments;
    Api.resourceReport(state.selectItem.value,Get.arguments, state.textController.text).then((resp){
      // 刷新详情页
      if (Get.isRegistered<ResourceDetailLogic>(tag: "$resourcesId")) {
        Get.find<ResourceDetailLogic>(tag: "$resourcesId").loadData();
      }
      showToast("提交成功");
      Get.back();
    });

  }


}
