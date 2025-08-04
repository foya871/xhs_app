import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tuple/tuple.dart';
import 'package:xhs_app/components/app_bg_view.dart';
import 'package:xhs_app/components/diolog/dialog.dart';
import 'package:xhs_app/components/image_view.dart';
import 'package:xhs_app/components/no_more/no_data.dart';
import 'package:xhs_app/components/text_view.dart';
import 'package:xhs_app/generate/app_image_path.dart';
import 'package:xhs_app/model/blogger/blogger_fans_group.dart';
import 'package:xhs_app/model/blogger/blogger_fans_model.dart';
import 'package:xhs_app/routes/routes.dart';
import 'package:xhs_app/utils/color.dart';
import 'package:xhs_app/utils/enum.dart';
import 'package:xhs_app/utils/extension.dart';
import 'package:xhs_app/views/blogger/private_group/rules_introduction_page.dart';

import 'private_group_page_controller.dart';

class PrivateGroupPage extends GetView<PrivateGroupPageController> {
  const PrivateGroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLOR.white,
      body: _buildBodyView(),
    );
  }

  _buildBodyView() {
    return Column(
      children: [
        Expanded(child: _buildContentView()),
        Obx(() => controller.bloggerPrivateGroupInfo.value.fansMember == false
            ? ImageView(
                src: AppImagePath.mine_blogger_join_fan_button,
                width: double.infinity,
                height: 40.w,
                fit: BoxFit.fill,
              ).marginHorizontal(14.w).onOpaqueTap(() => showJoinDialog())
            : const SizedBox.shrink()),
        20.verticalSpace,
      ],
    );
  }

  _buildContentView() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Obx(() => _buildHeadView(controller.bloggerPrivateGroupInfo.value)),
          10.verticalSpace,
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///公告
                  Obx(() => AppBgView(
                        radius: 4.w,
                        backgroundColor: COLOR.color_F9F9F9,
                        padding: EdgeInsets.all(10.w),
                        text: controller
                                .bloggerPrivateGroupInfo.value.groupAnno ??
                            "",
                        textColor: COLOR.color_333333,
                        textSize: 13.w,
                        textAlign: TextAlign.start,
                        alignment: Alignment.topLeft,
                      )),
                  20.verticalSpace,

                  ///入团特权
                  Row(
                    children: [
                      TextView(
                        text: "入团特权",
                        fontSize: 16.w,
                        color: COLOR.color_333333,
                        fontWeight: FontWeight.w500,
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          TextView(
                            text: "私人会员介绍",
                            fontSize: 13.w,
                            color: COLOR.color_999999,
                          ),
                          2.horizontalSpace,
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 12.w,
                            color: COLOR.color_999999,
                          ),
                        ],
                      ).onOpaqueTap(() {
                        Navigator.push(
                          Get.context!,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const RulesIntroductionPage()),
                        );
                      })
                    ],
                  ),
                  16.verticalSpace,

                  ///特区说明
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: ImageView(
                          src: AppImagePath.mine_blogger_video,
                          width: double.infinity,
                          height: 56.w,
                          fit: BoxFit.fill,
                        ),
                      ),
                      10.horizontalSpace,
                      Expanded(
                        flex: 1,
                        child: ImageView(
                          src: AppImagePath.mine_blogger_medal,
                          width: double.infinity,
                          height: 56.w,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  ),
                  20.verticalSpace,
                  TextView(
                    text: "粉丝排行",
                    fontSize: 16.w,
                    color: COLOR.color_333333,
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.start,
                  ),

                  ///粉丝排行
                  16.verticalSpace,
                  Obx(() => controller.fansRankingList.isNotEmpty
                      ? ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount: controller.fansRankingList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return _buildRankingItemView(
                                controller.fansRankingList[index], index);
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return 16.verticalSpace;
                          },
                        )
                      : const NoData()),
                  30.verticalSpace,
                ],
              )),
        ],
      ),
    );
  }

  _buildHeadView(BloggerFansGroupModel model) {
    return SizedBox(
      height: 200.w,
      child: Stack(
        children: [
          ImageView(
            src: model.coverImg ?? model.groupLogo ?? "",
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: COLOR.white),
                  onPressed: () => Get.back(),
                ),
              ),
              20.verticalSpace,
              Row(
                children: [
                  20.horizontalSpace,
                  ImageView(
                    src: model.groupLogo ?? "",
                    width: 60.w,
                    height: 60.w,
                    borderRadius: BorderRadius.circular(30.w),
                    defaultPlace: AppImagePath.icon_avatar,
                  ),
                  10.horizontalSpace,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextView(
                        text: model.groupName ?? "",
                        fontSize: 18.w,
                        color: COLOR.white,
                        fontWeight: FontWeight.w500,
                      ),
                      10.verticalSpace,
                      TextView(
                        text: "用户ID：${model.userId}",
                        fontSize: 12.w,
                        color: COLOR.white,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
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

  showJoinDialog() {
    Get.bottomSheet(
      Wrap(
        children: [
          AppBgView(
            backgroundColor: COLOR.white,
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.w),
              topRight: Radius.circular(15.w),
            ),
            child: Column(
              children: [
                15.verticalSpace,
                SizedBox(
                  width: double.infinity,
                  height: 20.w,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      TextView(
                        text: "加入私人团",
                        fontSize: 16.w,
                        color: COLOR.color_333333,
                        fontWeight: FontWeight.w500,
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Icon(
                          Icons.close,
                          color: COLOR.color_666666,
                          size: 22.w,
                        ),
                      ),
                    ],
                  ),
                ),
                20.verticalSpace,
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: controller.tickets.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _buildTicketItemView(controller.tickets[index]);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return 10.verticalSpace;
                  },
                ),
                40.verticalSpace,
              ],
            ),
          )
        ],
      ),
    );
  }

  _buildTicketItemView(Tuple4<String, String, int, int> item) {
    return Row(
      children: [
        ImageView(
          src: item.item1,
          width: 50.w,
          height: 50.w,
        ),
        10.horizontalSpace,
        TextView(
          text: item.item2,
          fontSize: 16.w,
          color: COLOR.color_333333,
        ),
        const Spacer(),
        AppBgView(
          height: 36.w,
          radius: 18.w,
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          border: Border.all(color: COLOR.color_FFBE20, width: 1),
          child: Row(
            children: [
              ImageView(
                  src: AppImagePath.mine_blogger_gold,
                  width: 20.w,
                  height: 20.w),
              3.horizontalSpace,
              TextView(
                text: "${item.item3}金币",
                fontSize: 14.w,
                color: COLOR.black,
              ),
            ],
          ),
        ),
      ],
    ).onOpaqueTap(() {
      if ((controller.userService.assets.gold ?? 0) < item.item3) {
        showAlertDialog(
          Get.context!,
          title: "支付失败",
          message: "金币不足暂时无法购买",
          rightText: "立即充值",
          onRightButton: () {
            Get.back();
            Get.toVip(tabInitIndex: 1);
          },
        );
      } else {
        controller.joinPrivateGroup(item.item4);
      }
    });
  }
}
