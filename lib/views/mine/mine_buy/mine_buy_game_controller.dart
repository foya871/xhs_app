/*
 * @Author: david wumingshi555888@gmail.com
 * @Date: 2025-03-02 16:22:22
 * @LastEditors: david wumingshi555888@gmail.com
 * @LastEditTime: 2025-03-02 16:24:24
 * @FilePath: /xhs_app/lib/views/mine/mine_buy/mine_buy_game_controller.dart
 * @Description: 
 * Copyright (c) 2025 by ${git_name} email: ${git_email}, All Rights Reserved.
 */
import 'package:easy_refresh/easy_refresh.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_controller.dart';
import 'package:xhs_app/model/adult_game_model/adult_game_model.dart';

import '../../../../components/base_refresh/base_refresh_page_counter.dart';
import '../../../../http/api/api.dart';

class MineBuyGameController extends BaseRefreshController
    with BaseRefreshPageCounter {
  final PagingController<int, AdultGameModel> pagingControllers =
      PagingController(firstPageKey: 1);

  @override
  Future<IndicatorResult> onRefresh() async {
    resetPage();
    return await getBuyGameRecord(isRefresh: true);
  }

  @override
  Future<IndicatorResult> onLoad() async {
    incPage();
    return await getBuyGameRecord();
  }

  Future<IndicatorResult> getBuyGameRecord({bool isRefresh = false}) async {
    try {
      if (isRefresh) {
        pagingControllers.refresh();
      }
      final response = await Api.getBuyGameRecord(
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
