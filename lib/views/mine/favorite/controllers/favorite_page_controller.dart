import 'package:easy_refresh/easy_refresh.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_page_counter.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_controller.dart';
import 'package:xhs_app/components/customize_alert.dart';
import 'package:xhs_app/components/easy_toast.dart';
import 'package:xhs_app/http/api/api.dart';
import 'package:xhs_app/model/mine/resource_model.dart';
import 'package:xhs_app/model/video_base_model.dart';
import 'package:get/get.dart';

const _pageSize = 10;

class FavoritePageController extends BaseRefreshController
    with BaseRefreshPageCounter {
  final videos = <VideoBaseModel>[].obs;
  final resources = <ResourceModel>[].obs;
  var currentTabIndex = 0.obs;
  var visible = false.obs;
  var allSelect = false.obs;

  @override
  Future<IndicatorResult> onRefresh() async {
    onResetRefresh();
    resetPage();
    if (currentTabIndex.value == 0) {
      final resp = await Api.getUserFavoritesList(
        page: page,
        pageSize: _pageSize,
        videoMark: 1,
      );
      if (resp == null) {
        return IndicatorResult.fail;
      }
      incPage();
      _setList(resp);
    } else {
      final resp = await Api.getUserFavoritesResourceList(
        page: page,
        pageSize: _pageSize,
      );
      if (resp == null) {
        return IndicatorResult.fail;
      }
      incPage();
      _setResources(resp);
    }
    return IndicatorResult.success;
  }

  @override
  Future<IndicatorResult> onLoad() async {
    onResetRefresh();
    if (currentTabIndex.value == 0) {
      final resp = await Api.getUserFavoritesList(
        page: page,
        pageSize: _pageSize,
        videoMark: 1,
      );
      if (resp == null) {
        return IndicatorResult.fail;
      }

      _addList(resp);
      if (resp.length < _pageSize) {
        return IndicatorResult.noMore;
      }

      incPage();
    } else {
      final resp = await Api.getUserFavoritesResourceList(
        page: page,
        pageSize: _pageSize,
      );
      if (resp == null) {
        return IndicatorResult.fail;
      }

      _addResources(resp);
      if (resp.length < _pageSize) {
        return IndicatorResult.noMore;
      }

      incPage();
    }
    return IndicatorResult.success;
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

  void _setResources(List<ResourceModel>? list) {
    resources.clear();
    _addResources(list);
  }

  void _addResources(List<ResourceModel>? list) {
    if (null != list && list.isNotEmpty) {
      resources.addAll(list);
    }
  }

  void onSelectedItem(int index) async {
    if (currentTabIndex.value == 0) {
      if (videos.isNotEmpty) {
        videos[index].isSelected = !videos[index].isSelected!;
        var list = <VideoBaseModel>[];
        list.addAll(videos);
        videos.clear();
        videos.addAll(list);
      }
    } else {
      if (resources.isNotEmpty) {
        resources[index].isSelected = !resources[index].isSelected!;
        var list = <ResourceModel>[];
        list.addAll(resources);
        resources.clear();
        resources.addAll(list);
      }
    }
  }

  void onAllSelected() async {
    if (currentTabIndex.value == 0) {
      if (videos.isNotEmpty) {
        for (var i = 0; i < videos.length; i++) {
          videos[i].isSelected = allSelect.value;
        }
        var list = <VideoBaseModel>[];
        list.addAll(videos);
        videos.clear();
        videos.addAll(list);
      }
    } else {
      if (resources.isNotEmpty) {
        for (var i = 0; i < resources.length; i++) {
          resources[i].isSelected = allSelect.value;
        }
        var list = <ResourceModel>[];
        list.addAll(resources);
        resources.clear();
        resources.addAll(list);
      }
    }
  }

  void onResetItem() async {
    allSelect.value = false;
    onAllSelected();
  }

  void onResetRefresh() {
    visible.value = false;
    onResetItem();
  }

  void onDeleteItem() async {
    List<int> ids = [];
    if (currentTabIndex.value == 0) {
      if (videos.isNotEmpty) {
        var list = <VideoBaseModel>[];
        for (var i = 0; i < videos.length; i++) {
          if (videos[i].isSelected == true) {
            ids.add(videos[i].videoId!);
          } else {
            list.add(videos[i]);
          }
        }
        if (ids.isEmpty) {
          EasyToast.show('请勾选');
          return;
        }
        CustomizeAlert(Get.context!, title: '确认删除所选视频', submit: '确认',
            okAction: () async {
          final resp = await Api.clearUserRecord(
            type: 2,
            videoIds: ids,
          );
          if (resp) {
            EasyToast.show('删除成功');
            videos.clear();
            videos.addAll(list);
            onResetRefresh();
          }
        });
      }
    } else {
      if (resources.isNotEmpty) {
        var list = <ResourceModel>[];
        for (var i = 0; i < resources.length; i++) {
          if (resources[i].isSelected == true) {
            ids.add(resources[i].resourceId!);
          } else {
            list.add(resources[i]);
          }
        }
        if (ids.isEmpty) {
          EasyToast.show('请勾选视频');
          return;
        }
        CustomizeAlert(Get.context!, title: '确认删除所选视频', submit: '确认',
            okAction: () async {
          final resp = await Api.clearUserResource(
            resourceIds: ids,
          );
          if (resp) {
            EasyToast.show('删除成功');
            resources.clear();
            resources.addAll(list);
            onResetRefresh();
          }
        });
      }
    }
  }
}
