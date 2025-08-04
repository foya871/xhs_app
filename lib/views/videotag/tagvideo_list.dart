/*
 * @Author: ziqi jhzq12345678
 * @Date: 2025-01-07 10:06:11
 * @LastEditors: ziqi jhzq12345678
 * @LastEditTime: 2025-01-17 14:44:14
 * @FilePath: /xhs_app/lib/views/videotag/tagvideo_list.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:xhs_app/components/keep_alive_wrapper.dart';
import 'package:xhs_app/components/no_more/no_data.dart';
import 'package:xhs_app/components/no_more/no_more.dart';
import 'package:xhs_app/components/short_widget/video_base_cell.dart';
import 'package:xhs_app/http/service/api_service.dart';
import 'package:xhs_app/model/video_base_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class TagvideoList extends StatefulWidget {
  final int sortType;
  final String tagsTitle;
  final int videoMark;

  const TagvideoList({
    super.key,
    required this.sortType,
    required this.tagsTitle,
    required this.videoMark,
  });

  @override
  State<TagvideoList> createState() => _TagvideoList();
}

class _TagvideoList extends State<TagvideoList> {
  final _pageSize = 40;
  final PagingController<int, VideoBaseModel> _pagingController =
      PagingController(firstPageKey: 1);
  Future _initListData(int pageKey) async {
    final videos = await httpInstance.get<VideoBaseModel>(
        url: 'video/queryVideosByTag',
        queryMap: {
          'pageSize': _pageSize,
          'sortType': widget.sortType,
          "tagsTitle": widget.tagsTitle,
          'page': pageKey,
          'videoMark': widget.videoMark
        },
        complete: VideoBaseModel.fromJson);
    final isLastPage = videos.length < _pageSize;
    if (isLastPage) {
      _pagingController.appendLastPage(videos);
    } else {
      final nextPageKey = pageKey + 1;
      _pagingController.appendPage(videos, nextPageKey as int?);
    }
  }

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _initListData(pageKey);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return KeepAliveWrapper(
      child: RefreshIndicator(
        onRefresh: () => Future.sync(
          () => _pagingController.refresh(),
        ),
        child: PagedGridView(
          showNewPageProgressIndicatorAsGridChild: false,
          showNewPageErrorIndicatorAsGridChild: false,
          showNoMoreItemsIndicatorAsGridChild: false,
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 20.w),
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<VideoBaseModel>(
              noMoreItemsIndicatorBuilder: (_) {
            return const NoMore();
          }, noItemsFoundIndicatorBuilder: (_) {
            return const NoData();
          }, itemBuilder: (context, value, index) {
            return VideoBaseCell.small(video: value);
          }),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 9.w,
              crossAxisSpacing: 8.w,
              crossAxisCount: 2,
              childAspectRatio: 182 / 134),
        ),
      ),
    );
  }
}
