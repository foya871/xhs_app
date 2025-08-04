/*
 * @Author: wangdazhuang
 * @Date: 2024-10-15 14:03:17
 * @LastEditTime: 2025-01-20 09:20:34
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /xhs_app/lib/views/videotag/short_tag_video_list.dart
 */
import 'package:easy_refresh/easy_refresh.dart';
import 'package:xhs_app/components/no_more/no_data_masonry_grid_view.dart';
import 'package:xhs_app/model/video_base_model.dart';
import 'package:xhs_app/routes/routes.dart';
import 'package:xhs_app/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/views/douyin/short_video_list_cell.dart';

import '../../http/service/api_service.dart';

class ShortTagVideoList extends StatefulWidget {
  final int sortType;
  final String tagsTitle;
  const ShortTagVideoList({
    super.key,
    required this.sortType,
    required this.tagsTitle,
  });

  @override
  State<ShortTagVideoList> createState() => _ShortTagVideoList();
}

class _ShortTagVideoList extends State<ShortTagVideoList> {
  final _pageSize = 20;
  int _page = 1;

  List<VideoBaseModel> videos = [];
  @override
  void initState() {
    super.initState();
  }

  Future<IndicatorResult> refreshAction() async {
    _page = 1;
    try {
      final items = await httpInstance.get<VideoBaseModel>(
          url: 'video/queryVideosByTag',
          queryMap: {
            'page': _page,
            'pageSize': _pageSize,
            //排序：1-最近更新 2-最多观看
            'sortType': widget.sortType,
            "tagsTitle": widget.tagsTitle,
            'videoMark': 2
          },
          complete: VideoBaseModel.fromJson);
      videos = items;
      if (mounted) {
        setState(() {});
      }
      return IndicatorResult.success;
    } catch (_) {
      return IndicatorResult.fail;
    }
  }

  Future<IndicatorResult> loadMoreAction() async {
    _page++;
    try {
      final items = await httpInstance.get<VideoBaseModel>(
          url: 'video/getBytagsTitle',
          queryMap: {
            'pageSize': _pageSize,
            'sortType': widget.sortType,
            "tagsTitle": widget.tagsTitle,
            'mark': 1,
            'page': _page,
            'videoMark': 2
          },
          complete: VideoBaseModel.fromJson);
      if (items != null && items is List && items.isNotEmpty) {
        videos.addAll(items as Iterable<VideoBaseModel>);
        if (mounted) {
          setState(() {});
        }
        return IndicatorResult.success;
      } else {
        return IndicatorResult.noMore;
      }
    } catch (_) {
      return IndicatorResult.fail;
    }
  }

  _buildShortList() {
    return NoDataMasonryGridView.count(
      crossAxisCount: 2,
      itemCount: videos.length,
      mainAxisSpacing: 8.w,
      crossAxisSpacing: 4.w,
      itemBuilder: (context, index) {
        final v = videos[index];
        final h = v.height! == 0 ? 273.w : v.height! / v.width! * 173.w;
        return ShortVideoListCell(
          width: 183.w,
          imageHeight: h,
          model: v,
        ).onTap(
          () {
            Get.toShortVideoPlay(videos, idx: index);
          },
        );
      },
    ).marginOnly(left: 14.w, right: 14.w);
  }

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      child: _buildShortList(),
      refreshOnStart: true,
      triggerAxis: Axis.vertical,
      onLoad: loadMoreAction,
      onRefresh: refreshAction,
    );
  }
}
