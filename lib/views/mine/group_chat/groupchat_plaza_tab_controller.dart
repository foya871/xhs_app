import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../http/api/api.dart';

class GroupChatPlazaTabPageController extends GetxController
    with GetTickerProviderStateMixin{
  late TabController tabController;
  RxList<Tab> tabs = <Tab>[const Tab(text: "推荐")].obs;

  @override
  void onInit() {
    tabController = TabController(length: tabs.length, vsync: this);
    super.onInit();
  }

  @override
  void onReady() {
    getGroupCLassifica();
  }

  Future getGroupCLassifica() async{
    try{
      final resp = await Api.getGroupCLassification();
      if(resp.isNotEmpty){
        for(var item in resp){
          tabs.add(Tab(text: item.name));
        }
        tabController = TabController(length: tabs.length, vsync: this);
        update();
      }
    }catch(_){}
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}