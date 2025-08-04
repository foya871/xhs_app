import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_widget.dart';
import 'package:xhs_app/components/collection_cell/collection_cell.dart';
import 'package:xhs_app/model/community/collection_base_model.dart';
import 'package:xhs_app/model/video_base_model.dart';
import 'package:xhs_app/routes/routes.dart';
import 'package:xhs_app/utils/extension.dart';
import 'package:xhs_app/views/mine/favorite/controllers/mine_favorite_brushvideo_controller.dart';
import 'package:xhs_app/views/mine/favorite/controllers/mine_favorite_collection_controller.dart';
import 'package:xhs_app/views/mine/favorite/controllers/mine_favorite_community_controller.dart';
import 'package:xhs_app/views/mine/favorite/controllers/mine_favorite_video_controller.dart';

import '../../../../components/no_more/no_data.dart';
import '../../../../components/short_widget/video_base_cell.dart';
import '../../../../model/blogger/blogger_video_collection.dart';
import '../../../../model/community/community_date_model.dart';
import '../../../douyin/short_video_list_cell.dart';

class MineFavoritePage extends StatelessWidget {
  final title;

  const MineFavoritePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    if (title == "视频") {
      final controller = Get.find<MineFavoriteVideoController>();
      return BaseRefreshWidget(
        controller,
        child: PagedGridView<int, VideoBaseModel>(
          padding: EdgeInsets.only(top: 10, left: 14.w, right: 14.w),
          addAutomaticKeepAlives: true,
          pagingController: controller.pagingControllers,
          builderDelegate: PagedChildBuilderDelegate<VideoBaseModel>(
            firstPageProgressIndicatorBuilder: (context) =>
                const SizedBox.shrink(),
            newPageProgressIndicatorBuilder: (context) =>
                const SizedBox.shrink(),
            noMoreItemsIndicatorBuilder: (context) => const SizedBox.shrink(),
            noItemsFoundIndicatorBuilder: (context) => const NoData(),
            itemBuilder: (context, item, index) =>
                VideoBaseCell.small(video: item),
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 10.w,
              crossAxisSpacing: 8.w,
              crossAxisCount: 2,
              childAspectRatio: 182 / 134),
        ),
      );
    }
    if (title == "刷片") {
      final controller = Get.find<MineFavoriteBrushVideoController>();
      return BaseRefreshWidget(
        controller,
        child: PagedGridView<int, VideoBaseModel>(
          padding: EdgeInsets.only(top: 10, left: 14.w, right: 14.w),
          addAutomaticKeepAlives: true,
          pagingController: controller.pagingControllers,
          builderDelegate: PagedChildBuilderDelegate<VideoBaseModel>(
            firstPageProgressIndicatorBuilder: (context) =>
                const SizedBox.shrink(),
            newPageProgressIndicatorBuilder: (context) =>
                const SizedBox.shrink(),
            noMoreItemsIndicatorBuilder: (context) => const SizedBox.shrink(),
            noItemsFoundIndicatorBuilder: (context) => const NoData(),
            itemBuilder: (context, item, index) => ShortVideoListCell(
              model: item,
              width: 182.w,
              titleColor: Colors.white,
            ).onTap(() => Get.toShortVideoPlay(controller.videos, idx: index)),
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 10.w,
              crossAxisSpacing: 8.w,
              crossAxisCount: 2,
              childAspectRatio: 182 / 300),
        ),
      );
    }
    if (title == "合集") {
      final controller = Get.find<MineFavoriteCollectionController>();
      return BaseRefreshWidget(
        controller,
        child: PagedGridView<int, CollectionBaseModel>(
          padding: EdgeInsets.only(top: 10, left: 14.w, right: 14.w),
          addAutomaticKeepAlives: true,
          pagingController: controller.pagingControllers,
          builderDelegate:
              PagedChildBuilderDelegate<CollectionBaseModel>(
            firstPageProgressIndicatorBuilder: (context) =>
                const SizedBox.shrink(),
            newPageProgressIndicatorBuilder: (context) =>
                const SizedBox.shrink(),
            noMoreItemsIndicatorBuilder: (context) => const SizedBox.shrink(),
            noItemsFoundIndicatorBuilder: (context) => const NoData(),
            itemBuilder: (context, item, index) =>
                CollectionCell(model: item, index: index),
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 10.w,
              crossAxisSpacing: 8.w,
              crossAxisCount: 2,
              childAspectRatio: 114 / 147),
        ),
      );
    }
    // if (title == "G圈") {
    //   final controller = Get.find<MineFavoriteCommunityController>();
    //   return BaseRefreshWidget(controller,
    //       child: PagedListView<int, CommunityDateModel>(
    //           padding: EdgeInsets.only(top: 10, left: 14.w, right: 14.w),
    //           addAutomaticKeepAlives: true,
    //           pagingController: controller.pagingControllers,
    //           builderDelegate: PagedChildBuilderDelegate<CommunityDateModel>(
    //               firstPageProgressIndicatorBuilder: (context) =>
    //                   const SizedBox.shrink(),
    //               newPageProgressIndicatorBuilder: (context) =>
    //                   const SizedBox.shrink(),
    //               noMoreItemsIndicatorBuilder: (context) =>
    //                   const SizedBox.shrink(),
    //               noItemsFoundIndicatorBuilder: (context) => const NoData(),
    //               itemBuilder: (context, item, index) =>
    //                   CommunityDateCell(data: item))));
    // }
    return Container();
  }
}
