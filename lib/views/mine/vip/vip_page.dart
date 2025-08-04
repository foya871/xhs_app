import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/components/image_view.dart';
import 'package:xhs_app/components/keep_alive_wrapper.dart';
import 'package:xhs_app/components/pay/model/vip_model.dart';
import 'package:xhs_app/components/pay/pay_view.dart';
import 'package:xhs_app/components/tab_bar_indicator/easy_fixed_indicator.dart';
import 'package:xhs_app/components/text_view.dart';
import 'package:xhs_app/generate/app_image_path.dart';
import 'package:xhs_app/routes/routes.dart';
import 'package:xhs_app/utils/color.dart';
import 'package:xhs_app/utils/enum.dart';
import 'package:xhs_app/views/mine/vip/vip_page_controller.dart';

import 'recharge_gold_page.dart';

class VipPage extends StatefulWidget {
  const VipPage({super.key});

  @override
  State<VipPage> createState() => _VipPageState();
}

class _VipPageState extends State<VipPage> {
  VipPageController controller = Get.find<VipPageController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VipPageController>(builder: (_) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Obx(() => controller.tabInitIndex.value == 0
                ? Image.asset(
                    AppImagePath.mine_vip_bg,
                    width: double.infinity,
                    height: 291.w,
                    // fit: BoxFit.fitWidth,
                  )
                : SizedBox(
                    width: double.infinity,
                    height: 291.w,
                  )),
            Scaffold(
                backgroundColor: controller.tabInitIndex.value == 0
                    ? Colors.transparent
                    : Colors.white,
                appBar: _buildAppBar(),
                body: TabBarView(
                  controller: controller.tabController,
                  children: [
                    KeepAliveWrapper(child: _buildVipBodyView()),
                    KeepAliveWrapper(
                        child: RechargeGoldPage(
                      controller: controller,
                    )),
                  ],
                )),
          ],
        ),
      );
    });
  }

  _buildAppBar() {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: Icon(
          Icons.arrow_back_ios_new,
          color: controller.tabController.index == 0
              ? COLOR.white
              : COLOR.color_333333,
        ),
      ),
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      systemOverlayStyle: controller.tabController.index == 0
          ? SystemUiOverlayStyle.light
          : SystemUiOverlayStyle.dark,
      title: TabBar(
        tabs: controller.tabs,
        controller: controller.tabController,
        labelStyle: TextStyle(
          color: controller.tabInitIndex.value == 0
              ? COLOR.white
              : COLOR.color_333333,
          fontSize: 17.w,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: TextStyle(
          color: controller.tabInitIndex.value == 0
              ? COLOR.white.withOpacity(0.7)
              : COLOR.hexColor("999999"),
          fontSize: 17.w,
        ),
        isScrollable: false,
        dividerHeight: 0,
        indicator: EasyFixedIndicator(
            width: 26.w, height: 2.w, color: COLOR.hexColor("#fb2d45")),
        indicatorPadding: EdgeInsets.only(bottom: 0.w),
        labelPadding: EdgeInsets.only(right: 0.w),
        onTap: (index) {
          controller.tabInitIndex.value = index;
          setState(() {});
        },
      ),
      actions: [
        TextButton(
          onPressed: () => Get.toRechargeRecord(
              type: controller.tabController.index == 0 ? 3 : 2),
          child: TextView(
            text: "记录",
            fontSize: 14.w,
            color: controller.tabController.index == 0
                ? COLOR.white
                : COLOR.color_333333,
          ),
        )
      ],
      // bottom: PreferredSize(
      //     preferredSize: Size.fromHeight(24.w), child: _buildMarqueeView()),
    );
  }

  _buildVipBodyView() {
    return SingleChildScrollView(
      child: Column(
        children: [
          ///会员卡列表
          24.verticalSpace,
          Container(
            width: double.infinity,
            alignment: Alignment.topCenter,
            child: _buildVipCardView(),
          ),
          if (controller.currentVipCard.value.cardId != null)
            Container(
              width: double.infinity,
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(top: 36.w),
              decoration: BoxDecoration(
                color: COLOR.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.w),
                  topRight: Radius.circular(8.w),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///VIP权益说明、积分兑换
                  Obx(() => _buildVIPRightsDescriptionView()),

                  Obx(() => _buildVipPayView(controller.currentVipCard.value)),

                  50.verticalSpace,
                ],
              ),
            ),
        ],
      ),
    );
  }

  ///会员卡列表
  _buildVipCardView() {
    return CarouselSlider(
      options: CarouselOptions(
          autoPlay: false,
          height: 140.w,
          enlargeCenterPage: true,
          enlargeStrategy: CenterPageEnlargeStrategy.zoom,
          // 显示比例
          viewportFraction: 0.9,
          pageSnapping: true,
          // 启用无限循环
          enableInfiniteScroll: true,
          initialPage: 0,
          enlargeFactor: 0.3,
          onPageChanged: (index, reason) {
            controller.currentVipCard.value = controller.vipList[index];
          }),
      items: controller.vipList.map((item) {
        return _buildCardItemView(item);
      }).toList(),
    );
  }

  Widget _buildCardItemView(item) {
    if ( item.cardType == 12 || item.cardType == 13) {
      return ImageView(
        src: getVipCardType(item.cardType),
        width: 302.w,
        height: 140.w,
        fit: BoxFit.fill,
      );
    }
    return Stack(
      children: [
        ImageView(
          src: getVipCardType(item.cardType),
          width: 302.w,
          height: 140.w,
          fit: BoxFit.fill,
        ),
        Positioned(
            top: 52.w,
            left: 16.w,
            child: SizedBox(
              width: 156.w,
              child: TextView(
                text: "${item.desc}",
                color: _getColor(item.cardType),
                fontSize: 13.w,
              ),
            )),
        Positioned(
            bottom: 10.w,
            left: 16.w,
            child: Row(
              children: [
                TextView(
                  text: "¥${item.disPrice}元",
                  color: _getColor(item.cardType),
                  fontSize: 26.w,
                  fontWeight: FontWeight.bold,
                ),
                TextView(
                  text: "原价¥${item.price}元",
                  color: _getColor(item.cardType),
                  decoration: TextDecoration.lineThrough,
                  fontSize: 13.w,
                ).paddingOnly(left: 10.w),
              ],
            ))
      ],
    );
  }

  ///会员卡类型 (0-普通用户; 1-体验卡; 2-周卡; 3-下载卡; 4-短剧卡; 5-月卡; 6-金币月卡;
  ///7-年卡 8-金币永久卡; 9-至尊卡; 10-禁区卡 11-萝莉岛年卡; 12-私聊专属月卡; 13-私聊专属季卡)
  getVipCardType(int cardType) {
    if (cardType == 5 || cardType == 6) {
      return AppImagePath.mine_vip_6;
    } else if (cardType == 7) {
      return AppImagePath.mine_vip_8;
    } else if (cardType == 8) {
      return AppImagePath.mine_vip_8;
    // } else if (cardType == 9) {
    //   return AppImagePath.mine_vip_9;
    } else if (cardType == 10) {
      return AppImagePath.mine_vip_9;
    } else if (cardType == 11) {
      return AppImagePath.mine_vip_11;
    } else if (cardType == 12) {
      return AppImagePath.mine_vip_month;
    } else if (cardType == 13) {
      return AppImagePath.mine_VIP_season;
    }
    return AppImagePath.mine_vip_6;
  }

  getVipCardTypeDesc(int cardType) {
    if (cardType == 5 || cardType == 6) {
      return AppImagePath.mine_icon_vip_desc_6;
    } else if (cardType == 7) {
      return AppImagePath.mine_icon_vip_desc_8;
    } else if (cardType == 8) {
      return AppImagePath.mine_icon_vip_desc_8;
    // } else if (cardType == 9) {
    //   return AppImagePath.mine_icon_vip_desc_9;
    } else if (cardType == 10) {
      return AppImagePath.mine_icon_vip_desc_9;
    } else if (cardType == 11) {
      return AppImagePath.mine_icon_vip_desc_11;
    } else if (cardType == 12) {
      return AppImagePath.mine_vip_desc_month;
    } else if (cardType == 13) {
      return AppImagePath.mine_vip_desc_season;
    }
    return AppImagePath.mine_vip_description_default;
  }

  _getColor(int cardType) {
    if (cardType == 6) {
      return COLOR.hexColor("#ffd87a");
    } else if (cardType == 8) {
      return COLOR.hexColor("#ffbb7e");
    } else if (cardType == 9) {
      return COLOR.hexColor("#ff9999");
    } else {
      return COLOR.hexColor("#ffffff");
    }
  }

  ///VIP权益说明、积分兑换
  _buildVIPRightsDescriptionView() {
    return Container(
      decoration: BoxDecoration(
        color: COLOR.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.w),
          topRight: Radius.circular(12.w),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextView(
            text: "会员权益",
            color: COLOR.color_333333,
            textAlign: TextAlign.left,
            fontWeight: FontWeight.bold,
            fontSize: 15.w,
          ).marginOnly(left: 14.w, top: 20.w),

          ///权益说明
          15.verticalSpace,

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Image.asset(
              getVipCardTypeDesc(controller.currentVipCard.value.cardType ?? 0),
              height: controller.currentVipCard.value.cardType == 12 ||
                      controller.currentVipCard.value.cardType == 13
                  ? 109.w
                  : null,
            ),
          ),

          // ///分割线
          // 20.verticalSpace,
          // Divider(
          //   height: 2.w,
          //   color: COLOR.color_F0F0F0,
          // ),

          // ///积分兑换
          // 20.verticalSpace,
          // _buildPointsRedemptionView(),
        ],
      ),
    );
  }

  _buildVipPayView(VipModel model) {
    return PayView(
      amount: (model.disPrice ?? 0).toDouble(),
      payId: model.cardId ?? 0,
      purType: PurTypeEnum.vip,
      payType: model.types ?? [],
      isShowBalance: false,
      // onPaySelected: (payModel) {
      //   controller.mCurrentVipPayType = payModel;
      // },
    );
  }
}
