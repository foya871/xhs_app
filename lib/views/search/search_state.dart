import 'package:get/get.dart';
import 'package:xhs_app/model/video/video_classify_model.dart';

import '../../../model/search/dynamic_hot_word_model.dart';
import '../../../model/search/hot_word_model.dart';

class SearchState {
  SearchState() {
    ///Initialize variables
  }

  var historyKeys = RxList<String>.empty(growable: true);

  var guessLike = RxList<HotWordModel>.empty(growable: true);

  var hotWords = RxList<DynamicHotWordModel>.empty(growable: true);

  ///显示搜索结果页面
  var showResult = false.obs;
  ///是否显示输入框清空按钮
  var showClear = false.obs;

  ///搜索结果分类
  var tabs = [
    VideoClassifyModel(classifyTitle: "笔记",classifyId: 1),
    VideoClassifyModel(classifyTitle: "博主",classifyId: 2),
    VideoClassifyModel(classifyTitle: "漫画",classifyId: 3),
    VideoClassifyModel(classifyTitle: "小说",classifyId: 4),
    VideoClassifyModel(classifyTitle: "写真",classifyId: 5),
    VideoClassifyModel(classifyTitle: "内涵图",classifyId: 6),
    VideoClassifyModel(classifyTitle: "热门短剧",classifyId: 7),
    VideoClassifyModel(classifyTitle: "禁播奇案",classifyId: 8),
    // VideoClassifyModel(classifyTitle: "资源",classifyId: 9),
  ];


}
