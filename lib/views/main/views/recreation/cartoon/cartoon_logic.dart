import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xhs_app/components/popup/dialog/future_loading_dialog.dart';
import 'package:xhs_app/http/api/api.dart';
import 'package:xhs_app/model/video/comics_other_tag_list_item.dart';
import 'package:xhs_app/model/video/find_video_classify_model.dart';
import 'package:xhs_app/model/video/other_class_list_other_tag_list_item.dart';
import 'package:xhs_app/model/video/video_classify_model.dart';
import 'package:xhs_app/utils/enum.dart';
import 'package:xhs_app/views/main/views/recreation/cartoon/cartoon_state.dart';
import 'package:xhs_app/views/main/views/recreation/cartoon/cartoon_video_controller.dart';
import 'package:xhs_app/views/selection/recommend/recommend_video_controller.dart';

class CartoonLogic extends GetxController
    with StateMixin, GetTickerProviderStateMixin {
  final CartoonState state = CartoonState();
  final optionalClassify = <FindVideoClassifyModel>[]; // 可选择的
  final tabs = <FindVideoClassifyModel>[];
  final expansionTileController = ExpansionTileController();
  final refreshController = Get.put(CartoonVideoController());

  @override
  void onInit() {
    refreshCommunityClassify();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    refreshController.dispose();
    super.onClose();
  }

  Map<String, dynamic> getBodyMap() {
    Map<String, dynamic> bodyParmas = {};
    bodyParmas["classId"] = state.parame1;
    if (state.index2 != 0) {
      bodyParmas["comicsType"] = state.index2;
    }

    if (state.parame3 != 0) {
      bodyParmas["tagId"] = state.parame3;
    }
    if (state.index4 != 0) {
      bodyParmas["isEnd"] = state.index4 == 1 ? false : true;
    }
    if (state.index5 != 0) {
      bodyParmas["orderType"] = state.index5;
    }
    return bodyParmas;
  }

  Future<void> refreshCommunityClassify([int? initialClassifyId]) async {
    Map<String, dynamic> bodyParmas = getBodyMap();
    Get.log("=======>请求bodyParmas   ${bodyParmas}");
    change(null, status: RxStatus.loading());
    final classifyList = await Api.getBaseFindList(bodyParmas);
    if (classifyList == null || classifyList.isEmpty) {
      change(null, status: RxStatus.error());
      return;
    }
    change(null, status: RxStatus.success());
    state.list3.value.clear();
    state.list1.value.clear();
    state.list3.value = await Api.getComicsOtherTagList() ?? [];
    state.list1.value = await Api.getComicsOtherClassList() ?? [];
    state.list1.value.insert(0, OtherClassListOtherTagListItem(title: "全部"));
    state.list3.value.insert(0, ComicsOtherTagListItem(title: "全部"));
    update(["buildSelectBtn"]);

    if (classifyList == null || classifyList.isEmpty) {
      change(null, status: RxStatus.error());
      return;
    }
    change(null, status: RxStatus.success());
    Get.log("===============>刷新");
    update();
  }

  setListIndex(int childIndex, int index) {
    if (index == 0) {
      if (childIndex > 0) {
        OtherClassListOtherTagListItem? item = state.list1[childIndex];
        state.parame1 = item.classId ?? 0;
      } else {
        state.parame1 = 0;
      }
      state.index1 = childIndex;
    } else if (index == 1) {
      state.index2 = childIndex;
    } else if (index == 2) {
      if (childIndex > 0) {
        ComicsOtherTagListItem? item = state.list3[childIndex];
        state.parame3 = item.tagId ?? 0;
      } else {
        state.parame3 = 0;
      }
      state.index3 = childIndex;
    } else if (index == 3) {
      state.index4 = childIndex;
    } else if (index == 4) {
      state.index5 = childIndex;
    }

    Map<String, dynamic> bodyParmas = getBodyMap();
    refreshController.bodyParmas = bodyParmas;
    Get.log("=======>参数  ${bodyParmas}");

    Get.log(
        "=========>index1  前  ${state.index1}  index2 ${state.index2}  index3 ${state.index3}  index4 ${state.index4}   index5 ${state.index5}");

    refreshCommunityClassify();

    update(["buildSelectBtn"]);
  }
}
