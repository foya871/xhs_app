/*
 * @Author: david wumingshi555888@gmail.com
 * @Date: 2025-02-26 21:01:29
 * @LastEditors: david wumingshi555888@gmail.com
 * @LastEditTime: 2025-03-03 21:19:33
 * @FilePath: /xhs_app/lib/views/mine/mine_releases/mine_release_collection_controller.dart
 * @Description: 
 * Copyright (c) 2025 by ${git_name} email: ${git_email}, All Rights Reserved.
 */
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_controller.dart';
import 'package:xhs_app/services/user_service.dart';

import '../../../../components/base_refresh/base_refresh_page_counter.dart';
import '../../../../http/api/api.dart';
import '../../../model/community/collection_base_model.dart';

/// 我的-发布-我的合集
class MineReleaseCollectionController extends BaseRefreshController
    with BaseRefreshPageCounter {
  final PagingController<int, CollectionBaseModel> pagingControllers =
      PagingController(firstPageKey: 1);

  final userService = Get.find<UserService>();

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      selectedCollection.value = Get.arguments;
      selectCollectionName.value = Get.arguments.collectionName ?? '';
    }
  }

  @override
  Future<IndicatorResult> onRefresh() async {
    resetPage();
    return await queryCollection(isRefresh: true);
  }

  @override
  Future<IndicatorResult> onLoad() async {
    incPage();
    return await queryCollection();
  }

  Future<IndicatorResult> queryCollection({bool isRefresh = false}) async {
    try {
      if (isRefresh) {
        pagingControllers.refresh();
      }
      final response = await Api.queryCollectionByUser(
        page: page,
        pageSize: 20,
        userId: userService.user.userId!,
      );
      if (response.isNotEmpty) {
        pagingControllers.appendPage(response, page);
        return IndicatorResult.success;
      } else {
        if (isRefresh) {
          pagingControllers.appendLastPage([]);
          return IndicatorResult.success;
        } else {
          pagingControllers.appendLastPage([]);
          return IndicatorResult.noMore;
        }
      }
    } catch (e) {
      return IndicatorResult.fail;
    }
  }

  RxString selectCollectionName = ''.obs;
  var selectedCollection = CollectionBaseModel().obs;
  RxString collectionName = ''.obs;
  RxString collectionCoverImg = ''.obs;

  Future<bool?> addBloggerCollection() async {
    try {
      await Api.addBloggerCollection(
          collectionName.value, collectionCoverImg.value);
      return true;
    } catch (e) {
      return null;
    }
  }

  Future<bool?> delCollection(List<int> ids) async {
    try {
      await Api.delCollection(ids);
      selectedIds.clear();
      pagingControllers.refresh();
      return true;
    } catch (e) {
      return null;
    }
  }

  TextEditingController collectionNameController = TextEditingController();

  RxList<int> selectedIds = <int>[].obs;
}
