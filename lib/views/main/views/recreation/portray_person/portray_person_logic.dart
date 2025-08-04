import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xhs_app/http/api/api.dart';
import 'package:xhs_app/model/video/tag_list_other_tag_list_item.dart';
import 'package:xhs_app/views/main/views/recreation/fiction/fiction_controller.dart';
import 'package:xhs_app/views/main/views/recreation/fiction/fiction_state.dart';
import 'package:xhs_app/views/main/views/recreation/portray_person/portray_person_controller.dart';
import 'package:xhs_app/views/main/views/recreation/portray_person/portray_person_state.dart';
import 'package:xhs_app/model/video/community_resource_classify_model.dart';
class PortrayPersonLogic extends GetxController
    with StateMixin, GetTickerProviderStateMixin {
  final PortrayPersonState state = PortrayPersonState();
  final refreshController = Get.put(PortrayPersonController());

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
    Map<String, dynamic>? bodyMap=getBodyMap();
    Api.portrayGetPictureList(bodyMap).then((resp){
      refreshController.bodyParmas =getBodyMap();
      refreshController.refreshController.callRefresh();
    });


    List<TagListOtherTagListItem> list= await Api.getPortrayPortrayClassify() ?? [];
    state.list1.clear();
    state.list1.value=list.sorted((a,b)=>(a.sortNum??0)-(b.sortNum??0));
    state.list1.value.insert(0, TagListOtherTagListItem(title: "全部"));
    update(["buildSelectBtn"]);
    Get.log("==============>刷新数据");
    update();

  }



  setListIndex(int childIndex, int index) {
    if (index == 0) {
      if(childIndex>0) {
        TagListOtherTagListItem? item = state.list1[childIndex];
        state.parame1 = item.classifyId ?? 0;
        Get.log("=============>parame1   ${state.parame1}   ${childIndex}");
      }else{
        state.parame1=0;
      }
      state.index1 = childIndex;
    }
    else if(index==1) {
      state.index2=index;
    }
    Map<String,dynamic> bodyParmas=getBodyMap();
    refreshController.bodyParmas=bodyParmas;
    loadResourceClassify();
    update(["buildSelectBtn"]);
  }

  Map<String,dynamic>  getBodyMap(){
    Map<String,dynamic> bodyParmas={};
    Get.log("=============>parame1   ${state.parame1}   ${state.index1}");
    if(state.index1>0) {
      if(state.parame1>0) {
        bodyParmas["classifyId"]=state.parame1;
      }
    }
    else if(state.index2!=0) {
      bodyParmas["orderType"]=state.index2;
    }
    return bodyParmas;
  }


}
