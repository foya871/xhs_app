import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:xhs_app/components/app_bg_view.dart';
import 'package:xhs_app/components/image_view.dart';
import 'package:xhs_app/components/tab_bar_indicator/easy_fixed_indicator.dart';
import 'package:xhs_app/components/text_view.dart';
import 'package:xhs_app/generate/app_image_path.dart';
import 'package:xhs_app/model/check_in/check_in_model.dart';
import 'package:xhs_app/model/check_in/check_in_tasks_model.dart';
import 'package:xhs_app/routes/routes.dart';
import 'package:xhs_app/utils/color.dart';
import 'package:xhs_app/utils/extension.dart';

import 'check_in_page_controller.dart';

class CheckInPage extends GetView<CheckInPageController> {
  const CheckInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: _bodyView(context),
    );
  }

  _bodyView(context) {
    return CustomScrollView(
      slivers: [
        ///AppBar
        _buildHeaderView(),
        Container(
          color: COLOR.white,
          child: Column(
            children: [
              ///签到列表
              _buildCheckInView(),
              13.verticalSpace,

              ///签到列表展开收缩
              _buildExpandedShrinkView(),
              13.verticalSpace,

              ///签到按钮
              _buildCheckInButton(),
              26.verticalSpace,

              ///任务Tab列表
              _buildTaskTabView(context),
              23.verticalSpace,
            ],
          ),
        ).sliver,
      ],
    );
  }

  ///AppBar
  _buildHeaderView() {
    return AppBgView(
      height: 400.w,
      imagePath: AppImagePath.home_check_in_bg,
      child: Column(
        children: [
          AppBar(
            shadowColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onPressed: () {
                Get.back();
              },
            ),
            actions: [
              AppBgView(
                height: 28.w,
                backgroundColor: Colors.white,
                radius: 14.w,
                text: '签到规则',
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                textColor: COLOR.color_F43670,
                onTap: () {
                  SmartDialog.show(
                    clickMaskDismiss: true,
                    builder: (context) {
                      return showCheckInDialog();
                    },
                  );
                },
              ),
              14.horizontalSpace,
            ],
          ),
          const Spacer(),
          Obx(() => AppBgView(
                height: 36.w,
                imagePath: AppImagePath.home_check_in_hint,
                fit: BoxFit.fitHeight,
                text:
                    '${controller.checkInModel.value.integral}积分 · 已连续签到${controller.checkInModel.value.totalSignCount}天',
                textSize: 14.w,
                textColor: COLOR.white,
              )),
          16.verticalSpace,
          ImageView(
            src: AppImagePath.home_check_in_radius_bg,
            height: 25.w,
            fit: BoxFit.fill,
          ),
        ],
      ),
    ).sliver;
  }

  ///签到规则
  showCheckInDialog() {
    return AppBgView(
      height: 200.w,
      backgroundColor: COLOR.white,
      margin: EdgeInsets.symmetric(horizontal: 40.w),
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      radius: 12.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: [
                AppBgView(
                  width: 150.w,
                  imagePath: AppImagePath.home_check_in_rule_title_bg,
                  height: 32.w,
                  text: "签到规则",
                  textColor: COLOR.white,
                  textSize: 16.w,
                  fontWeight: FontWeight.w500,
                ),
                Positioned(
                  top: 5,
                  right: 0,
                  child: Icon(
                    Icons.close,
                    color: COLOR.color_666666,
                    size: 24.w,
                  ).onOpaqueTap(() {
                    SmartDialog.dismiss();
                  }),
                ),
              ],
            ),
          ),
          20.verticalSpace,
          TextView(
            text: "1. 签到积分在 福利 兑换领取\n"
                "2. 签到AI去衣、换脸 自动领取，在AI制作页面查看\n"
                "3. 签到获得的会员自动到账\n"
                "4. 签到领取的金币 自动到账\n"
                "5. 签到领取金币观影券 自动到账",
            color: COLOR.color_666666,
            fontSize: 13.w,
          ),
        ],
      ),
    );
  }

  ///签到列表
  _buildCheckInView() {
    return Obx(() => GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.isExpanded.value
              ? controller.checkInList.length
              : controller.checkInList.length > 15
                  ? 15
                  : controller.checkInList.length,
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            childAspectRatio: 58 / 90,
            mainAxisSpacing: 10.w,
            crossAxisSpacing: 10.w,
          ),
          itemBuilder: (context, index) {
            return _buildCheckInItem(controller.checkInList[index]);
          },
        ));
  }

  _buildCheckInItem(DailySignInTasks model) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppBgView(
          width: 58.w,
          height: 60.w,
          imagePath: model.status == 0
              ? AppImagePath.home_check_in_un_check_in_bg
              : AppImagePath.home_check_in_received_bg,
          radius: 5.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ImageView(
                src: model.status == 0
                    ? controller.getCheckInStatusImagePath(model.prizeType ?? 0)
                    : AppImagePath.home_check_in_received,
                width: 40.w,
                height: 40.w,
              ),
              AppBgView(
                height: 16.w,
                text: controller.getCheckInDesc(
                    model.prizeType ?? 0, model.prizeNum ?? 0),
                textColor: model.status == 0 ? COLOR.white : COLOR.color_FF5C5C,
                radius: 5.w,
                textSize: 10.w,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        5.verticalSpace,
        AppBgView(
          width: 54.w,
          height: 20.w,
          radius: 11.w,
          backgroundColor: model.status == 1
              ? COLOR.white
              : model.today == true
                  ? COLOR.color_FF5C5C
                  : COLOR.white,
          border: Border.all(
              color:
                  model.status == 1 ? COLOR.color_999999 : COLOR.color_FF5C5C,
              width: 0.5.w),
          text: model.status == 1
              ? "已签到"
              : model.today == true
                  ? "立即签到"
                  : "未签到",
          textColor: model.status == 1
              ? COLOR.color_999999
              : model.today == true
                  ? COLOR.white
                  : COLOR.color_FF5C5C,
          textSize: 10.w,
          onTap: () {
            if (model.today == true) {
              controller.startCheckIn();
            }
          },
        ),
      ],
    );
  }

  ///签到列表展开收缩
  _buildExpandedShrinkView() {
    return Obx(() => ImageView(
          src: controller.isExpanded.value
              ? AppImagePath.home_check_in_shrink
              : AppImagePath.home_check_in_expand,
          height: 17.w,
          fit: BoxFit.fitHeight,
        ).onOpaqueTap(() {
          controller.isExpanded.value = !controller.isExpanded.value;
        }));
  }

  ///签到按钮
  _buildCheckInButton() {
    return Obx(() => AppBgView(
          height: 38.w,
          radius: 19.w,
          backgroundColor: COLOR.color_B5B5B5,
          imagePath: controller.checkInModel.value.todaySignIn == true
              ? null
              : AppImagePath.icons_button_bg,
          text: controller.checkInModel.value.todaySignIn == true
              ? "已签到"
              : "立即签到",
          margin: EdgeInsets.symmetric(horizontal: 50.w),
          textSize: 13.w,
          textColor: COLOR.white,
          onTap: () {
            if (controller.checkInModel.value.todaySignIn == true) {
              SmartDialog.showToast("今日已签到");
            } else {
              controller.startCheckIn();
            }
          },
        ));
  }

  ///任务Tab列表
  _buildTaskTabView(context) {
    return AppBgView(
      borderRadius: BorderRadius.all(Radius.circular(8.w)),
      border: Border.all(color: COLOR.color_FF5C5C, width: 0.5.w),
      margin: EdgeInsets.symmetric(horizontal: 14.w),
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        children: [
          _buildTabBar(),
          10.verticalSpace,
          Divider(
            height: 0.5.w,
            color: COLOR.color_999999,
            thickness: 0,
          ),
          10.verticalSpace,
          Obx(() => SizedBox(
                height: controller.tabIndex.value == 0
                    ? controller.singleTasks.length * 50.w + 120.w
                    : controller.tabIndex.value == 1
                        ? controller.dailyTasks.length * 50.w + 120.w
                        : controller.integralPrizes.length * 60.w + 120.w,
                child: TabBarView(
                  controller: controller.tabController,
                  children: [
                    _buildNewbieMissionTaskView().keepAlive,
                    _buildDailyMissionTaskView().keepAlive,
                    _buildWelfareExchangeTaskView().keepAlive,
                  ],
                ),
              )),
          20.verticalSpace,
        ],
      ),
    );
  }

  ///任务TabBar 福利
  _buildTabBar() {
    return TabBar(
      controller: controller.tabController,
      tabs: controller.tabs,
      isScrollable: false,
      labelStyle: TextStyle(
        fontSize: 16.w,
        fontWeight: FontWeight.w600,
        color: COLOR.black,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 16.w,
        fontWeight: FontWeight.w600,
        color: COLOR.color_333333,
      ),
      indicator: EasyFixedIndicator(
        color: COLOR.color_FB2D45,
        width: 20.w,
        height: 3.w,
      ),
      dividerHeight: 0,
      onTap: (index) {
        controller.tabIndex.value = index;
      },
    );
  }

  ///萌新任务
  Widget _buildNewbieMissionTaskView() {
    return Column(
      children: [
        Obx(() => ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.singleTasks.length,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return _buildItemTaskView(controller.singleTasks[index]);
              },
              separatorBuilder: (BuildContext context, int index) =>
                  10.verticalSpace,
            )),
        30.verticalSpace,
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextView(
              text: "完成所有萌新任务 ",
              fontSize: 12.w,
              color: COLOR.color_333333,
            ),
            TextView(
              text: "+300积分",
              fontSize: 12.w,
              color: COLOR.color_FB2D45,
            ),
          ],
        ),
        15.verticalSpace,
        AppBgView(
          height: 38.w,
          radius: 19.w,
          imagePath: AppImagePath.icons_button_bg,
          text: "查看兑换记录",
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          textSize: 13.w,
          textColor: COLOR.white,
          onTap: () {
            Get.toNamed(Routes.redemption_record);
          },
        ),
      ],
    );
  }

  ///每日任务
  Widget _buildDailyMissionTaskView() {
    return Column(
      children: [
        Obx(() => ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.dailyTasks.length,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return _buildItemTaskView(controller.dailyTasks[index]);
              },
              separatorBuilder: (BuildContext context, int index) =>
                  10.verticalSpace,
            )),
        30.verticalSpace,
        AppBgView(
          height: 38.w,
          radius: 19.w,
          imagePath: AppImagePath.icons_button_bg,
          text: "查看兑换记录",
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          textSize: 13.w,
          textColor: COLOR.white,
          onTap: () {
            Get.toNamed(Routes.redemption_record);
          },
        ),
      ],
    );
  }

  _buildItemTaskView(item) {
    return SizedBox(
      height: 40.w,
      child: Row(
        children: [
          TextView(
            text: "${item.missionName ?? ""}",
            fontSize: 14.w,
            color: COLOR.black,
            fontWeight: FontWeight.w500,
          ),
          const Spacer(),
          AppBgView(
            height: 32.w,
            width: 80.w,
            radius: 16.w,
            backgroundColor: COLOR.color_FF5C5C,
            text: item.status == 3 ? "已领取" : "${item.integral}积分",
            textColor: COLOR.white,
            textSize: 13.w,
            onTap: () {
              controller.getIntegralPrizes(item.missionId ?? 0);
            },
          ),
        ],
      ),
    );
  }

  ///福利兑换
  Widget _buildWelfareExchangeTaskView() {
    return Column(
      children: [
        Obx(() => GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.integralPrizes.length,
              padding: EdgeInsets.zero,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.37,
                mainAxisSpacing: 10.w,
                crossAxisSpacing: 10.w,
              ),
              itemBuilder: (context, index) {
                final item = controller.integralPrizes[index];
                return _buildWelfareItemTaskView(item);
              },
            )),
        30.verticalSpace,
        AppBgView(
          height: 38.w,
          radius: 19.w,
          imagePath: AppImagePath.icons_button_bg,
          text: "查看兑换记录",
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          textSize: 13.w,
          textColor: COLOR.white,
          onTap: () {
            Get.toNamed(Routes.redemption_record);
          },
        ),
      ],
    );
  }

  _buildWelfareItemTaskView(IntegralPrizes item) {
    return AppBgView(
      radius: 8.w,
      child: Column(
        children: [
          AppBgView(
            height: 70.w,
            imagePath:
                controller.getCheckInWelfareTypeImagePath(item.prizeType ?? 0),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.w),
              topRight: Radius.circular(8.w),
            ),
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: TextView(
              text: item.prizeName ?? "",
              color: COLOR.white,
              fontSize: 13.w,
            ),
          ),
          AppBgView(
            height: 36.w,
            backgroundColor: COLOR.color_EEEEEE,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8.w),
              bottomRight: Radius.circular(8.w),
            ),
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Row(
              children: [
                TextView(
                  text: "花费${item.needIntegral}积分",
                  color: COLOR.color_666666,
                  fontSize: 12.w,
                ),
                const Spacer(),
                AppBgView(
                  height: 22.w,
                  radius: 11.w,
                  backgroundColor: COLOR.color_FB2D45,
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  text: "立即兑换",
                  textColor: COLOR.white,
                  textSize: 11.w,
                  onTap: () {
                    controller.exchangeIntegralPrizes(item.prizeId ?? 0);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
