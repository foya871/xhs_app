import 'package:get/get.dart';
import 'package:xhs_app/http/api/api.dart';
import 'package:xhs_app/model/video/short_video_get_short_video_classify_item.dart';
import 'package:xhs_app/views/main/views/recreation/banned_the_strange_case/banned_the_strange_case_controller.dart';
import 'package:xhs_app/views/main/views/recreation/banned_the_strange_case/banned_the_strange_case_state.dart';



// 热门短剧
class BannedTheStrangeCaseLogic extends GetxController
    with GetTickerProviderStateMixin {
  final BannedTheStrangeCaseState state = BannedTheStrangeCaseState();
  final refreshController = Get.put(BannedTheStrangeCaseController());

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
    Api.getShortVideoShortVideoClassify(3).then((resp) {
      refreshController.bodyParmas = getBodyMap();
      refreshController.refreshController.callRefresh();
    });
    List<ShortVideoGetShortVideoClassify> list= await Api.getShortVideoShortVideoClassify(3) ?? [];
    state.list1.clear();
    state.list1.value=list;
    state.list1.insert(0, ShortVideoGetShortVideoClassify(classifyTitle: "全部"));
    update();
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
  }

  Map<String, dynamic> getBodyMap() {
    Map<String, dynamic> bodyParmas = {};
    if (state.index1 != 0) {
      bodyParmas["classifyId"] = state.param1;
    }
    if (state.index2 != 0) {
      bodyParmas["sortNum"] = state.index2;
    }
    bodyParmas["videoMark"] = 3;

    return bodyParmas;
  }
}
