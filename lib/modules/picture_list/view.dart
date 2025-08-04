import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:xhs_app/components/no_more/no_data.dart';
import 'package:xhs_app/components/no_more/no_more.dart';
import 'package:xhs_app/components/picture_cell/picture_cell.dart';
import 'package:xhs_app/model/picture_cell_model/picture_cell_model.dart';

import 'controller.dart';

class PictureListView extends StatefulWidget {
  const PictureListView({
    super.key,
  });

  @override
  State<PictureListView> createState() => _PictureListViewState();
}

class _PictureListViewState extends State<PictureListView> {
  final PictureListController controller = Get.put(PictureListController());

  @override
  void initState() {
    super.initState();
    controller.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PictureListController>(
      init: controller,
      builder: (controller) {
        return EasyRefresh(
          onRefresh: () async {
            controller.pagingController.refresh();
          },

          controller: controller.refreshController,
          child: PagedMasonryGridView<int, PictureCellModel>(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            mainAxisSpacing: 10.w,
            crossAxisSpacing: 6.w,
            showNewPageProgressIndicatorAsGridChild: false,
            showNewPageErrorIndicatorAsGridChild: false,
            showNoMoreItemsIndicatorAsGridChild: false,
            pagingController: controller.pagingController,
            builderDelegate: PagedChildBuilderDelegate<PictureCellModel>(
              itemBuilder: (context, item, index) => PictureCell(picture: item),
              noMoreItemsIndicatorBuilder: (context) {
                return const NoMore();
              },
              noItemsFoundIndicatorBuilder: (context) {
                return const NoData();
              },
            ),
            gridDelegateBuilder: (int childCount) {
              return const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2);
            },
          ),
          // child: const NoData()
          // child: controller.pictureList.isEmpty
          //     ? const NoData()
          // : MasonryGridView.builder(
          //     gridDelegate:
          //         const SliverSimpleGridDelegateWithFixedCrossAxisCount(
          //       crossAxisCount: 2,
          //     ),
          //     padding: const EdgeInsets.symmetric(horizontal: 14),
          //     mainAxisSpacing: 10.w,
          //     crossAxisSpacing: 6.w,
          //     itemCount: controller.pictureList.length,
          //     shrinkWrap: true,
          //     itemBuilder: (BuildContext context, int index) {
          //       return PictureCell(
          //           picture: controller.pictureList[index]);
          //     },
          //   )
          // .marginOnly(top: 0.w),
        );
      },
    );
  }
}
