import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_controller.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_page_counter.dart';
import 'package:xhs_app/http/api/api.dart';
import 'package:xhs_app/model/mine/publications_videos_model.dart';
import 'package:xhs_app/model/video_base_model.dart';
import 'package:xhs_app/services/user_service.dart';
import 'package:xhs_app/utils/logger.dart';

enum VideoStatus { published, underReview, rejected }

class DyPageController extends BaseRefreshController
    with BaseRefreshPageCounter, GetSingleTickerProviderStateMixin {
  final UserService service = Get.find<UserService>();
  late TabController tabController;

  final List<Tab> tabs = const [
    Tab(text: '已发布'),
    Tab(text: '审核中'),
    Tab(text: '未通过'),
  ];

  RxList<VideoBaseModel> publications = <VideoBaseModel>[].obs;
  RxList<VideoBaseModel> underReviews = <VideoBaseModel>[].obs;
  RxList<VideoBaseModel> rejecteds = <VideoBaseModel>[].obs;

  int pageIndexPublication = 1;
  int pageIndexUnderReview = 1;
  int pageIndexRejected = 1;

  @override
  void onInit() {
    super.onInit();
    tabController =
        TabController(length: tabs.length, vsync: this, initialIndex: 0);
    initHttpDatas();
  }

  void initHttpDatas() {
    for (int i = 0; i < tabs.length; i++) {
      getPublicationsVideosList(isRefresh: true, currentTabIndex: i);
    }
  }

  @override
  Future<IndicatorResult> onRefresh() async {
    int currentTabIndex = tabController.index;
    return await getPublicationsVideosList(
        isRefresh: true, currentTabIndex: currentTabIndex);
  }

  @override
  Future<IndicatorResult> onLoad() async {
    int currentTabIndex = tabController.index;
    return await getPublicationsVideosList(
        isRefresh: false, currentTabIndex: currentTabIndex);
  }

  Future<IndicatorResult> getPublicationsVideosList({
    required bool isRefresh,
    required int currentTabIndex,
  }) async {
    try {
      VideoStatus status = VideoStatus.values[currentTabIndex];
      if (isRefresh) {
        resetPageIndex(status);
      } else {
        incrementPageIndex(status);
      }

      // final response = await Api.getPublicationsVideosList(
      //   userId: service.user.userId ?? 0,
      //   // videoMark: 2,
      //   // videoStatus: _getVideoStatus(status),
      //   page: _getCurrentPageIndex(status),
      // );
      // if (response != null) {
      //   _updatePublicationsList(status, response, isRefresh);
      // }
      return IndicatorResult.success;
    } catch (e) {
      logger.e("Error fetching publications: $e");
      return IndicatorResult.fail;
    }
  }

  void resetPageIndex(VideoStatus status) {
    switch (status) {
      case VideoStatus.published:
        pageIndexPublication = 1;
        break;
      case VideoStatus.underReview:
        pageIndexUnderReview = 1;
        break;
      case VideoStatus.rejected:
        pageIndexRejected = 1;
        break;
    }
  }

  void incrementPageIndex(VideoStatus status) {
    switch (status) {
      case VideoStatus.published:
        pageIndexPublication++;
        break;
      case VideoStatus.underReview:
        pageIndexUnderReview++;
        break;
      case VideoStatus.rejected:
        pageIndexRejected++;
        break;
    }
  }

  int _getVideoStatus(VideoStatus status) {
    switch (status) {
      case VideoStatus.published:
        return 2; // 已发布
      case VideoStatus.underReview:
        return 1; // 审核中
      case VideoStatus.rejected:
        return 3; // 未通过
    }
  }

  int _getCurrentPageIndex(VideoStatus status) {
    switch (status) {
      case VideoStatus.published:
        return pageIndexPublication;
      case VideoStatus.underReview:
        return pageIndexUnderReview;
      case VideoStatus.rejected:
        return pageIndexRejected;
    }
  }

  void _updatePublicationsList(
      VideoStatus status, List<VideoBaseModel> response, bool isRefresh) {
    switch (status) {
      case VideoStatus.published:
        if (isRefresh) {
          publications.assignAll(response);
        } else {
          publications.addAll(response);
        }
        break;
      case VideoStatus.underReview:
        if (isRefresh) {
          underReviews.assignAll(response);
        } else {
          underReviews.addAll(response);
        }
        break;
      case VideoStatus.rejected:
        if (isRefresh) {
          rejecteds.assignAll(response);
        } else {
          rejecteds.addAll(response);
        }
        break;
    }
  }
}
