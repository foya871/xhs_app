/*
 * @Author: david wumingshi555888@gmail.com
 * @Date: 2025-02-21 22:09:59
 * @LastEditors: david wumingshi555888@gmail.com
 * @LastEditTime: 2025-02-22 09:48:47
 * @FilePath: /xhs_app/lib/views/mine/vip/recharge_gold_page.dart
 * @Description: 
 * Copyright (c) 2025 by ${git_name} email: ${git_email}, All Rights Reserved.
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/assets/styles.dart';
import 'package:xhs_app/components/app_bg_view.dart';
import 'package:xhs_app/components/image_view.dart';
import 'package:xhs_app/components/pay/model/gold_model.dart';
import 'package:xhs_app/components/pay/pay_view.dart';
import 'package:xhs_app/components/text_view.dart';
import 'package:xhs_app/generate/app_image_path.dart';
import 'package:xhs_app/routes/routes.dart';
import 'package:xhs_app/utils/color.dart';
import 'package:xhs_app/utils/enum.dart';
import 'package:xhs_app/utils/extension.dart';
import 'package:xhs_app/views/mine/vip/vip_page_controller.dart';

class RechargeGoldPage extends StatelessWidget {
  final VipPageController controller;

  const RechargeGoldPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    // controller.currentGoldCard.value = controller.goldList.first;
    return SingleChildScrollView(
      child: Container(
        color: COLOR.color_FAFAFA,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///会员卡列表
            10.verticalSpace,
            Container(
              width: 332.w,
              height: 133.w,
              padding: EdgeInsets.only(
                  top: 10.w, left: 14.w, right: 14.w, bottom: 14.w),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImagePath.mine_icon_coin_rechange_bg),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextView(
                    text: "金币余额",
                    color: COLOR.color_666666,
                    fontSize: 15.w,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          ImageView(
                            src: AppImagePath.mine_icon_mine_gold,
                            width: 22.w,
                            height: 22.w,
                          ),
                          TextView(
                            text: "${controller.userService.assets.gold}",
                            color: COLOR.color_faa06a,
                            fontSize: 36.w,
                            fontWeight: FontWeight.bold,
                          ).paddingLeft(8.w),
                        ],
                      ),
                      ImageView(
                        src: AppImagePath.mine_btn_tixian,
                        width: 76.w,
                        height: 34.w,
                      ).onTap(() {
                        Get.toNamed(Routes.minewithdrawal);
                      })
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          TextView(
                            text: "人民币余额：",
                            color: COLOR.color_666666,
                            fontSize: 14.w,
                          ),
                          TextView(
                            text: "${controller.userService.assets.bala}",
                            color: COLOR.hexColor("#faa06a"),
                            fontSize: 18.w,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          TextView(
                            text: "我的收益",
                            color: COLOR.color_666666,
                            fontSize: 16.w,
                          ).paddingRight(6.w),
                          ImageView(
                            src: AppImagePath.mine_icon_right,
                            width: 5.w,
                            height: 9.w,
                          )
                        ],
                      ).onOpaqueTap(() {
                        Get.toNamed(Routes.mineprofit);
                      })
                    ],
                  ),
                  // Image.asset(AppImagePath.icon_coin_rechange_bg),
                ],
              ),
              // alignment: Alignment.topCenter,
              // child: _buildVipCardView(),
            ),

            TextView(
              text: "充值金额",
              style: kTextStyle(COLOR.hexColor("333333"),
                  fontsize: 15.w, weight: FontWeight.w600),
            ).marginOnly(top: 20.w, bottom: 20.w),

            GridView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.goldList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 8.w,
                    crossAxisSpacing: 8.w,
                    crossAxisCount: 3,
                    childAspectRatio: 112 / 108),
                itemBuilder: (ctx, index) {
                  GoldModel gold = controller.goldList[index];
                  return Obx(() => Container(
                        width: 112.w,
                        height: 93.w,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(gold.goldId ==
                                        controller.currentGoldCard.value.goldId
                                    ? AppImagePath.mine_icon_coin_on
                                    : AppImagePath.mine_icon_coin_off))),
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextView(
                                    text: "${gold.goldNum}金币",
                                    fontSize: 17.w,
                                    fontWeight: FontWeight.bold,
                                    color: COLOR.color_faa06a),
                                TextView(
                                        text: "售价${gold.price}元",
                                        fontSize: 13.w,
                                        color: COLOR.color_666666)
                                    .marginTop(5.w)
                              ],
                            ),
                            Positioned(
                                top: 2.w,
                                right: 4.w,
                                child: AppBgView(
                                  height: 18.w,
                                  backgroundColor: COLOR.color_FF4340,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(6.w),
                                    bottomLeft: Radius.circular(6.w),
                                  ),
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 7.w,vertical: 1.w),
                                  text: "赠送${gold.freeGoldNum??0}金币",
                                  textColor: COLOR.white,
                                  textSize: 10.w,
                                )),
                          ],
                        ),
                      ).onOpaqueTap(() {
                        controller.currentGoldCard.value = gold;
                      }));
                }),
            Obx(() => _buildVipPayView(controller.currentGoldCard.value))
          ],
        ).marginOnly(left: 14.w, right: 14.w),
      ),
    );
  }

  _buildVipPayView(GoldModel model) {
    return PayView(
      key: ValueKey('${model.goldId}'),
      amount: (model.price ?? 0).toDouble(),
      payId: model.goldId ?? 0,
      purType: PurTypeEnum.gold,
      payType: model.types ?? [],
      isShowBalance: false,
      // onPaySelected: (payModel) {
      //   controller.mCurrentVipPayType = payModel;
      // },
    );
  }
}
