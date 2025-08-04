/*
 * @Author: david wumingshi555888@gmail.com
 * @Date: 2025-02-26 13:07:48
 * @LastEditors: david wumingshi555888@gmail.com
 * @LastEditTime: 2025-03-03 15:50:42
 * @FilePath: /xhs_app/lib/views/mine/mine_releases/mine_release_collection_page.dart
 * @Description: 
 * Copyright (c) 2025 by ${git_name} email: ${git_email}, All Rights Reserved.
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_widget.dart';
import 'package:xhs_app/components/collection_cell/collection_cell.dart';
import 'package:xhs_app/components/diolog/dialog.dart';
import 'package:xhs_app/components/image_view.dart';
import 'package:xhs_app/components/text_view.dart';
import 'package:xhs_app/routes/routes.dart';
import 'package:xhs_app/utils/color.dart';
import 'package:xhs_app/utils/extension.dart';
import 'package:xhs_app/views/mine/mine_releases/mine_release_collection_controller.dart';

import '../../../../components/no_more/no_data.dart';
import '../../../components/easy_toast.dart';
import '../../../generate/app_image_path.dart';
import '../../../model/community/collection_base_model.dart';

// ignore: must_be_immutable
class MinesReleaseCollectionPage
    extends GetView<MineReleaseCollectionController> {
  final bool isManage; //是否管理页面
  MinesReleaseCollectionPage({super.key, this.isManage = false});
  RxBool isSelect = false.obs;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BaseRefreshWidget(
          controller,
          child: PagedListView<int, CollectionBaseModel>(
            padding: EdgeInsets.only(top: 10, left: 14.w, right: 0.w),
            addAutomaticKeepAlives: true,
            pagingController: controller.pagingControllers,
            builderDelegate: PagedChildBuilderDelegate<CollectionBaseModel>(
              firstPageProgressIndicatorBuilder: (context) =>
                  const SizedBox.shrink(),
              newPageProgressIndicatorBuilder: (context) =>
                  const SizedBox.shrink(),
              noMoreItemsIndicatorBuilder: (context) => const SizedBox.shrink(),
              noItemsFoundIndicatorBuilder: (context) => const NoData(),
              itemBuilder: (context, item, index) => Row(
                children: [
                  if (isManage)
                    Obx(() => ImageView(
                          src:
                              controller.selectedIds.contains(item.collectionId)
                                  ? AppImagePath.mine_icon_manage_on
                                  : AppImagePath.mine_icon_manage_off,
                          width: 20.w,
                          height: 20.w,
                        ).onOpaqueTap(() {
                          if (controller.selectedIds
                              .contains(item.collectionId)) {
                            controller.selectedIds.remove(item.collectionId);
                          } else {
                            if (controller.selectedIds.isEmpty) {
                              controller.selectedIds.value = [
                                item.collectionId!
                              ];
                            } else {
                              controller.selectedIds.add(item.collectionId!);
                            }
                          }
                        }).marginRight(10.w)),
                  CollectionCell(
                    model: item,
                    index: index,
                    isManage: isManage,
                  ).marginRight(isManage ? 0 : 14.w),
                ],
              ),
            ),
          ),
        ),
        if (!isManage)
          Positioned(
              bottom: 14.w + ScreenUtil().bottomBarHeight,
              left: 14.w,
              right: 14.w,
              child: Container(
                width: 332.w,
                height: 40.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    image: const DecorationImage(
                        image: AssetImage(AppImagePath.mine_big_button)),
                    borderRadius: BorderRadius.circular(10.w)),
                child: TextView(
                  text: "创建合集",
                  fontSize: 14.w,
                  color: COLOR.white,
                ),
              ).onTap(() {
                if (controller.userService.user.blogger == true) {
                  Get.toNamed(Routes.minescreatecollection);
                } else {
                  EasyToast.show('认证博主才能创建合集');
                }
              })),
        if (isManage == true &&
            controller.pagingControllers.itemList!.isNotEmpty)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              width: 360.w,
              height: 50.w + ScreenUtil().bottomBarHeight,
              padding: EdgeInsets.only(left: 14.w, right: 14.w, top: 7.w),
              color: COLOR.white,
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() => Row(
                        children: [
                          ImageView(
                            src: isSelect.value
                                ? AppImagePath.mine_icon_manage_off
                                : AppImagePath.mine_icon_manage_on,
                            width: 20.w,
                            height: 20.w,
                          ),
                          TextView(
                            text: isSelect.value ? "全不选" : "全选",
                            fontSize: 13.w,
                            fontWeight: FontWeight.w500,
                            color: COLOR.color_333333,
                          ).marginOnly(left: 5.w)
                        ],
                      ).onOpaqueTap(() {
                        if (isSelect.value) {
                          isSelect.value = false;
                          controller.selectedIds.clear();
                          controller.pagingControllers.itemList
                              ?.forEach((element) {
                            controller.selectedIds.add(element.collectionId!);
                          });
                        } else {
                          isSelect.value = true;
                          controller.pagingControllers.itemList
                              ?.forEach((element) {
                            controller.selectedIds.value = [];
                          });
                        }
                      })),
                  Row(
                    children: [
                      ImageView(
                        src: AppImagePath.mine_icon_manage_delete,
                        width: 70.w,
                        height: 36.w,
                      ).onOpaqueTap(() {
                        showAlertDialog(context,
                            title: "提示",
                            message: "确认要删除选中合集", onRightButton: () {
                          controller.delCollection(controller.selectedIds);
                        });
                      }),
                    ],
                  )
                ],
              ),
            ),
          ),
      ],
    );
  }
}
