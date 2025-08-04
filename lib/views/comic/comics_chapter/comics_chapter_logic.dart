import 'package:get/get.dart';

import '../../../http/api/api.dart';
import '../../../model/comics/comic_detail_model.dart';
import '../../../model/comics/comics_chapter.dart';
import 'comics_chapter_state.dart';

class ComicsChapterLogic extends GetxController {
  final ComicsChapterState state = ComicsChapterState();

  @override
  void onInit() {
    state.chapter = Get.arguments;
    state.chapterIndex.value = (state.chapter.chapterNum ?? 1) - 1;
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
    Api.getComicsBaseInfo(state.chapter.comicsId ?? 0).then((resp){
      state.comicDetail.value = resp ?? ComicDetailModel();
    });
    loadChapterInfo(state.chapter.chapterId ?? 0);
  }


  void loadChapterInfo(int chapterId){
    Api.getChapterInfo(chapterId).then((resp){
      state.chapterDetail.value = resp ?? ComicsChapterModel();
    });
  }

  void jumpPage(int index){
    if((state.comicDetail.value.chapterList?.length ?? 0) > index){
      var item = state.comicDetail.value.chapterList?[index];
      loadChapterInfo(item?.chapterId ?? 0);
      state.chapterIndex.value = index;
    }
  }

}
