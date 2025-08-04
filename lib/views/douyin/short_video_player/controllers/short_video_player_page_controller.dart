import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:xhs_app/components/ad/ad_info_model.dart';

import '../../../../http/api/api.dart';
import '../../../../model/play/cdn_model.dart';
import '../../../../model/video_base_model.dart';
import '../../../../utils/consts.dart';
import '../../../../utils/logger.dart';
import '../../../../utils/utils.dart';
import '../common/short_v_p_cell_controller.dart';
import '../common/short_video_model.dart';

enum ShortVideoPlayerMode { local, recommend, focus }

const _pageSize = 60;
const _invisibleItemsThreshold = 5; // 提前加载下一页的数量
const _preLoadDetailCount = 3; // 详情预加载数量

typedef ShortVideoOrAdModel = dynamic; // ShortVideoModel | AdvertisementInfos

class ShortVideoPlayerPageController extends GetxController with StateMixin {
  ShortVideoPlayerMode? mode;
  ShortVideoPlayerPageController({this.mode = ShortVideoPlayerMode.local});
  late final int _adInterval;
  late final AdInfoModel? _ad;
  int _lastPageRemainVideoCount = 0;

  final pagingController = PagingController<int, ShortVideoOrAdModel>(
    firstPageKey: Consts.pageFirst,
    invisibleItemsThreshold: _invisibleItemsThreshold,
  );
  late final PageController? pageController;
  var cdnLines = <CdnRsp>[];
  final webUnmuteTouched = false.obs;
  int currentIndex = -1;
  bool pageVisible = false;
  final cellControllers = <int, ShortVPCellController>{};

  void preLoadDetail(int index) {
    final itemList = pagingController.itemList;
    if (itemList == null || itemList.isEmpty) return;
    if (index < 0) return;
    final length = itemList.length;
    int preCount = 0;
    while (index < length) {
      final item = itemList[index++];
      if (item is ShortVideoModel) {
        item.fetchDetail();
        preCount++;
        if (preCount >= _preLoadDetailCount) {
          break;
        }
      }
    }
  }

  void onVisibleChange(bool pageVisible) {
    this.pageVisible = pageVisible;
    // 这里分为两种情况,
    // 1. 当本页面还在加载中就切走了，cell还未创建
    // 2. 当cell 已经加载完成了再切走
    // 所以 这里不直接使用 findCellController
    cellControllers[currentIndex]?.onPageVisibleChange(pageVisible);
  }

  void onPageIndexChanged(int index) {
    logger.d('onPageIndexChanged $index');
    deleteCellController(currentIndex);
    currentIndex = index;
    preLoadDetail(currentIndex);
    cellControllers[currentIndex]?.onPageIndexChange(currentIndex);
  }

  ShortVPCellController findCellController(int index) {
    return cellControllers.putIfAbsent(
      index,
      () => Get.find<ShortVPCellController>(tag: mode!.index.toString()),
    );
  }

  void deleteCellController(int index) {
    final c = cellControllers[index];
    if (c == null) return;
    Get.asap(() {
      c.onDelete();
      Get.log('"ShortVPCellController index:$index" onClose() called');
      Get.log('"ShortVPCellController index:$index" deleted from memory');
      cellControllers.remove(index);
    });
  }

  void _initAdInfo() {
    _adInterval = 0;
    _ad = null;
  }

  void _fetchLocalVideos(int page,
      {required List<VideoBaseModel> videos, required int idx}) {
    List<ShortVideoOrAdModel> items = [];
    int index = 0;
    if (_adInterval > 0 && _ad != null) {
      ///有广告
      videos.slices(_adInterval).forEach((s) {
        items.addAll(
          s.map((e) => ShortVideoModel(e, index: index++)),
        );
        if (s.length == _adInterval) {
          index++;
          items.add(_ad);
        }
      });
    } else {
      ///没广告
      items.addAll(
        videos.map((e) => ShortVideoModel(e, index: index++)),
      );
    }
    if (page == Consts.pageFirst) {
      preLoadDetail(0);
    }
    if (videos.isNotEmpty) {
      currentIndex = 0;
    }
    pagingController.appendLastPage(items);
  }

