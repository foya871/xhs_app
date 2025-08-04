/*
 * @Author: wangdazhuang
 * @Date: 2024-10-16 21:26:27
 * @LastEditTime: 2024-10-18 09:36:29
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /xhs_app/lib/src/views/mine/profit/spread_list_controller.dart
 */

import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_controller.dart';
import 'package:xhs_app/model/mine/spread_user_model.dart';

import '../../../components/base_refresh/base_refresh_page_counter.dart';
import '../../../http/api/api.dart';

class ShareRecordPageController extends BaseRefreshController
    with BaseRefreshPageCounter {
  final _pageSize = 50;
  List<SpreadUserModel> list = List<SpreadUserModel>.of([]);

  @override
  void onInit() {
    onRefresh();
    super.onInit();
  }

  RxInt total = 0.obs;

  @override
  Future<IndicatorResult> onRefresh() async {
    resetPage();
    final resp = await Api.fecthSpreadUserList(
        page: page, pageSize: _pageSize);
    if (resp == null) {
      return IndicatorResult.fail;
    }
    incPage();
    _setList(resp);
    return IndicatorResult.success;
  }

  @override
  Future<IndicatorResult> onLoad() async {
    final resp = await Api.fecthSpreadUserList(
        page: page, pageSize: _pageSize,);
    if (resp == null) {
      return IndicatorResult.fail;
    }

    _addList(resp);
    if (resp.length < _pageSize) {
      return IndicatorResult.noMore;
    }

    incPage();
    return IndicatorResult.success;
  }

  void _setList(List<SpreadUserModel>? arr) {
    list.clear();
    _addList(arr);
  }

  void _addList(List<SpreadUserModel>? arr) {
    if (null != arr && arr.isNotEmpty) {
      list.addAll(arr);
      update();
    }
  }
}
