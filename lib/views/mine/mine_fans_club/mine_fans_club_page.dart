import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazy_load_indexed_stack/lazy_load_indexed_stack.dart';
import 'package:xhs_app/components/app_bar/app_bar_view.dart';
import 'package:xhs_app/components/image_view.dart';
import 'package:xhs_app/components/no_more/no_data.dart';
import 'package:xhs_app/components/text_view.dart';
import 'package:xhs_app/generate/app_image_path.dart';
import 'package:xhs_app/model/blogger/blogger_fans_model.dart';
import 'package:xhs_app/model/mine/fans_club_model.dart';
import 'package:xhs_app/routes/routes.dart';
import 'package:xhs_app/utils/color.dart';
import 'package:xhs_app/utils/enum.dart';
import 'package:xhs_app/utils/extension.dart';

import 'mine_fans_club_page_controller.dart';

class MineFansClubPage extends StatefulWidget {
  const MineFansClubPage({super.key});

  @override
  State<MineFansClubPage> createState() => _MineFansClubPageState();
}

class _MineFansClubPageState extends State<MineFansClubPage> {
  int index = 0;

  final controller = Get.find<MineFansClubPageController>();
  @override
  void initState() {
    super.initState();
    controller.queryFansGroup();
    controller.getFansRankingList();
    controller.getHotList();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MineFansClubPageController>(
      builder: (_) => Scaffold(
          backgroundColor: COLOR.color_FAFAFA,
          appBar: AppBarView(
            titleText: "私人团",
          ),
          body: Column(
            children: [
              Row(
                children: [
                  TextView(
                    text: "我创建的",
                    fontSize: 15.w,
                    color: index == 0 ? COLOR.color_333333 : COLOR.color_666666,
                    fontWeight: index == 0 ? FontWeight.w600 : FontWeight.w400,
                  ).onOpaqueTap(() {
                    if (index != 0) {
                      setState(() {
                        index = 0;
                      });
                    }
                  }),
                  25.horizontalSpace,
                  TextView(
                    text: "我加入的",
                    fontSize: 15.w,
                    color: index == 1 ? COLOR.color_333333 : COLOR.color_666666,
                    fontWeight: index == 1 ? FontWeight.w600 : FontWeight.w400,
                  ).onOpaqueTap(() {
                    if (index != 1) {
                      setState(() {
                        controller.getFansGroupList();
                        controller.getHotList();
                        index = 1;
                      });
                    }
                  }),
                ],
              ).marginBottom(20),
              Expanded(
                child: LazyLoadIndexedStack(index: index, children: [
                  Column(
                    children: [
                      Expanded(
                          child: controller.blogger.value.groupId == null ||
                                  controller.blogger.value.groupId == 0
                              ? const NoData(
                                  tips: "暂无私人团",
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            ImageView(
                                              src: controller
                                                      .blogger.value.coverImg ??
                                                  "",
                                              width: 60.w,
                                              height: 60.w,
                                              borderRadius:
                                                  BorderRadius.circular(60.w),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                TextView(
                                                  text:
                                                      "${controller.blogger.value.groupName}",
                                                  fontSize: 15.w,
                                                  color: COLOR.color_333333,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                TextView(
                                                  text:
                                                      "专属笔记：${controller.blogger.value.exclusiveNum}笔记",
                                                  fontSize: 12.w,
                                                  color: COLOR.color_999999,
                                                  fontWeight: FontWeight.w400,
                                                )
                                              ],
                                            ).marginLeft(8.w)
                                          ],
                                        ),
                                        ImageView(
                                          src: AppImagePath.mine_icon_fans_edit,
                                          width: 72.w,
                                          height: 32.w,
                                        ).onOpaqueTap(() {
                                          Get.toNamed(Routes.minecreatefansclub,
                                              arguments: controller
                                                  .blogger.value.groupId);
                                        }),
                                      ],
                                    ).marginOnly(bottom: 12.w),
                                    Container(
                                      width: 332.w,
                                      height: 84.w,
                                      alignment: Alignment.topLeft,
                                      padding: EdgeInsets.all(8.w),
                                      decoration: BoxDecoration(
                                        color: COLOR.color_EEEEEE,
                                        borderRadius:
                                            BorderRadius.circular(4.w),
                                      ),
                                      child: TextView(
                                          text:
                                              "${controller.blogger.value.groupAnno}"),
                                    ),
                                    TextView(
                                      text: "粉丝排行",
                                      fontSize: 16.w,
                                      color: COLOR.color_333333,
                                      fontWeight: FontWeight.w500,
                                    ).marginTop(20.w),
                                    Obx(() => controller
                                            .fansRankingList.isNotEmpty
                                        ? ListView.separated(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            padding: EdgeInsets.zero,
                                            itemCount: controller
                                                .fansRankingList.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return _buildRankingItemView(
                                                  controller
                                                      .fansRankingList[index],
                                                  index);
                                            },
                                            separatorBuilder:
                                                (BuildContext context,
                                                    int index) {
                                              return 16.verticalSpace;
                                            },
                                          )
                                        : const NoData().marginTop(20)),
                                  ],
                                )),
                      Container(
                        width: 332.w,
                        height: 40.w,
                        margin: EdgeInsets.only(
                            bottom: 13.w + ScreenUtil().bottomBarHeight),
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image:
                                AssetImage(AppImagePath.mine_icon_big_button),
                          ),
                        ),
                        child: TextView(
                          text: "创建私人团",
                          fontSize: 14.w,
                          fontWeight: FontWeight.w500,
                          color: COLOR.white,
                        ),
                      ).onOpaqueTap(() {
                        Get.toNamed(Routes.minecreatefansclub);
                      })
                    ],
                  ),
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (controller.fansGroupList.isEmpty)
                          NoData().marginTop(20)
                        else
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.only(top: 16.w),
                            itemCount: controller.fansGroupList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return _buildHotItemView(
                                  controller.fansGroupList[index], index);
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return 16.verticalSpace;
                            },
                          ),
                        TextView(
                          text: "人气私人团",
                          fontSize: 16.w,
                          color: COLOR.color_333333,
                          fontWeight: FontWeight.w500,
                        ).marginTop(30.w),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.only(top: 16.w),
                          itemCount: controller.hotList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return _buildHotItemView(
                                controller.hotList[index], index);
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return 16.verticalSpace;
                          },
                        ),
                        Container(
                          height: 16.w + ScreenUtil().bottomBarHeight,
                        )
                      ],
                    ),
                  )
                ]),
              )
            ],
          ).marginOnly(left: 14.w, right: 14.w, top: 12.w)),
    );
  }

  _buildRankingItemView(BloggerFansModel item, int index) {
    return Row(
      children: [
        TextView(
          text: "${index + 1}",
          fontSize: 13.w,
          color: COLOR.color_333333,
        ),
        13.horizontalSpace,
        ImageView(
          src: item.logo ?? "",
          width: 48.w,
          height: 48.w,
          defaultPlace: AppImagePath.icon_avatar,
          borderRadius: BorderRadius.circular(24.w),
        ),
        10.horizontalSpace,
        TextView(
          text: item.nickName ?? "",
          fontSize: 13.w,
          color: COLOR.color_333333,
        ),
        4.horizontalSpace,
        (item.vipType ?? 0) > 0 && VipTypeEnum.badge(item.vipType).isNotEmpty
            ? ImageView(
                src: VipTypeEnum.badge(item.vipType),
                width: 40.w,
                height: 16.w,
              )
            : const SizedBox.shrink(),
        const Spacer(),
        TextView(
          text: "${item.intimacy ?? 0}点亲密度",
          fontSize: 13.w,
          color: COLOR.color_FB2D45,
        ),
      ],
    );
  }

  _buildHotItemView(FansClubModel item, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            ImageView(
              src: item.groupLogo ?? "",
              width: 56.w,
              height: 56.w,
              borderRadius: BorderRadius.circular(56.w),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextView(
                  text: item.groupName ?? "",
                  fontSize: 14.w,
                  color: COLOR.color_666666,
                  fontWeight: FontWeight.w500,
                ).marginBottom(6.w),
                TextView(
                    text: "${item.fansGroupNum}人已加入",
                    fontSize: 12.w,
                    color: COLOR.color_999999),
              ],
            ).marginLeft(9.w)
          ],
        ),
        if (item.isJoin == false || item.expired == true)
          Container(
            width: 62.w,
            height: 28.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: COLOR.white,
              border: Border.all(color: COLOR.hexColor("#fb2d45")),
              borderRadius: BorderRadius.circular(16.w),
            ),
            child: TextView(
              text: item.expired == true ? "续费" : "加入",
              fontSize: 13.w,
              color: COLOR.hexColor("#fb2d45"),
              fontWeight: FontWeight.w500,
            ),
          ).onOpaqueTap(() {
            Get.toBloggerPrivateGroup(userId: item.userId ?? 0);
          })
        else
          TextView(
            text:
                "私人团${item.ticketType == 1 ? "月" : item.ticketType == 2 ? "季" : "年"}票",
            fontSize: 13.w,
            color: COLOR.color_333333,
            fontWeight: FontWeight.w500,
          ),
      ],
    );
  }
}
