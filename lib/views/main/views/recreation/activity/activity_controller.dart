/*
 * @Author: david wumingshi555888@gmail.com
 * @Date: 2025-02-27 21:07:34
 * @LastEditors: david wumingshi555888@gmail.com
 * @LastEditTime: 2025-03-01 17:42:58
 * @FilePath: /xhs_app/lib/views/main/views/recreation/fiction/fiction_controller.dart
 * @Description: 
 * Copyright (c) 2025 by ${git_name} email: ${git_email}, All Rights Reserved.
 */
import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_controller.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_page_counter.dart';
import 'package:xhs_app/model/fiction/fiction_base_model.dart';

import '../../../../../http/api/api.dart';
class ActivityController extends BaseRefreshController
    with BaseRefreshPageCounter {
  final PagingController<int, FictionBase> pagingControllers =
      PagingController(firstPageKey: 1);
  Map<String,dynamic> bodyParmas={};
  var domain = "";

  var classifyTitle = "";

  @override
  Future<IndicatorResult> onRefresh() async {
    resetPage();
    return await getShortVideos(isRefresh: true);
  }

  @override
  Future<IndicatorResult> onLoad() async {
    incPage();
    return await getShortVideos();
  }

  Future<IndicatorResult> getShortVideos({bool isRefresh = false}) async {
    try {
      if (isRefresh) {
        pagingControllers.refresh();
      }
      final response = await Api.getFictionFindList(bodyParmas,page:page,pageSize: 20);
      if (GetUtils.isBlank(response?.data) == false) {
        domain = response?.domain ?? "";
        pagingControllers.appendPage(response?.data ?? [], page);
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
}
