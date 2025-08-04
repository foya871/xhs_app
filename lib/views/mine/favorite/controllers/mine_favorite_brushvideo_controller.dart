import 'package:easy_refresh/easy_refresh.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_controller.dart';

import '../../../../components/base_refresh/base_refresh_page_counter.dart';
import '../../../../http/api/api.dart';
import '../../../../model/video_base_model.dart';

class MineFavoriteBrushVideoController extends BaseRefreshController
    with BaseRefreshPageCounter {
  final PagingController<int, VideoBaseModel> pagingControllers =
      PagingController(firstPageKey: 1);
  List<VideoBaseModel> videos = List<VideoBaseModel>.of([]);

  @override
  Future<IndicatorResult> onRefresh() async {
    resetPage();
    return await getFavoriteVideoList(isRefresh: true);
  }

  @override
  Future<IndicatorResult> onLoad() async {
    incPage();
    return await getFavoriteVideoList();
  }

  Future<IndicatorResult> getFavoriteVideoList({bool isRefresh = false}) async {
    try {
      if (isRefresh) {
        pagingControllers.refresh();
      }
      final response = await Api.getUserFavoritesList(
        page: page,
        pageSize: 20,
        videoMark: 2,
      );
      if (response!.isNotEmpty) {
        pagingControllers.appendPage(response, page);
        if (isRefresh == true) {
          _setList(response);
        } else {
          _addList(response);
        }
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

  void _setList(List<VideoBaseModel>? list) {
    videos.clear();
    _addList(list);
  }

  void _addList(List<VideoBaseModel>? list) {
    if (null != list && list.isNotEmpty) {
      videos.addAll(list);
    }
  }
}
