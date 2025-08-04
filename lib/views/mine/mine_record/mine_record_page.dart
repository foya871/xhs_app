import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_widget.dart';
import 'package:xhs_app/components/comics_cell/comics_cell.dart';
import 'package:xhs_app/components/connotation_cell/connotation_cell.dart';
import 'package:xhs_app/components/fiction_cell/fiction_cell.dart';
import 'package:xhs_app/components/mine_community_cell/mine_community_cell.dart';
import 'package:xhs_app/components/no_more/no_data.dart';
import 'package:xhs_app/components/portray_cell/portray_cell.dart';
import 'package:xhs_app/model/community/community_model.dart';
import 'package:xhs_app/model/fiction/fiction_base_model.dart';
import 'package:xhs_app/model/product/product_model.dart';
import 'package:xhs_app/model/video_base_model.dart';
import 'package:xhs_app/views/mine/mine_record/mine_record_community_controller.dart';
import 'package:xhs_app/views/mine/mine_record/mine_record_connotation_controller.dart';
import 'package:xhs_app/views/mine/mine_record/mine_record_product_controller.dart';
import 'package:xhs_app/views/mine/mine_record/mine_record_video_controller.dart';

import '../../../components/adult_game_cell/adult_game_cell.dart';
import '../../../components/mine_product_cell/mine_product_cell.dart';
import '../../../components/picture_cell/picture_cell.dart';
import '../../../components/short_widget/video_base_cell.dart';
import '../../../model/adult_game_model/adult_game_model.dart';
import '../../../model/comics/comics_base.dart';
import '../../../model/connotation/connotation_model.dart';
import '../../../model/picture_cell_model/picture_cell_model.dart';
import 'mine_record_comics_controller.dart';
import 'mine_record_fiction_controllder.dart';
import 'mine_record_game_controll.dart';
import 'mine_record_picture_controller.dart';

class MineRecordPage extends StatelessWidget {
  final title;

  const MineRecordPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    if (title == "笔记") {
      final controller = Get.find<MineRecordCommunityController>();
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
    if (title == "漫画") {
      final controller = Get.find<MineRecordComicsController>();
      return BaseRefreshWidget(
        controller,
        child: PagedGridView<int, ComicsBaseModel>(
          padding: EdgeInsets.only(top: 10, left: 14.w, right: 14.w),
          addAutomaticKeepAlives: true,
          pagingController: controller.pagingControllers,
          builderDelegate: PagedChildBuilderDelegate<ComicsBaseModel>(
            firstPageProgressIndicatorBuilder: (context) =>
                const SizedBox.shrink(),
            newPageProgressIndicatorBuilder: (context) =>
                const SizedBox.shrink(),
            noMoreItemsIndicatorBuilder: (context) => const SizedBox.shrink(),
            noItemsFoundIndicatorBuilder: (context) => const NoData(),
            itemBuilder: (context, item, index) => ComicsCell(model: item),
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 10.w,
              crossAxisSpacing: 8.w,
              crossAxisCount: 3,
              childAspectRatio: 130 / 220),
        ),
      );
    }
    if (title == "小说") {
      final controller = Get.find<MineRecordFictionController>();
      return BaseRefreshWidget(
        controller,
        child: PagedGridView<int, FictionBase>(
          padding: EdgeInsets.only(top: 10, left: 14.w, right: 14.w),
          addAutomaticKeepAlives: true,
          pagingController: controller.pagingControllers,
          builderDelegate: PagedChildBuilderDelegate<FictionBase>(
            firstPageProgressIndicatorBuilder: (context) =>
                const SizedBox.shrink(),
            newPageProgressIndicatorBuilder: (context) =>
                const SizedBox.shrink(),
            noMoreItemsIndicatorBuilder: (context) => const SizedBox.shrink(),
            noItemsFoundIndicatorBuilder: (context) => const NoData(),
            itemBuilder: (context, item, index) => FictionCell(model: item),
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 10.w,
              crossAxisSpacing: 8.w,
              crossAxisCount: 3,
              childAspectRatio: 140 / 280),
        ),
      );
    }
    if (title == "写真") {
      final controller = Get.find<MineRecordPictureController>();
      return BaseRefreshWidget(
        controller,
        child: PagedGridView<int, PictureCellModel>(
          padding: EdgeInsets.only(top: 10, left: 14.w, right: 14.w),
          addAutomaticKeepAlives: true,
          pagingController: controller.pagingControllers,
          builderDelegate: PagedChildBuilderDelegate<PictureCellModel>(
              firstPageProgressIndicatorBuilder: (context) =>
                  const SizedBox.shrink(),
              newPageProgressIndicatorBuilder: (context) =>
                  const SizedBox.shrink(),
              noMoreItemsIndicatorBuilder: (context) => const SizedBox.shrink(),
              noItemsFoundIndicatorBuilder: (context) => const NoData(),
              itemBuilder: (context, item, index) {
                return PortrayCell(item: item);
              }),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 10.w,
              crossAxisSpacing: 8.w,
              crossAxisCount: 3,
              childAspectRatio: 140 / 280),
        ),
      );
    }
    if (title == "内涵图") {
      final controller = Get.find<MineRecordConnotationController>();
      return BaseRefreshWidget(
        controller,
        child: PagedListView<int, ConnotationModel>(
          padding: EdgeInsets.only(top: 10, left: 14.w, right: 14.w),
          addAutomaticKeepAlives: true,
          pagingController: controller.pagingControllers,
          builderDelegate: PagedChildBuilderDelegate<ConnotationModel>(
              firstPageProgressIndicatorBuilder: (context) =>
                  const SizedBox.shrink(),
              newPageProgressIndicatorBuilder: (context) =>
                  const SizedBox.shrink(),
              noMoreItemsIndicatorBuilder: (context) => const SizedBox.shrink(),
              noItemsFoundIndicatorBuilder: (context) => const NoData(),
              itemBuilder: (context, item, index) {
                return ConnotationCell(item: item);
              }),
        ),
      );
    }
    if (title == "热门短剧") {
      final controller = Get.find<MineRecordVideoController>(tag: "2");
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
              itemBuilder: (context, item, index) {
                return VideoBaseCell.bigVertical(video: item);
              }),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 10.w,
              crossAxisSpacing: 8.w,
              crossAxisCount: 2,
              childAspectRatio: 120 / 202),
        ),
      );
    }
    if (title == "禁播奇案") {
      final controller = Get.find<MineRecordVideoController>(tag: "3");

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
              itemBuilder: (context, item, index) {
                return VideoBaseCell.small(video: item);
              }),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 10.w,
              crossAxisSpacing: 8.w,
              crossAxisCount: 2,
              childAspectRatio: 162 / 130),
        ),
      );
    }
    if (title == "商品") {
      final controller = Get.find<MineRecordProductController>();
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
              itemBuilder: (context, item, index) {
                return MineProductCell(item: item);
              }),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 10.w,
              crossAxisSpacing: 8.w,
              crossAxisCount: 2,
              childAspectRatio: 173 / 310),
        ),
      );
    }
    if (title == "游戏") {
      final controller = Get.find<MineRecordGameController>();
      return BaseRefreshWidget(
        controller,
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
              itemBuilder: (context, item, index) {
                return AdultGameCell(game: item);
              }),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 8.w,
              crossAxisSpacing: 8.w,
              crossAxisCount: 2,
              childAspectRatio: 162 / 116),
        ),
      );
    }
    return Container();
  }
}
