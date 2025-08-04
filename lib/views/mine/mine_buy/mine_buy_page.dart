import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:xhs_app/components/adult_game_cell/adult_game_cell.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_widget.dart';
import 'package:xhs_app/model/product/product_model.dart';
import 'package:xhs_app/model/video_base_model.dart';
import 'package:xhs_app/views/mine/mine_buy/mine_buy_comunity_controller.dart';
import 'package:xhs_app/views/mine/mine_buy/mine_buy_video_controller.dart';

import '../../../../components/no_more/no_data.dart';
import '../../../../components/short_widget/video_base_cell.dart';
import '../../../components/mine_community_cell/mine_community_cell.dart';
import '../../../components/mine_product_cell/mine_product_cell.dart';
import '../../../model/adult_game_model/adult_game_model.dart';
import '../../../model/community/community_model.dart';
import '../../douyin/short_video_list_cell.dart';
import 'mine_buy_game_controller.dart';
import 'mine_buy_product_controller.dart';

class MinesBuyPage extends StatelessWidget {
  final title;

  const MinesBuyPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    if (title == "笔记") {
      final controller = Get.find<MineBuyCommunityController>();
      return BaseRefreshWidget(
        controller,
        child: PagedGridView<int, CommunityModel>(
          padding: EdgeInsets.only(top: 10, left: 14.w, right: 14.w),
          addAutomaticKeepAlives: true,
          pagingController: controller.pagingControllers,
          builderDelegate: PagedChildBuilderDelegate<CommunityModel>(
              firstPageProgressIndicatorBuilder: (context) =>
                  const SizedBox.shrink(),
              newPageProgressIndicatorBuilder: (context) =>
                  const SizedBox.shrink(),
              noMoreItemsIndicatorBuilder: (context) => const SizedBox.shrink(),
              noItemsFoundIndicatorBuilder: (context) => const NoData(),
              itemBuilder: (context, item, index) =>
                  MineCommunityCell(item: item)),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 10.w,
              crossAxisSpacing: 8.w,
              crossAxisCount: 2,
              childAspectRatio: 173 / 296),
        ),
      );
    }
    if (title == "热门短剧") {
      final controller = Get.find<MineBuyVideoController>();
      controller.videoMark = 2;
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
            itemBuilder: (context, item, index) => VideoBaseCell.bigVertical(
              video: item,
            ),
            // itemBuilder: (context, item, index) => ShortVideoListCell(
            //   model: item,
            //   width: 182.w,
            //   titleColor: Colors.white,
            // ),
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 10.w,
              crossAxisSpacing: 8.w,
              crossAxisCount: 2,
              childAspectRatio: 182 / 300),
        ),
      );
    }
    if (title == "禁播奇案") {
      final controller = Get.find<MineBuyVideoController>();
      controller.videoMark = 3;
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
    if (title == "商品") {
      final controller = Get.find<MineBuyProductController>();
      return BaseRefreshWidget(
        controller,
        child: PagedGridView<int, ProductModel>(
          padding: EdgeInsets.only(top: 10, left: 14.w, right: 14.w),
          addAutomaticKeepAlives: true,
          pagingController: controller.pagingControllers,
          builderDelegate: PagedChildBuilderDelegate<ProductModel>(
              firstPageProgressIndicatorBuilder: (context) =>
                  const SizedBox.shrink(),
              newPageProgressIndicatorBuilder: (context) =>
                  const SizedBox.shrink(),
              noMoreItemsIndicatorBuilder: (context) => const SizedBox.shrink(),
              noItemsFoundIndicatorBuilder: (context) => const NoData(),
              itemBuilder: (context, item, index) => MineProductCell(
                    item: item,
                  )),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 10.w,
              crossAxisSpacing: 8.w,
              crossAxisCount: 2,
              childAspectRatio: 173 / 316),
        ),
      );
    }
    if (title == "游戏") {
      final controller = Get.find<MineBuyGameController>();
      return BaseRefreshWidget(controller,
          child: PagedGridView<int, AdultGameModel>(
            padding: EdgeInsets.only(top: 10, left: 14.w, right: 14.w),
            addAutomaticKeepAlives: true,
            pagingController: controller.pagingControllers,
            builderDelegate: PagedChildBuilderDelegate<AdultGameModel>(
              firstPageProgressIndicatorBuilder: (context) =>
                  const SizedBox.shrink(),
              newPageProgressIndicatorBuilder: (context) =>
                  const SizedBox.shrink(),
              noMoreItemsIndicatorBuilder: (context) => const SizedBox.shrink(),
              noItemsFoundIndicatorBuilder: (context) => const NoData(),
              itemBuilder: (context, item, index) => AdultGameCell(game: item),
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 10.w,
                crossAxisSpacing: 8.w,
                crossAxisCount: 2,
                childAspectRatio: 162 / 116),
          ));
    }
    return Container();
  }
}
