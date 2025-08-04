import 'package:get/get.dart';
import 'package:xhs_app/http/api/api.dart';
import 'package:xhs_app/model/video/short_video_get_short_video_classify_item.dart';

import 'popular_skits_controller.dart';
import 'popular_skits_state.dart';

// 热门短剧
class PopularSkitsLogic extends GetxController
    with GetTickerProviderStateMixin {
  final PopularSkitsState state = PopularSkitsState();
  final refreshController = Get.put(PopularSkitsController());

  @override
  void onInit() {
    loadResourceClassify();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void loadResourceClassify() async{
    Map<String, dynamic>? bodyMap = getBodyMap();

    Api.getPopularSkitsFindList(bodyMap).then((resp) {
      refreshController.bodyParmas = getBodyMap();
      refreshController.refreshController.callRefresh();
    });
    List<ShortVideoGetShortVideoClassify> list= await Api.getShortVideoShortVideoClassify(2) ?? [];
    state.list1.clear();
    state.list1.value=list;
    state.list1.insert(0, ShortVideoGetShortVideoClassify(classifyTitle: "全部"));
  }

  setListIndex(int index, int selectIndex) {
    if (index == 0) {
      if(selectIndex>0) {
        ShortVideoGetShortVideoClassify? item = state.list1[selectIndex];
        state.param1 = "${item.classifyId??0}";

      }else{
        state.param1=null;
      }
      state.index1 = selectIndex;
    } else if (index == 1) {
      state.index2 = selectIndex;
    }
    Map<String, dynamic> bodyParmas = getBodyMap();
    Get.log("==============>bodyParmas  ${bodyParmas}");

    refreshController.bodyParmas = bodyParmas;
    loadResourceClassify();
    update(["buildSelectBtn"]);
    update();
  }

  Map<String, dynamic> getBodyMap() {
    Map<String, dynamic> bodyParmas = {};
    if (state.index1 != 0) {
      bodyParmas["classifyId"] = state.param1;
    }
    if (state.index2 != 0) {
      bodyParmas["sortNum"] = state.index2;
    }
    bodyParmas["videoMark"] = 2;
    return bodyParmas;
  }
}
