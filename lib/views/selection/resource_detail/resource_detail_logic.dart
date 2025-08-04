import 'package:get/get.dart';
import 'package:xhs_app/utils/logger.dart';

import '../../../http/api/api.dart';
import '../../../model/video/resouce_info_model.dart';
import '../../../model/video/resource_download_model.dart';
import 'resource_detail_state.dart';

class ResourceDetailLogic extends GetxController {
  final ResourceDetailState state = ResourceDetailState();

  @override
  void onInit() {
    loadData();
    super.onInit();
  }

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

  void loadData() {
    Api.getCommunityResourceInfo(Get.arguments).then((resp){
      state.resourceDetail.value = resp ?? ResourceInfoModel();
    });
    Api.getCommunityResourcesReportList(1,100,Get.arguments).then((resp){
      state.reports.assignAll(resp ?? []);
    });
  }



}
