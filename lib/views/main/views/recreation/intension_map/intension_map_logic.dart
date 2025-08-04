import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xhs_app/http/api/api.dart';
import 'package:xhs_app/model/video/connotation_classify_list_tag.dart';
import 'package:xhs_app/views/main/views/recreation/fiction/fiction_controller.dart';
import 'package:xhs_app/views/main/views/recreation/fiction/fiction_state.dart';
import 'package:xhs_app/views/main/views/recreation/intension_map/intension_map_controller.dart';
import 'package:xhs_app/views/main/views/recreation/intension_map/intension_map_state.dart';
import 'package:xhs_app/model/video/community_resource_classify_model.dart';
class IntensionMapLogic extends GetxController  with GetTickerProviderStateMixin {
  final IntensionMapState state = IntensionMapState();
  final refreshController = Get.put(IntensionMapController());

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

  void loadResourceClassify() async {
    Map<String, dynamic>? bodyMap=getBodyMap();

    Api.getIntensionMapFindList(bodyMap).then((resp){
      refreshController.bodyParmas =getBodyMap();
      refreshController.refreshController.callRefresh();
    });
    List<ConnotationClassifyListTag> list= await Api.getConnotationClassifyList() ?? [];
    state.list1.clear();
    state.list1.value=list;
    state.list1.insert(0, ConnotationClassifyListTag(name: "全部"));
    update();
  }
  setListIndex(List<String> list,int  index ) {
    state.index1=index;
    Map<String,dynamic> bodyParmas=getBodyMap();
    refreshController.bodyParmas=bodyParmas;
    loadResourceClassify();
    update(["buildSelectBtn"]);
  }
  Map<String,dynamic>  getBodyMap(){
    Map<String,dynamic> bodyParmas={};
    if(state.index1>0) {
      bodyParmas["classifyName"]=state.list1[state.index1].name;
    }
    return bodyParmas;
  }
}
