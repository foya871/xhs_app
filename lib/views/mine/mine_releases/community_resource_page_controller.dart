/*
 * @Author: david wumingshi555888@gmail.com
 * @Date: 2025-03-01 13:20:43
 * @LastEditors: david wumingshi555888@gmail.com
 * @LastEditTime: 2025-03-03 12:52:17
 * @FilePath: /xhs_app/lib/views/mine/mine_releases/community_resource_page_controller.dart
 * @Description: 
 * Copyright (c) 2025 by ${git_name} email: ${git_email}, All Rights Reserved.
 */
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:xhs_app/components/easy_toast.dart';
import 'package:xhs_app/http/api/api.dart';

import '../../../model/community/community_classify_model.dart';
import '../../../model/community/community_resource_model.dart';
import '../../../services/user_service.dart';

class CommunityResourcePageController extends GetxController {

  TextEditingController titleEditingController = TextEditingController();

  TextEditingController infoEditingController = TextEditingController();

  TextEditingController priceEditingController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  TextEditingController websiteController = TextEditingController();

  FocusNode focusNode = FocusNode();
  FocusNode infoNode = FocusNode();
  FocusNode passwordNode = FocusNode();
  FocusNode websiteNode = FocusNode();
  FocusNode priceFocusNode = FocusNode();

  final us = Get.find<UserService>();
  final int maxLength = 200;
  var communityRelease = CommunityResourceModel.fromJson({}).obs;

  ///分类
  var classifyItems = <CommunityClassifyModel>[].obs;
  var currentClassify = CommunityClassifyModel.fromJson({}).obs;

  var moneyInputFormatter =
      FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'));

  @override
  void onClose() {
    titleEditingController.dispose();
    infoEditingController.dispose();
    priceEditingController.dispose();
    passwordController.dispose();
    websiteController.dispose();
    focusNode.dispose();
    infoNode.dispose();
    passwordNode.dispose();
    websiteNode.dispose();
    priceFocusNode.dispose();
    super.onClose();
  }

  Future<void> getResourcesClassifyList() async {
    final result = await Api.getResourcesClassifyList();
    if (result != null) {
      classifyItems.value = result;
      update();
    }
  }

  Future selectClassify(CommunityClassifyModel item) async {
    currentClassify.value = item;
    update();
  }

  Future addImages(List<String> images) async {
    communityRelease.value.images = images;
  }

  Future<void> release() async {
    if (communityRelease.value.resourcesTitle!.isEmpty) {
      EasyToast.show('请填写标题');
      return;
    }
    if (communityRelease.value.classifyTitle!.isEmpty) {
      EasyToast.show('请选择分类');
      return;
    }
    if (communityRelease.value.website!.isEmpty) {
      EasyToast.show('请填写资源下载链接');
      return;
    }
    if (communityRelease.value.decompressPassword!.isEmpty) {
      EasyToast.show('请输入资源提取码');
      return;
    }

    ///发布资源
    final result =
        await Api.communityResourceRelease(bean: communityRelease.value);
    if (result) {
      EasyToast.show('发布成功');
      Get.back();
    }
  }
}
