import 'package:get/get.dart';
import 'package:xhs_app/utils/logger.dart';
import 'package:xhs_app/utils/utils.dart';

import '../../../../../http/api/api.dart';
import '../../../../../model/fiction/fiction_chapter_info_model.dart';
import '../../../../../model/fiction/fiction_info_model.dart';
import 'novel_detail_state.dart';

class NovelDetailLogic extends GetxController {
  final NovelDetailState state = NovelDetailState();

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
    Api.getFictionBaseInfo(fictionId: Get.arguments).then((resp){
      state.fictionInfo.value = resp ?? FictionInfoModel();
      if(GetUtils.isNullOrBlank(resp?.chapters) != true){
        loadChapterInfo(resp?.fictionId ?? 0, resp?.chapters?[state.chapterIndex.value].chapterId ?? 0);
      }
    });
  }


  void loadChapterInfo(int fictionId,int chapterId) {
    Api.getFictionChapterInfo(fictionId: fictionId, chapterId: chapterId).then((result){
      state.chapterInfo.value = result ?? FictionChapterInfoModel();
      Api.getFictionContent(result?.playPath ?? "").then((content){
        state.content.value = content ?? "";
      });
    });
  }
  
  void jumpPage(int index){
     if((state.fictionInfo.value.chapters?.length ?? 0) > index){
       var item = state.fictionInfo.value.chapters?[index];
       loadChapterInfo(state.fictionInfo.value.fictionId ?? 0, item?.chapterId ?? 0);
       state.chapterIndex.value = index;
     }
  }




}
