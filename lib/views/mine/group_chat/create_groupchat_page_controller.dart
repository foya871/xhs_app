import 'package:flutter/cupertino.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:xhs_app/components/diolog/dialog.dart';
import 'package:xhs_app/http/api/api.dart';
import 'package:xhs_app/model/mine/group_classification_model.dart';

class CreateGroupChatPageController extends GetxController{

  TextEditingController groupNameController = TextEditingController(); //群名称
  TextEditingController groupIntroductionController = TextEditingController(); //群简介

  RxList<GroupClassificationModel> groupClass = <GroupClassificationModel>[].obs;
  String name = "";
  String info = "";
  String classifyName = "";

  @override
  void onInit() {
    getGroupCLassifica();
  }

  Future getGroupCLassifica() async{
    try{
      final resp = await Api.getGroupCLassification();
      if(resp != null){
        groupClass.value = resp;
      }
    }catch(_){}
  }

  void changeCheck(int index){
    if(groupClass.value.isEmpty) return;
    for(int i = 0; i< groupClass.value.length; i++){
      groupClass.value[i].check = false;
    }
    groupClass.value[index].check = true;
    classifyName = groupClass.value[index].name!;
  }

  createGroup() async{
    name = groupNameController.text.toString().trim();
    info = groupIntroductionController.text.toString().trim();
    if(name.isEmpty){
      showToast("群名称不能为空!");
      return;
    }
    if(info.isEmpty){
      showToast("群简介不能为空!");
      return;
    }
    if(classifyName.isEmpty){
      showToast("请选择群分类!");
      return;
    }
    try{
      SmartDialog.showLoading(msg: "正在创建中..");
      final resp = await Api.createGroup(classifyName, info, name);
      if(resp){
        showToast("创建成功");
        Get.back();
      }
    }catch(_){}
    SmartDialog.dismiss();
  }
}