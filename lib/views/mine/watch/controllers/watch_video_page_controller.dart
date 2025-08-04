/*
 * @Author: wangdazhuang
 * @Date: 2024-09-23 14:09:31
 * @LastEditTime: 2024-10-15 11:28:53
 * @LastEditors: wangdazhuang
 * @Description: 

 * @FilePath: /xhs_app/lib/src/views/mine/watch/controllers/watch_video_page_controller.dart
 */
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_controller.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_page_counter.dart';
import 'package:xhs_app/http/service/api_service.dart';
import 'package:xhs_app/model/comics/comics_base.dart';
import 'package:xhs_app/model/community/community_model.dart';
import 'package:xhs_app/model/video_base_model.dart';

class WatchVideoPageController extends BaseRefreshController
    with BaseRefreshPageCounter, GetSingleTickerProviderStateMixin {
  final tabs = ["视频", "帖子", "抖阴", "漫画", "小说"];

  late TabController tabController;
  int index = 0;
  RxList<VideoBaseModel> longVideos = <VideoBaseModel>[].obs; //视频
  RxList<CommunityModel> communitys = <CommunityModel>[].obs; //视频
  RxList<VideoBaseModel> shorts = <VideoBaseModel>[].obs; //斗阴
  RxList<ComicsBaseModel> comics = <ComicsBaseModel>[].obs; //漫画

  @override
  void onInit() {
    tabController = TabController(length: tabs.length, vsync: this);
    super.onInit();
    initDatas();
  }

  initDatas() {
    getWatchRecordVideo(videoMark: 1);
    getWatchRecordDynamics();
    getWatchRecordVideo(videoMark: 2);
    getWatchRecordComics();
    // getWatchRecordNovel();
  }

  @override
  Future<IndicatorResult> onRefresh() async {
    switch (tabController.index) {
      case 0: //视频
        return await getWatchRecordVideo(videoMark: 1);
      case 1: //帖子
        return await getWatchRecordDynamics();
      case 2: //斗阴
        return await getWatchRecordVideo(videoMark: 2);
      case 3: //漫画
        return await getWatchRecordComics();
      case 4: //小说
        return await getWatchRecordNovel();
      default:
        break;
    }
    return IndicatorResult.success;
  }

  ///获取视频接口(1：视频 2：斗阴)
  Future<IndicatorResult> getWatchRecordVideo({required int videoMark}) async {
    try {
      final response = await httpInstance.get(
        url: "video/getBrowseRecord",
        queryMap: {
          "videoMark": videoMark,
        },
        complete: VideoBaseModel.fromJson,
      );
      if (response != null) {
        if (videoMark == 1) {
          longVideos.assignAll(response);
        } else {
          shorts.assignAll(response);
        }
        return IndicatorResult.success;
      } else {
        return IndicatorResult.noMore;
      }
    } catch (_) {
      return IndicatorResult.fail;
    }
  }

  ///获取帖子
  Future getWatchRecordDynamics() async {
    try {
      final response = await httpInstance.get(
        url: "user/getUserWatchRecordList",
        queryMap: {
          "searchType": 2,
          "page": 1,
          "pageSize": 100,
        },
        complete: CommunityModel.fromJson,
      );
      if (response != null) {
        communitys.assignAll(response);
        return IndicatorResult.success;
      } else {
        return IndicatorResult.noMore;
      }
    } catch (_) {
      return IndicatorResult.fail;
    }
  }

  ///获取漫画浏览记录
  Future getWatchRecordComics() async {
    try {
      final response = await httpInstance.get(
        url: "comics/base/getBrowseRecord",
        queryMap: {
          "page": 1,
          "pageSize": 100,
        },
        complete: ComicsBaseModel.fromJson,
      );
      if (response != null) {
        comics.assignAll(response);
        return IndicatorResult.success;
      } else {
        return IndicatorResult.noMore;
      }
    } catch (_) {
      return IndicatorResult.fail;
    }
  }

  ///获取漫画浏览记录
  Future getWatchRecordNovel() async {
    try {
      final response = await httpInstance.get(
        url: "fiction/base/getBrowseRecord",
      );
      if (response != null) {
        return IndicatorResult.success;
      } else {
        return IndicatorResult.noMore;
      }
    } catch (_) {
      return IndicatorResult.fail;
    }
  }

  //删除当前的观看记录
  void clearList() {
    switch (tabController.index) {
      case 0: //视频
        deleteVideo(videoMark: 1);
        break;
      case 1: //帖子
        deleteDynamics();
        break;
      case 2: //斗阴
        deleteVideo(videoMark: 2);
        break;
      case 3: //漫画
        deleteComics();
        break;
      case 4: //小说
        deleteNovel();
        break;
      default:
        break;
    }
  }

  //删除视频记录(1：视频 2：斗阴)
  Future deleteVideo({required int videoMark}) async {
    SmartDialog.showLoading(msg: "删除中...", alignment: Alignment.center);
    try {
      await httpInstance.post(
        url: "video/delAllBrowseHistory",
        body: {"videoMark": videoMark},
      );
      SmartDialog.dismiss();
      SmartDialog.showToast("清空成功!", alignment: Alignment.center);
      getWatchRecordVideo(videoMark: videoMark);
    } catch (_) {
      SmartDialog.dismiss();
    }
  }

//删除帖子记录
  Future deleteDynamics() async {
    SmartDialog.showLoading(msg: "删除中...", alignment: Alignment.center);
    try {
      await httpInstance.post(
        url: "community/dynamic/clearBrowseHistory",
      );
      SmartDialog.dismiss();
      SmartDialog.showToast("清空成功!", alignment: Alignment.center);
      getWatchRecordDynamics();
    } catch (_) {
      SmartDialog.dismiss();
    }
  }

  //删除漫画记录
  Future deleteComics() async {
    SmartDialog.showLoading(msg: "删除中...", alignment: Alignment.center);
    try {
      await httpInstance.post(
        url: "comics/base/cancelBrowseRecord",
      );
      SmartDialog.dismiss();
      SmartDialog.showToast("清空成功!", alignment: Alignment.center);
      getWatchRecordComics();
    } catch (_) {
      SmartDialog.dismiss();
    }
  }

  //删除小说记录
  Future deleteNovel() async {
    SmartDialog.showLoading(msg: "删除中...", alignment: Alignment.center);
    try {
      await httpInstance.post(
        url: "fiction/base/clearBrowseRecord",
      );
      SmartDialog.dismiss();
      SmartDialog.showToast("清空成功!", alignment: Alignment.center);
      getWatchRecordNovel();
    } catch (_) {
      SmartDialog.dismiss();
    }
  }
}
