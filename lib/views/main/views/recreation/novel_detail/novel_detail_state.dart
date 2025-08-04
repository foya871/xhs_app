import 'package:get/get.dart';
import 'package:xhs_app/model/fiction/fiction_chapter_info_model.dart';

import '../../../../../model/fiction/fiction_info_model.dart';

class NovelDetailState {
  NovelDetailState() {
    ///Initialize variables
  }

  ///小说信息
  var fictionInfo = FictionInfoModel().obs;
  ///章节信息
  var chapterInfo = FictionChapterInfoModel().obs;

  var content = "".obs;

  ///章节id
  var chapterIndex = 0.obs;


}
