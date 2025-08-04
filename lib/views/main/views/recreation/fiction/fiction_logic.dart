import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xhs_app/http/api/api.dart';
import 'package:xhs_app/views/main/views/recreation/fiction/fiction_controller.dart';
import 'package:xhs_app/views/main/views/recreation/fiction/fiction_state.dart';
class FictionLogic extends GetxController   with StateMixin, GetTickerProviderStateMixin  {
  final FictionState state = FictionState();
  final refreshController = Get.put(FictionController());

  @override
  void onInit() {
    loadResourceClassify();
    super.onInit();
  }

  void loadResourceClassify() {
    Map<String, dynamic>? bodyMap=getBodyMap();

    Api.getFictionFindList(bodyMap).then((resp){
        refreshController.bodyParmas =getBodyMap();
        refreshController.refreshController.callRefresh();
        Get.log("===========>滑动完成");
        update();
    });
    update();
  }



  setListIndex(List<String> list,int  index ) {
    if(list==state.list1) {
      state.index1=index;
      state.index2=0;
    }else if(list==state.list2) {
      state.index2=index;
    }
    Map<String,dynamic> bodyParmas=getBodyMap();
    refreshController.bodyParmas=bodyParmas;
    loadResourceClassify();
    update(["buildSelectBtn"]);
  }
  Map<String,dynamic>  getBodyMap(){
    Map<String,dynamic> bodyParmas={};
    bodyParmas["classId"]=state.index1;
    if(state.index2!=0) {
      bodyParmas["fictionSpace"]=state.index2;
    }




    return bodyParmas;
  }


}
