/*
 * @Author: david wumingshi555888@gmail.com
 * @Date: 2025-02-27 17:45:54
 * @LastEditors: david wumingshi555888@gmail.com
 * @LastEditTime: 2025-03-01 18:04:12
 * @FilePath: /xhs_app/lib/views/main/views/recreation/cartoon/cartoon_video_controller.dart
 * @Description: 
 * Copyright (c) 2025 by ${git_name} email: ${git_email}, All Rights Reserved.
 */
import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:xhs_app/components/ad/ad_enum.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_controller.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_page_counter.dart';
import 'package:xhs_app/http/api/api.dart';
import 'package:xhs_app/model/comics/comics_base.dart';
import 'package:xhs_app/views/main/views/recreation/cartoon/cartoon_logic.dart';
import 'package:xhs_app/components/ad/ad_insert_helper.dart';

class CartoonVideoController extends BaseRefreshController
    with BaseRefreshPageCounter {
  final PagingController<int, ComicsBaseModel> pagingControllers =
      PagingController(firstPageKey: 1);
  RxBool init = false.obs;
  var domain = "";
  Map<String, dynamic> bodyParmas = {};
  final _adInsertHelper = AdInsertHelper<ComicsBaseModel>(
      AdApiType.THREE_COLUMN_WATERFALL_VERTICAL);

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
      final response = await Api.getBaseFindList(
        bodyParmas,
        page: page,
        pageSize: 20,
      );
      if (isClosed) return IndicatorResult.fail;
      if (isRefresh) {
        _adInsertHelper.reset();
      }
      if (GetUtils.isBlank(response) == false) {
        final models = _adInsertHelper.insertWithType(
          response ?? [],
          (place) => ComicsBaseModel.fromAd(place),
        );
        pagingControllers.appendPage(models, page);
        Get.find<CartoonLogic>().update();
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

  @override
  void onClose() {
    pagingControllers.dispose();
    super.onClose();
  }
}
