/*
 * @Author: ziqi jhzq12345678
 * @Date: 2024-10-22 09:35:02
 * @LastEditors: ziqi jhzq12345678
 * @LastEditTime: 2024-10-22 09:36:35
 * @FilePath: /xhs_app/lib/src/views/video_collect/collectvideo_list.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:xhs_app/components/keep_alive_wrapper.dart';
import 'package:xhs_app/components/no_more/no_data.dart';
import 'package:xhs_app/components/no_more/no_more.dart';
import 'package:xhs_app/components/back_to_top/floating_back_to_top_scaffold.dart';
import 'package:xhs_app/components/short_widget/video_base_cell.dart';
import 'package:xhs_app/http/service/api_service.dart';
import 'package:xhs_app/model/video_base_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class CollectvideoList extends StatefulWidget {
  final int sortType;
  final int collectionId;

  const CollectvideoList({
    super.key,
    required this.sortType,
    required this.collectionId,
  });

  @override
  State<CollectvideoList> createState() => _TagvideoList();
}

class _TagvideoList extends State<CollectvideoList> {
  final scrollController = ScrollController();
  final _pageSize = 20;
  final PagingController<int, VideoBaseModel> _pagingController =
      PagingController(firstPageKey: 1);
  Future _initListData(int pageKey) async {
    final videos = await httpInstance.get<VideoBaseModel>(
        url: '/video/getByCollection',
        queryMap: {
          'pageSize': _pageSize,
          'sortType': widget.sortType,
          'collectionId': widget.collectionId,
          'page': pageKey,
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
  void dispose() {
    scrollController.dispose();
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeepAliveWrapper(
      child: FloatingBackToTopScaffold(
        scrollController: scrollController,
        body: RefreshIndicator(
          onRefresh: () => Future.sync(
            () => _pagingController.refresh(),
          ),
          child: PagedGridView(
            scrollController: scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            showNewPageProgressIndicatorAsGridChild: false,
            showNewPageErrorIndicatorAsGridChild: false,
            showNoMoreItemsIndicatorAsGridChild: false,
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.w),
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
                mainAxisSpacing: 14.w,
                crossAxisSpacing: 8.w,
                crossAxisCount: 2,
                childAspectRatio: 182 / 146),
          ),
        ),
      ),
    );
  }
}
