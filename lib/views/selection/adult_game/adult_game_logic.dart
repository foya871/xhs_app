import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../http/api/api.dart';
import '../../../model/video/adult_game_classify_model.dart';
import '../recommend/recommend_video_controller.dart';
import 'adult_game_controller.dart';
import 'adult_game_state.dart';

class AdultGameLogic extends GetxController with GetTickerProviderStateMixin  {
  final AdultGameState state = AdultGameState();
  TabController? tabController;
  final refreshController = Get.put(AdultGameController());

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
    Get.delete<AdultGameController>();
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
