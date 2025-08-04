/*
 * @Author: david wumingshi555888@gmail.com
 * @Date: 2025-03-01 09:49:32
 * @LastEditors: david wumingshi555888@gmail.com
 * @LastEditTime: 2025-03-03 21:11:26
 * @FilePath: /xhs_app/lib/views/mine/mine_releases/community_collection_page.dart
 * @Description: 
 * Copyright (c) 2025 by ${git_name} email: ${git_email}, All Rights Reserved.
 */
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:xhs_app/components/app_bar/app_bar_view.dart';
import 'package:xhs_app/components/mine_community_cell/mine_collection_cell.dart';
import 'package:xhs_app/components/no_more/no_data.dart';
import 'package:xhs_app/utils/color.dart';
import 'package:xhs_app/utils/extension.dart';

import '../../../model/community/collection_base_model.dart';
import 'mine_release_collection_controller.dart';

class CommunityCollectionPage extends GetView<MineReleaseCollectionController> {
  const CommunityCollectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) {
        if (didPop) {
          return;
        }
        Get.back(result: controller.selectedCollection.value);
      },
      child: Scaffold(
        backgroundColor: COLOR.color_FAFAFA,
        appBar: AppBarView(
          titleText: "选择合集",
        ),
        body: EasyRefresh(
          refreshOnStart: true,
          controller: controller.refreshController,
          onRefresh: () {
            controller.onRefresh();
          },
          onLoad: () {
            controller.onLoad();
          },
          child: PagedListView<int, CollectionBaseModel>(
              padding: EdgeInsets.only(top: 10, left: 14.w, right: 14.w),
              addAutomaticKeepAlives: true,
              pagingController: controller.pagingControllers,
              builderDelegate: PagedChildBuilderDelegate<CollectionBaseModel>(
                firstPageProgressIndicatorBuilder: (context) =>
                    const SizedBox.shrink(),
                newPageProgressIndicatorBuilder: (context) =>
                    const SizedBox.shrink(),
                noMoreItemsIndicatorBuilder: (context) =>
                    const SizedBox.shrink(),
                noItemsFoundIndicatorBuilder: (context) => const NoData(),
                itemBuilder: (context, item, index) => Obx(
                  () => Container(
                    margin: EdgeInsets.only(bottom: 10.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.w),
                      border: Border.all(
                          color: controller.selectCollectionName.value ==
                                  item.collectionName
                              ? COLOR.hexColor("#fb2d45")
                              : COLOR.hexColor("#ffffff"),
                          width: 1),
                    ),
                    child: MineCollectionCell(
                      model: item,
                      from: 2,
                    ),
                  ).onOpaqueTap(() {
                    controller.selectCollectionName.value =
                        item.collectionName ?? "";
                    controller.selectedCollection.value = item;
                  }),
                ),
              )),
        ),
      ),
    );
  }
}
