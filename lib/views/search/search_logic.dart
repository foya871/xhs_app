import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xhs_app/components/diolog/dialog.dart';
import 'package:xhs_app/services/storage_service.dart';

import '../../../http/api/api.dart';
import '../../../model/video/video_classify_model.dart';
import '../../model/search/search_video_model.dart';
import 'classify/search_ban_case_controller.dart';
import 'classify/search_blogger_controller.dart';
import 'classify/search_comics_controller.dart';
import 'classify/search_connotation_controller.dart';
import 'classify/search_dynamic_controller.dart';
import 'classify/search_novel_controller.dart';
import 'classify/search_photo_controller.dart';
import 'classify/search_playlet_controller.dart';
import 'search_state.dart';

class SearchLogic extends GetxController with GetTickerProviderStateMixin {
  final SearchState state = SearchState();
  var storage = Get.find<StorageService>();
  var textController = TextEditingController();
  final dynamicController = Get.put(SearchDynamicController());
  final bloggerController = Get.put(SearchBloggerController());
  final comicsController = Get.put(SearchComicsController());
  final novelController = Get.put(SearchNovelController());
  final photoController = Get.put(SearchPhotoController());
  final connotationController = Get.put(SearchConnotationController());
  final playletController = Get.put(SearchPlayletController());
  final banCaseController = Get.put(SearchBanCaseController());

  TabController? tabController;
  PageController? pageController;

  @override
  void onInit() {
    pageController = PageController();
    tabController = TabController(
      length: state.tabs.length,
      vsync: this,
      initialIndex: 0,
    );
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
    Get.delete<SearchDynamicController>();
    Get.delete<SearchBloggerController>();
    Get.delete<SearchComicsController>();
    Get.delete<SearchNovelController>();
    Get.delete<SearchPhotoController>();
    Get.delete<SearchConnotationController>();
    Get.delete<SearchPlayletController>();
    Get.delete<SearchBanCaseController>();
    super.onClose();
  }

  void clearHistory() {
    state.historyKeys.clear();
    storage.saveSearchHistory(state.historyKeys);
  }

  void setSearchKeyword() {
    dynamicController.keyword = textController.text;
    bloggerController.keyword = textController.text;
    comicsController.keyword = textController.text;
    novelController.keyword = textController.text;
    photoController.keyword = textController.text;
    connotationController.keyword = textController.text;
    playletController.keyword = textController.text;
    banCaseController.keyword = textController.text;
  }

  void onSearch(String word) {
    if (GetUtils.isNullOrBlank(word) == true) {
      showToast("请输入搜索关键词");
      return;
    }
    state.showResult.value = true;

    ///记录历史记录
    ///处理逻辑,如果已有改关键词,则删除该关键词,再添加到第一个位置,没有需要判断是否关键词数量大于等于20,大于等于则删除最后一个,再添加到第一个位置
    if (!state.historyKeys.contains(word)) {
      if (state.historyKeys.length >= 20) {
        state.historyKeys.removeLast();
      }
      state.historyKeys.insert(0, word);
      storage.saveSearchHistory(state.historyKeys);
    } else {
      state.historyKeys.remove(word);
      state.historyKeys.insert(0, word);
    }
    switch (tabController?.index) {
      case 0:
        dynamicController.keyword = word;
        dynamicController.refreshController.callRefresh();
        break;
      case 1:
        bloggerController.keyword = word;
        bloggerController.refreshController.callRefresh();
        break;
      case 2:
        comicsController.keyword = word;
        comicsController.refreshController.callRefresh();
        break;
      case 3:
        novelController.keyword = word;
        novelController.refreshController.callRefresh();
        break;
      case 4:
        photoController.keyword = word;
        photoController.refreshController.callRefresh();
        break;
      case 5:
        connotationController.keyword = word;
        connotationController.refreshController.callRefresh();
        break;
      case 6:
        playletController.keyword = word;
        playletController.refreshController.callRefresh();
        break;
      case 7:
        banCaseController.keyword = word;
        banCaseController.refreshController.callRefresh();
        break;
    }
  }

  void loadData() {
    state.historyKeys.assignAll(storage.searchHistory);
    Api.getSearchHotWord().then((resp) {
      state.guessLike.assignAll(resp ?? []);
    });

    Api.getDynamicHotWord().then((resp) {
      state.hotWords.assignAll(resp ?? []);
    });
  }

  void onChangeTab(VideoClassifyModel tab) {
    // refreshController.classifyTitle = tab.classifyTitle ?? "";
    // refreshController.refreshController.callRefresh();
  }

  void userAttention(BloggerList blogger) {
    Api.communityAttention(
            toUserId: blogger.userId ?? 0,
            isAttention: blogger.attention == true)
        .then((resp) {
      ///刷新数据
      var index =
          bloggerController.pagingControllers.itemList?.indexOf(blogger);
      if (index != null) {
        blogger.attention = !(blogger.attention ?? false);
        bloggerController.pagingControllers.itemList?[index] = blogger;
        bloggerController.pagingControllers
            .appendPage([], bloggerController.page);
      }
    });
  }
}
