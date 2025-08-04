/*
 * @Author: david wumingshi555888@gmail.com
 * @Date: 2025-02-20 23:07:21
 * @LastEditors: david wumingshi555888@gmail.com
 * @LastEditTime: 2025-03-01 19:25:09
 * @FilePath: /xhs_app/lib/views/mine/favorite/controllers/mine_favorite_collection_controller.dart
 * @Description: 
 * Copyright (c) 2025 by ${git_name} email: ${git_email}, All Rights Reserved.
 */
import 'package:easy_refresh/easy_refresh.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_controller.dart';
import 'package:xhs_app/model/community/collection_base_model.dart';

import '../../../../components/base_refresh/base_refresh_page_counter.dart';
import '../../../../http/api/api.dart';

class MineFavoriteCollectionController extends BaseRefreshController
    with BaseRefreshPageCounter {
  final PagingController<int, CollectionBaseModel> pagingControllers =
      PagingController(firstPageKey: 1);

  @override
  Future<IndicatorResult> onRefresh() async {
    resetPage();
    return await getFavoriteCollectionList(isRefresh: true);
  }

  @override
  Future<IndicatorResult> onLoad() async {
    incPage();
    return await getFavoriteCollectionList();
  }

  Future<IndicatorResult> getFavoriteCollectionList(
      {bool isRefresh = false}) async {
    try {
      if (isRefresh) {
        pagingControllers.refresh();
      }
      final response = await Api.getUserFavoritesCollectList(
        page: page,
        pageSize: 20,
      );
      if (response!.isNotEmpty) {
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
}