  Future<void> _fetchRemoteVideos(int page) async {
    List<VideoBaseModel>? resp;
    if (mode == ShortVideoPlayerMode.recommend) {
      ///推荐
      resp = await Api.fetchShortVideoRecommend(
        page: page,
        pageSize: _pageSize,
        refresh: page == Consts.pageFirst,
      );
    } else {
      ///关注
      resp = await Api.fetchShortVideoFocusList(
        page: page,
        pageSize: _pageSize,
      );
    }

    if (resp == null) {
      pagingController.error = 'error';
      return;
    }

    List<ShortVideoOrAdModel> items = [];
    final currentLength = pagingController.itemList?.length ?? 0;
    int index = currentLength;
    if (_adInterval > 0 && _ad != null) {
      // 补上一页
      final respCopy = [...resp];
      if (_lastPageRemainVideoCount > 0) {
        final lack = _adInterval - _lastPageRemainVideoCount;
        final realLack = lack > respCopy.length ? respCopy.length : lack;
        for (int i = 0; i < realLack; i++) {
          items.add(ShortVideoModel(resp[i], index: index++));
        }
        index++;
        items.add(_ad);
        respCopy.removeRange(0, realLack);
      }
      respCopy.slices(_adInterval).forEach((s) {
        items.addAll(
          s.mapIndexed(
            (i, e) => ShortVideoModel(s[i], index: index++),
          ),
        );
        if (s.length == _adInterval) {
          index++;
          items.add(_ad);
        } else {
          _lastPageRemainVideoCount = s.length;
        }
      });
    } else {
      items = resp.map((e) => ShortVideoModel(e, index: index++)).toList();
    }

    if (page == Consts.pageFirst) {
      if (items.isNotEmpty) {
        currentIndex = 0;
      }
      preLoadDetail(0);
    }
    if (resp.length < _pageSize) {
      pagingController.appendLastPage(items);
    } else {
      pagingController.appendPage(items, page + 1);
    }
  }

  /// 获取全部的线路
  Future _getAllLines() async {
    final rsp = await Api.fetchCdnLines();
    if (rsp != null) {
      cdnLines = rsp;
    }
  }

  @override
  void onInit() {
    _initAdInfo();

    pagingController.addStatusListener((status) {
      if (status == PagingStatus.loadingFirstPage) {
        currentIndex = -1;
        _deleteAllCellController();
      }
    });

    final localVideos = Utils.asType<List<VideoBaseModel>>(Get.arguments);
    var localVideoIdx = 0;
    if (Get.parameters.containsKey("idx")) {
      localVideoIdx =
          int.parse(Utils.asType<String>(Get.parameters['idx'] ?? '0') ?? '0');
    }
    if (localVideos != null) {
      int idx = localVideoIdx;
      if (idx < 0) {
        idx = 0;
      } else if (idx >= localVideos.length) {
        idx = localVideos.length - 1;
      }
      if (localVideos.isEmpty) {
        pageController = null;
      } else {
        pageController = PageController(initialPage: idx);
      }
      pagingController.addPageRequestListener(
        (page) =>
            _fetchLocalVideos(page, videos: localVideos, idx: localVideoIdx),
      );
    } else {
      pageController = null;
      pagingController.addPageRequestListener(_fetchRemoteVideos);
    }

    _getAllLines();
    super.onInit();
  }

  void _deleteAllCellController() {
    cellControllers.forEach((k, _) => deleteCellController(k));
  }

  @override
  void onClose() {
    _deleteAllCellController();
    pageController?.dispose();
    pagingController.dispose();

    super.onClose();
  }
}
