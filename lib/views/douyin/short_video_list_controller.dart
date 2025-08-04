/*
 * @Author: wangdazhuang
 * @Date: 2024-09-25 09:39:00
 * @LastEditTime: 2024-11-29 10:04:52
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /xhs_app/lib/src/views/short_video_player/short_video_list_controller.dart
 */
import 'package:easy_refresh/easy_refresh.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_controller.dart';

import '../../components/base_refresh/base_refresh_page_counter.dart';
import '../../http/api/api.dart';
import '../../model/video_base_model.dart';

class ShortVideoListController extends BaseRefreshController
    with BaseRefreshPageCounter {
  final String classifyId;
  ShortVideoListController({required this.classifyId});
  final _pageSize = 30;
  List<VideoBaseModel> videos = List<VideoBaseModel>.of([]);

  @override
  Future<IndicatorResult> onRefresh() async {
    resetPage();
    final resp = await Api.fetchShortVideoListByClassifyId(
        page: page, pageSize: _pageSize, classifyId: classifyId);
    if (resp == null) {
      return IndicatorResult.fail;
    }
    incPage();
    _setList(resp);
    return IndicatorResult.success;
  }

  @override
  Future<IndicatorResult> onLoad() async {
    final resp = await Api.fetchShortVideoListByClassifyId(
        page: page, pageSize: _pageSize, classifyId: classifyId);
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

  void _setList(List<VideoBaseModel>? list) {
    videos.clear();
    _addList(list);
  }

  void _addList(List<VideoBaseModel>? list) {
    if (null != list && list.isNotEmpty) {
      videos.addAll(list);
      update([classifyId]);
    }
  }
}
