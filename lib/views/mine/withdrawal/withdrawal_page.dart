import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:xhs_app/components/app_bar/app_bar_view.dart';
import 'package:xhs_app/components/image_view.dart';
import 'package:xhs_app/components/text_view.dart';
import 'package:xhs_app/generate/app_image_path.dart';
import 'package:xhs_app/utils/color.dart';
import 'package:xhs_app/utils/extension.dart';

import 'withdrawal_page_controller.dart';

class MineWithdrawalPage extends GetView<MineWithdrawalPageController> {
  const MineWithdrawalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLOR.color_FAFAFA,
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  _buildAppBar() {
    return AppBarView(
      titleText: "提现",
    );
  }

  _buildBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () => Row(
              children: [
                TextView(
                  text: "人民币提现",
                  color: controller.purType.value == 1
                      ? COLOR.color_333333
                      : COLOR.color_999999,
                  fontSize: 15.w,
                  fontWeight: controller.purType.value == 1
                      ? FontWeight.bold
                      : FontWeight.w400,
                ).onOpaqueTap(() {
                  controller.changePurType(1);
                }),
                TextView(
                  text: "金币提现",
                  color: controller.purType.value == 2
                      ? COLOR.color_333333
                      : COLOR.color_999999,
                  fontSize: 15.w,
                  fontWeight: controller.purType.value == 2
                      ? FontWeight.bold
                      : FontWeight.w400,
                ).onOpaqueTap(() {
                  controller.changePurType(2);
                }).marginOnly(left: 24.w),
              ],
            ),
          ),
          TextView(
                  text: "姓名",
                  color: COLOR.color_333333,
                  fontSize: 15.w,
                  fontWeight: FontWeight.bold)
              .marginOnly(top: 20.w, bottom: 12.w),
          TextFormField(
              controller: controller.nameController,
              style: TextStyle(
                color: COLOR.color_333333,
                fontSize: 14.w,
              ),
              onChanged: (value) {
                controller.receiptName.value = value;
              },
              decoration: InputDecoration(
                  hintText: "输入姓名",
                  disabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromRGBO(0, 0, 0, 0.08)), // 设置焦点时边框颜色
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromRGBO(0, 0, 0, 0.08)), // 设置焦点时边框颜色
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromRGBO(0, 0, 0, 0.08)), // 设置焦点时边框颜色
                  ),
                  hintStyle: TextStyle(
                    color: COLOR.hexColor("#b0b0b0"),
                    fontSize: 14.w,
                  ),
                  contentPadding: EdgeInsets.only(left: 0.w, right: 0.w))),
          TextView(
                  text: "支付宝账号",
                  color: COLOR.color_333333,
                  fontSize: 15.w,
                  fontWeight: FontWeight.bold)
              .marginOnly(top: 20.w, bottom: 12.w),
          TextFormField(
              controller: controller.accountController,
              style: TextStyle(
                color: COLOR.color_333333,
                fontSize: 14.w,
              ),
              onChanged: (value) {
                controller.accountNo.value = value;
              },
              decoration: InputDecoration(
                  hintText: "输入支付宝账号",
                  disabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromRGBO(0, 0, 0, 0.08)), // 设置焦点时边框颜色
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromRGBO(0, 0, 0, 0.08)), // 设置焦点时边框颜色
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromRGBO(0, 0, 0, 0.08)), // 设置焦点时边框颜色
                  ),
                  hintStyle: TextStyle(
                    color: COLOR.hexColor("#b0b0b0"),
                    fontSize: 14.w,
                  ),
                  contentPadding: EdgeInsets.only(left: 0.w, right: 0.w))),
          TextView(
                  text: "提现金额",
                  color: COLOR.color_333333,
                  fontSize: 15.w,
                  fontWeight: FontWeight.bold)
              .marginOnly(top: 25.w, bottom: 12.w),
          Container(
            decoration: const BoxDecoration(
                border: Border(
              bottom: BorderSide(
                color: Color.fromRGBO(0, 0, 0, 0.08),
                width: 1,
              ),
            )),
            child: Row(
              children: [
                ImageView(
                    src: AppImagePath.mine_icon_money,
                    width: 12.w,
                    fit: BoxFit.contain,
                    height: 25.w),
                Expanded(
                  child: TextFormField(
                      controller: controller.moneyController,
                      keyboardType: TextInputType.number,
                      cursorHeight: 0,
                      style: TextStyle(
                          color: COLOR.color_333333,
                          fontSize: 30.w,
                          fontWeight: FontWeight.bold),
                      onChanged: (value) {
                        if (value != null && value.isNotEmpty) {
                          controller.money.value = double.parse(value);
                        } else {
                          controller.money.value = 0;
                        }
                      },
                      decoration: InputDecoration(
                          disabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                                color:
                                    Color.fromRGBO(0, 0, 0, 0.08)), // 设置焦点时边框颜色
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                                color:
                                    Color.fromRGBO(0, 0, 0, 0.08)), // 设置焦点时边框颜色
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                                color:
                                    Color.fromRGBO(0, 0, 0, 0.00)), // 设置焦点时边框颜色
                          ),
                          hintStyle: TextStyle(
                            color: COLOR.hexColor("#b0b0b0"),
                            fontSize: 14.w,
                          ),
                          contentPadding:
                              EdgeInsets.only(left: 8.w, right: 0.w))),
                ),
                TextView(
                        text: "全部提现",
                        color: COLOR.color_333333,
                        fontSize: 14.w,
                        fontWeight: FontWeight.w400)
                    .onOpaqueTap(() {
                  if (controller.purType.value == 1) {
                    controller.moneyController.text =
                        controller.userService.assets.bala.toString();
                  } else {
                    controller.moneyController.text =
                        controller.userService.assets.gold.toString();
                  }
                  controller.money.value =
                      double.parse(controller.moneyController.text);
                })
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  TextView(
                    text: "余额：",
                    fontSize: 12.w,
                    color: COLOR.hexColor("666666"),
                  ),
                  TextView(
                      text:
                          "${controller.purType.value == 1 ? controller.userService.assets.bala : controller.userService.assets.gold}",
                      fontSize: 12.w,
                      color: COLOR.color_faa06a)
                ],
              ),
              TextView(
                      text: "满100可提现，最高额度10000",
                      fontSize: 12.w,
                      color: COLOR.color_999999)
                  .marginTop(14.w)
            ],
          ),
          _buildTipView(),
          ImageView(
                  src: AppImagePath.mine_icon_withdrawal,
                  width: 332.w,
                  height: 40.w)
              .marginTop(88.w)
              .onTap(() {
            if (controller.receiptName.value.isEmpty) {
              SmartDialog.showToast("请输入姓名", alignment: Alignment.center);
              return;
            }
            if (controller.accountNo.value.isEmpty) {
              SmartDialog.showToast("请输入支付宝账号", alignment: Alignment.center);
              return;
            }
            controller.withdrawal();
          })
        ],
      ).marginOnly(left: 14.w, right: 14.w, top: 14.w),
    );
  }

  _buildTipView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextView(
          text: "温馨提示",
          color: COLOR.color_999999,
          fontSize: 12.w,
          fontWeight: FontWeight.w400,
        ),
        TextView(
          text: "1.请填写正确的支付宝账号及姓名，如资料错误可能导致提现失败.",
          color: COLOR.color_999999,
          fontSize: 12.w,
        ).marginOnly(top: 6.w),
        TextView(
          text: "2.提现到账时间为1-2个工作日，请留意银行卡账单状体.",
          color: COLOR.color_999999,
          fontSize: 12.w,
        ).marginOnly(top: 6.w),
        TextView(
          text: "3.你的个人资料将严格保密，不会用于第三方.",
          color: COLOR.color_999999,
          fontSize: 12.w,
        ).marginOnly(top: 6.w)
      ],
    ).marginOnly(top: 30.w);
  }
}
