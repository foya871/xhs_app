import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xhs_app/model/video/adult_game_classify_model.dart';
import 'package:xhs_app/views/main/views/recreation/ai_customization/ai_customization_controller.dart';
import 'package:xhs_app/views/main/views/recreation/ai_customization/ai_customization_state.dart';

import '../../../../../components/base_refresh/base_refresh_page_counter.dart';
import '../../../../../http/api/api.dart';

class AiCustomizationLogic extends GetxController with GetTickerProviderStateMixin  {
  final AiCustomizationState state = AiCustomizationState();
  TabController? tabController;
  final refreshController = Get.put(AiCustomizationController());

  @override
  void onInit() {

    loadGameClassify();
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

  void onChangeTab(Data tab){
    refreshController.gameCollectionId = tab.gameCollectionId ?? 0;
    refreshController.refreshController.callRefresh();
  }

  void loadGameClassify() {
    Api.getAdultGameClassify().then((resp){
      tabController?.dispose();
      tabController = TabController(
        length: (resp?.data ?? []).length,
        vsync: this,
        initialIndex: 0,
      );
      state.tabs.assignAll(resp?.data ?? []);
      if(state.tabs.isNotEmpty){
        refreshController.gameCollectionId = state.tabs.first.gameCollectionId ?? 0;
        refreshController.refreshController.callRefresh();
      }
    });
  }



}
