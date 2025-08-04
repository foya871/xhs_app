import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xhs_app/components/diolog/dialog.dart';
import 'package:xhs_app/model/product/product_classify_model.dart';
import 'package:xhs_app/services/storage_service.dart';
import 'package:xhs_app/views/selection/selection_search/game/game_list_controller.dart';
import 'package:xhs_app/views/selection/selection_search/game/game_list_widget.dart';
import 'package:xhs_app/views/selection/selection_search/product/product_list_widget.dart';
import 'package:xhs_app/views/selection/selection_search/resource/resource_list_widget.dart';

import '../../../http/api/api.dart';
import '../../../model/search/search_video_model.dart';
import 'product/product_list_controller.dart';
import 'resource/resource_list_controller.dart';
import 'selection_search_state.dart';

class SelectionSearchLogic extends GetxController with GetTickerProviderStateMixin {
  final SelectionSearchState state = SelectionSearchState();
  var storage = Get.find<StorageService>();
  var textController = TextEditingController();
  // late var dynamicController = Get.put(SearchDynamicController());
  // late var bloggerController = Get.put(SearchBloggerController());
  // late var comicsController = Get.put(SearchComicsController());
  // late var novelController = Get.put(SearchNovelController());
  // late var photoController = Get.put(SearchPhotoController());
  // late var connotationController = Get.put(SearchConnotationController());
  // late var playletController = Get.put(SearchPlayletController());
  // late var banCaseController = Get.put(SearchBanCaseController());

  TabController? tabController;
  PageController? pageController;



  @override
  void onInit() {
    pageController = PageController();
    loadData();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    tabController?.dispose();
    pageController?.dispose();
    // Get.delete<SearchDynamicController>();
    // Get.delete<SearchBloggerController>();
    // Get.delete<SearchComicsController>();
    // Get.delete<SearchNovelController>();
    // Get.delete<SearchPhotoController>();
    // Get.delete<SearchConnotationController>();
    // Get.delete<SearchPlayletController>();
    // Get.delete<SearchBanCaseController>();
    ///移除页面刷新控制器
    state.tabs.forEach((item){
      Get.delete<ProductListController>(tag: "${item.classifyId}");
    });
    state.tabs.clear();
    super.onClose();
  }

  void clearHistory(){
    state.historyKeys.clear();
    storage.saveSearchSelectionHistory(state.historyKeys);
  }

  // void setSearchKeyword(){
    // dynamicController.keyword = textController.text;
    // bloggerController.keyword = textController.text;
    // comicsController.keyword = textController.text;
    // novelController.keyword = textController.text;
    // photoController.keyword = textController.text;
    // connotationController.keyword = textController.text;
    // playletController.keyword = textController.text;
    // banCaseController.keyword = textController.text;
  // }

  void onSearch(String word){
    if(GetUtils.isNullOrBlank(word) == true){
      showToast("请输入搜索关键词");
      return;
    }
    state.showResult.value = true;
    ///记录历史记录
    ///处理逻辑,如果已有改关键词,则删除该关键词,再添加到第一个位置,没有需要判断是否关键词数量大于等于20,大于等于则删除最后一个,再添加到第一个位置
    if(!state.historyKeys.contains(word)){
      if(state.historyKeys.length >= 20){
        state.historyKeys.removeLast();
      }
      state.historyKeys.insert(0, word);
      storage.saveSearchSelectionHistory(state.historyKeys);
    } else {
      state.historyKeys.remove(word);
      state.historyKeys.insert(0, word);
    }
    state.refreshList[tabController?.index ?? 0].refreshController.callRefresh();
    // switch(tabController?.index){
    //   case 0:
    //     dynamicController.refreshController.callRefresh();
    //     break;
    //   case 1:
    //     bloggerController.refreshController.callRefresh();
    //     break;
    //   case 2:
    //     comicsController.refreshController.callRefresh();
    //     break;
    //   case 3:
    //     novelController.refreshController.callRefresh();
    //     break;
    //   case 4:
    //     photoController.refreshController.callRefresh();
    //     break;
    //   case 5:
    //     connotationController.refreshController.callRefresh();
    //     break;
    //   case 6:
    //     playletController.refreshController.callRefresh();
    //     break;
    //   case 7:
    //     banCaseController.refreshController.callRefresh();
    //     break;
    // }
  }

  void loadData() {

    Api.getProductClassifyOptionalList().then((resp){
      state.tabs.assignAll(resp ?? []);
      tabController?.dispose();
      tabController = TabController(length: state.tabs.length, vsync: this, initialIndex: 0,);
      ///添加页面刷新控制器
      state.tabs.forEach((item){
        switch(item.type){
          case 1:
            var controller = Get.put(ProductListController(),tag: "${item.classifyId}");
            controller.classifyId = "${item.classifyId ?? 0}";
            state.refreshList.add(controller);
            state.pages.add(ProductListWidget(controller,item));
            break;
          case 2:
            var controller = Get.put(GameListController(),tag: "${item.classifyId}");
            state.refreshList.add(controller);
            state.pages.add(GameListWidget(controller,item));
            break;
          case 3:
            var controller = Get.put(ResourceListController(),tag: "${item.classifyId}");
            state.refreshList.add(controller);
            state.pages.add(ResourceListWidget(controller,item));
            break;
        }
      });
    });

    state.historyKeys.assignAll(storage.searchSelectionHistory);
    Api.getSearchRecWord().then((resp){
      state.guessLike.assignAll(resp ?? []);
    });

    // Api.getDynamicHotWord().then((resp){
    //   state.hotWords.assignAll(resp ?? []);
    // });

  }

  void onChangeTab(ProductClassifyModel tab){
    // refreshController.classifyTitle = tab.classifyTitle ?? "";
    // refreshController.refreshController.callRefresh();
    var controller = state.refreshList[state.tabs.indexOf(tab)];
    controller.refreshController.callRefresh();
  }



}
