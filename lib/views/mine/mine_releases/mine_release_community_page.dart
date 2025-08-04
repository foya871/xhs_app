import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:xhs_app/components/diolog/dialog.dart';
import 'package:xhs_app/components/easy_toast.dart';
import 'package:xhs_app/components/image_view.dart';
import 'package:xhs_app/components/mine_community_cell/mine_community_cell.dart';
import 'package:xhs_app/components/text_view.dart';
import 'package:xhs_app/generate/app_image_path.dart';
import 'package:xhs_app/model/community/community_model.dart';
import 'package:xhs_app/utils/color.dart';
import 'package:xhs_app/utils/extension.dart';
import 'package:xhs_app/views/mine/mine_releases/mine_release_community_controller.dart';

import '../../../../components/no_more/no_data.dart';
import '../../../assets/styles.dart';

// ignore: must_be_immutable
class MinesReleaseCommunityPage
    extends GetView<MineReleaseCommunityController> {
  final String text;
  final bool isManage; //是否管理页面
  MinesReleaseCommunityPage(
      {super.key, required this.text, this.isManage = false});
  RxBool isSelect = false.obs;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        EasyRefresh(
          refreshOnStart: true,
          controller: controller.refreshController,
          onRefresh: () {
            int status = 2;
            switch (text) {
              case '全部':
                status = 2;
                break;
              case '审核中':
                status = 1;
                break;
              case '审核失败':
                status = 3;
                break;
              case '粉丝专属':
                status = 2;
                controller.exclusiveToFans = true.obs;
                break;
            }
            controller.onRefresh(status);
          },
          onLoad: () {
            controller.onLoad();
          },
          child: PagedGridView<int, CommunityModel>(
            padding: EdgeInsets.only(top: 10, left: 14.w, right: 14.w),
            addAutomaticKeepAlives: true,
            pagingController: controller.pagingControllers,
            builderDelegate: PagedChildBuilderDelegate<CommunityModel>(
                firstPageProgressIndicatorBuilder: (context) =>
                    const SizedBox.shrink(),
                newPageProgressIndicatorBuilder: (context) =>
                    const SizedBox.shrink(),
                noMoreItemsIndicatorBuilder: (context) =>
                    const SizedBox.shrink(),
                noItemsFoundIndicatorBuilder: (context) => const NoData(),
                itemBuilder: (context, item, index) => Stack(
                      children: [
                        MineCommunityCell(item: item),
                        if (isManage == true)
                          Positioned(
                            left: 10.w,
                            top: 10.w,
                            child: ImageView(
                              src: item.isSelected == true
                                  ? AppImagePath.mine_icon_manage_on
                                  : AppImagePath.mine_icon_manage_white_on,
                              width: 20.w,
                              height: 20.w,
                            ),
                          )
                      ],
                    ).onOpaqueTap(() {
                      if (isManage) {
                        controller.onclickItem(index, item);
                      }
                    })),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 10.w,
                crossAxisSpacing: 8.w,
                crossAxisCount: 2,
                childAspectRatio: 173 / 296),
          ),
        ),
        if (text == "全部" &&
            isManage == true &&
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
                            text: isSelect.value ? "全选" : "全不选",
                            fontSize: 13.w,
                            fontWeight: FontWeight.w500,
                            color: COLOR.color_333333,
                          ).marginOnly(left: 5.w)
                        ],
                      ).onOpaqueTap(() {
                        if (isSelect.value) {
                          isSelect.value = false;
                          controller.pagingControllers.itemList
                              ?.forEach((element) {
                            element.isSelected = true;
                          });
                        } else {
                          isSelect.value = true;
                          controller.pagingControllers.itemList
                              ?.forEach((element) {
                            element.isSelected = false;
                          });
                        }
                        controller.pagingControllers.notifyListeners();
                      })),
                  Row(
                    children: [
                      ImageView(
                        src: AppImagePath.mine_icon_manage_collection,
                        width: 84.w,
                        height: 36.w,
                      ).marginOnly(right: 10.w).onOpaqueTap(() {
                        showAlertDialog(context,
                            title: "提示",
                            message: "确定将选中笔记设置为合集", onRightButton: () async {
                          if (controller.collectionItems.isEmpty) {
                            EasyToast.show(
                              "暂无合集,请创建",
                            );
                            return;
                          }
                          double height = 200.w;

                          height = height +
                              82.w * (controller.collectionItems.length);
                          int selectIndex = 0;
                          await Get.bottomSheet(
                            StatefulBuilder(builder: (context, setState) {
                              return Container(
                                width: double.infinity,
                                height: height,
                                decoration: BoxDecoration(
                                  color: COLOR.color_F8F8F8,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12.w),
                                    topRight: Radius.circular(12.w),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.only(
                                              top: 12.w, bottom: 21.w),
                                          alignment: Alignment.center,
                                          child: TextView(
                                            text: "选择移动合集",
                                            fontSize: 16.w,
                                            fontWeight: FontWeight.w600,
                                            color: COLOR.color_333333,
                                          ),
                                        ),
                                        Positioned(
                                            right: 15.w,
                                            top: 15.w,
                                            child: ImageView(
                                              src: AppImagePath.icons_close,
                                              width: 14.w,
                                              height: 14.w,
                                            ).onOpaqueTap(() {
                                              Get.back();
                                            }))
                                      ],
                                    ),
                                    Expanded(
                                        child: ListView.builder(
                                            padding: EdgeInsets.only(
                                                left: 14.w,
                                                right: 14.w,
                                                bottom: 24.w),
                                            itemCount: controller
                                                .collectionItems.length,
                                            itemBuilder: (context, index) {
                                              var model = controller
                                                  .collectionItems[index];
                                              return Container(
                                                  width: 332.w,
                                                  height: 72.w,
                                                  padding: EdgeInsets.only(
                                                      left: 8.w, right: 8.w),
                                                  decoration: BoxDecoration(
                                                      color: COLOR.white,
                                                      border: Border.all(
                                                          color: selectIndex ==
                                                                  index
                                                              ? COLOR.hexColor(
                                                                  "#fb2d45")
                                                              : COLOR.white,
                                                          width: 1.w),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.w)),
                                                  margin: EdgeInsets.only(
                                                      bottom: 10.w),
                                                  alignment: Alignment.center,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Stack(
                                                            children: [
                                                              ImageView(
                                                                src: model
                                                                        .collectionCoverImg ??
                                                                    "",
                                                                width: 48.w,
                                                                height: 48.w,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.w),
                                                              ),
                                                            ],
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                  "${model.collectionName}",
                                                                  style: kTextStyle(
                                                                      COLOR
                                                                          .color_333333,
                                                                      fontsize:
                                                                          13.w)),
                                                              Text(
                                                                "收录${model.dynamicNum}个笔记",
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: kTextStyle(
                                                                    COLOR
                                                                        .color_999999,
                                                                    fontsize:
                                                                        12.w),
                                                              ).marginOnly(
                                                                  top: 3.w),
                                                            ],
                                                          ).marginLeft(8.w),
                                                        ],
                                                      ),
                                                    ],
                                                  )).onOpaqueTap(() {
                                                if (selectIndex != index) {
                                                  selectIndex = index;
                                                  setState(() {});
                                                }
                                              });
                                            })),
                                    Container(
                                      width: 332.w,
                                      height: 40.w,
                                      margin: EdgeInsets.only(
                                          bottom: 13.w +
                                              ScreenUtil().bottomBarHeight),
                                      alignment: Alignment.center,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(AppImagePath
                                              .mine_icon_big_button),
                                        ),
                                      ),
                                      child: TextView(
                                        text: "确定",
                                        fontSize: 14.w,
                                        fontWeight: FontWeight.w500,
                                        color: COLOR.white,
                                      ),
                                    ).onOpaqueTap(() async {
                                      List<int> ids = [];
                                      for (var item in controller
                                          .pagingControllers.itemList!) {
                                        if (item.isSelected == true) {
                                          ids.add(item.dynamicId);
                                        }
                                      }
                                      var r = await controller.batchCollection(
                                          ids, selectIndex);
                                      if (r) {
                                        Get.back();
                                      }
                                    })
                                  ],
                                ),
                              );
                            }),
                          );
                        });
                      }),
                      ImageView(
                        src: AppImagePath.mine_icon_manage_fans,
                        width: 110.w,
                        height: 36.w,
                      ).onOpaqueTap(() {
                        showAlertDialog(context,
                            title: "提示",
                            message: "确定将选中笔记设置为粉丝专属", onRightButton: () {
                          controller.batchFans(1);
                        });
                      }),
                    ],
                  )
                ],
              ),
            ),
          ),
        if ((text == "审核失败" || text == "审核中") &&
            isManage == true &&
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
                                ? AppImagePath.mine_icon_manage_on
                                : AppImagePath.mine_icon_manage_off,
                            width: 20.w,
                            height: 20.w,
                          ),
                          TextView(
                            text: !isSelect.value ? "全选" : "全不选",
                            fontSize: 13.w,
                            fontWeight: FontWeight.w500,
                            color: COLOR.color_333333,
                          ).marginOnly(left: 5.w)
                        ],
                      ).onOpaqueTap(() {
                        if (isSelect.value) {
                          isSelect.value = false;
                          controller.pagingControllers.itemList
                              ?.forEach((element) {
                            element.isSelected = false;
                          });
                        } else {
                          isSelect.value = true;
                          controller.pagingControllers.itemList
                              ?.forEach((element) {
                            element.isSelected = true;
                          });
                        }
                        controller.pagingControllers.notifyListeners();
                        // if (isSelect.value) {
                        //   isSelect.value = false;
                        //   controller.pagingControllers.itemList
                        //       ?.forEach((element) {
                        //     element.isSelected = true;
                        //   });
                        // } else {
                        //   isSelect.value = true;
                        //   controller.pagingControllers.itemList
                        //       ?.forEach((element) {
                        //     element.isSelected = false;
                        //   });
                        // }
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
                            message: "确认要删除选中审核失败笔记", onRightButton: () {
                          controller.deleteCommunity();
                        });
                      }),
                    ],
                  )
                ],
              ),
            ),
          ),
        if (text == "粉丝专属" &&
            isManage == true &&
            controller.pagingControllers.itemList?.isNotEmpty == true)
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
                            text: isSelect.value ? "全选" : "全不选",
                            fontSize: 13.w,
                            fontWeight: FontWeight.w500,
                            color: COLOR.color_333333,
                          ).marginOnly(left: 5.w)
                        ],
                      ).onOpaqueTap(() {
                        if (isSelect.value) {
                          isSelect.value = false;
                          controller.pagingControllers.itemList
                              ?.forEach((element) {
                            element.isSelected = true;
                          });
                        } else {
                          isSelect.value = true;
                          controller.pagingControllers.itemList
                              ?.forEach((element) {
                            element.isSelected = false;
                          });
                        }
                        controller.pagingControllers.notifyListeners();
                      })),
                  Row(
                    children: [
                      ImageView(
                        src: AppImagePath.mine_icon_manage_out_fans,
                        width: 110.w,
                        height: 36.w,
                      ).onOpaqueTap(() {
                        showAlertDialog(context,
                            title: "提示",
                            message: "确定将选中笔记设置移出粉丝专属", onRightButton: () {
                          controller.batchFans(2);
                        });
                      }),
                    ],
                  )
                ],
              ),
            ),
          )
      ],
    );
  }
}
