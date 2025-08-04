// import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/assets/styles.dart';
import 'package:xhs_app/components/diolog/dialog.dart';
import 'package:xhs_app/components/image_view.dart';
import 'package:xhs_app/components/pay/pay_view_controller.dart';
import 'package:xhs_app/generate/app_image_path.dart';
// import 'package:xhs_app/utils/ad_jump.dart';
// import 'package:xhs_app/utils/extension.dart';

import '../../utils/color.dart';
import 'enum_pay.dart';
import 'model/recharge_request_model.dart';
import 'model/recharge_type_model.dart';

/// 通用支付页面
/// 具体UI样式排版可以自行改动
class PayView extends StatefulWidget {
  final double amount; //支付金额
  final int payId; //购买的ID
  final int payNumber; //购买的数量
  //购买类型 (1-常规充值; 2-购买VIP; 3-购买金币; 4-购买门票; 5-购买AI_VIP会员)
  final int purType;
  final List<RechargeTypeModel> payType; //支付类型
  final int source; //来源 0:平台

  final bool isShowBalance; //是否显示余额
  final bool isAddBalancePay; //是否添加余额支付
  final bool isDefaultSelectedFirst; //是否默认选中第一个
  final bool isShowNotPayType; //是否显示没有支付方式
  final bool isShowPayFeedback; //是否显示支付问题反馈
  final GestureTapCallback? onTapPayFeedback; //支付问题反馈点击事件
  final Function()? onPaySuccess; //成功后才回调

  const PayView({
    super.key,
    required this.amount,
    required this.payId,
    this.payNumber = 1,
    required this.purType,
    required this.payType,
    this.source = 0,
    this.isShowBalance = true,
    this.isAddBalancePay = true,
    this.isDefaultSelectedFirst = true,
    this.isShowNotPayType = true,
    this.isShowPayFeedback = true,
    this.onTapPayFeedback,
    this.onPaySuccess,
  });

  @override
  State<PayView> createState() => _PayViewState();
}

class _PayViewState extends State<PayView> {
  late PayViewController controller;
  String tag = "";
  @override
  void initState() {
    super.initState();
    tag = "${widget.purType}_${widget.payId}";

    controller = Get.put(PayViewController(), tag: tag);
    controller.initController(
      widget.amount,
      widget.payId,
      widget.payNumber,
      widget.purType,
      widget.payType,
      widget.source,
      widget.isAddBalancePay,
      widget.isDefaultSelectedFirst,
    );
  }

  @override
  Widget build(BuildContext context) {
    /// 使用Wrap包裹，可以让子widget自适应高度
    return GetBuilder<PayViewController>(
        tag: tag,
        builder: (_) {
          return _buildContentView();
        });
  }

  /// 弹窗的内容
  _buildContentView() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: Styles.borderRaidus.mTop,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 标题
          _buildTitleView(),
          5.verticalSpace,
          const Divider(height: 0.5, thickness: 0),
          // // 支付金额
          // 15.verticalSpace,
          // _buildAmountView(),
          // 支付选项
          15.verticalSpace,
          _buildPayTypesView(),
          // //支付提示
          // 20.verticalSpace,
          // _buildTipsView(),
          // 支付按钮
          60.verticalSpace,
          _buildPayButtonView(),
          // 支付问题反馈
          // 15.verticalSpace,
          // _buildPayFeedbackView(),
          30.verticalSpace,
        ],
      ),
    );
  }

  /// 标题
  _buildTitleView() {
    return SizedBox(
      width: double.infinity,
      height: 50.w,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Text(
            '选择支付方式',
            style: TextStyle(
              color: COLOR.color_333333,
              fontSize: 16.w,
              fontWeight: FontWeight.bold,
            ),
          ),
          // Positioned(
          //   top: 0,
          //   right: 0,
          //   bottom: 0,
          //   child: Image.asset(
          //     Assets.iconClose,
          //     width: 14.w,
          //     height: 14.w,
          //   ).onTap(() => Get.back()),
          // ),
        ],
      ),
    );
  }

  /// 支付金额
  // _buildAmountView() {
  //   return Align(
  //     alignment: Alignment.centerLeft,
  //     child: EasyRichText(
  //       '支付金额：${widget.amount}元',
  //       defaultStyle: TextStyle(
  //         color: COLOR.color_666666,
  //         fontSize: 12.w,
  //       ),
  //       patternList: [
  //         EasyRichTextPattern(
  //           targetString: '${widget.amount}元',
  //           style: TextStyle(
  //             color: COLOR.color_F22F40,
  //             fontSize: 12.w,
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  /// 支付选项
  _buildPayTypesView() {
    return controller.payType.isEmpty
        ? widget.isShowNotPayType
            ? _buildNotPayTypeView()
            : const SizedBox.shrink()
        : ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            separatorBuilder: (context, index) => 15.verticalSpace,
            itemCount: controller.payType.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () =>
                    controller.currentPayType.value = controller.payType[index],
                child: Obx(() => _buildPayOptionsItemView(
                    controller.payType[index],
                    controller.currentPayType.value ==
                        controller.payType[index])),
              );
            },
          );
  }

  /// 没有支付方式
  _buildNotPayTypeView() {
    return Container(
      width: double.infinity,
      height: 50.w,
      alignment: Alignment.center,
      child: Text(
        "暂无支付方式",
        style: TextStyle(color: Colors.grey, fontSize: 14.w),
      ),
    );
  }

  /// 支付选项Item
  _buildPayOptionsItemView(RechargeTypeModel rechargeType, bool isSelected) {
    String icon;
    if (rechargeType.isAlipay) {
      icon = AppImagePath.mine_icon_pay_alipay;
    } else if (rechargeType.isWechat) {
      icon = AppImagePath.mine_icon_pay_wechat;
    } else if (rechargeType.isUnion) {
      icon = AppImagePath.mine_icon_pay_ysf;
    } else {
      icon = AppImagePath.mine_icon_pay_balance;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image.asset(icon, width: 32.w, height: 32.w),
            10.horizontalSpace,
            Text(
              rechargeType.name,
              style: TextStyle(
                color: COLOR.color_333333,
                fontSize: 16.w,
                fontWeight: FontWeight.w500,
              ),
            ),
            rechargeType.payMent == "0001" && widget.isShowBalance
                ? Text(
                    '(${controller.balance.toStringAsFixed(2)})',
                    style: TextStyle(
                      color: COLOR.color_666666,
                      fontSize: 16.w,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
        Image.asset(
          isSelected
              ? AppImagePath.mine_icon_pay_select
              : AppImagePath.mine_icon_pay_unselect,
          width: 22.w,
          height: 22.w,
        ),
      ],
    );
  }

  /// 支付提示
  // _buildTipsView() {
  //   final style = TextStyle(
  //     color: COLOR.color_666666,
  //     fontSize: 10.w,
  //   );
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text('支付提示',
  //           style: TextStyle(
  //             color: COLOR.color_333333,
  //             fontSize: 12.w,
  //           )),
  //       Text('1.跳转后请及时付款，超时支付无法到账，需要重新发起', style: style),
  //       Text('2.每天发起支付不可超过5次，连续发起且未支付，当心账号将回加入黑名单', style: style),
  //       Text('3.支付通道在夜间比较忙碌，为保证您的体验，尽量选择白天支付', style: style),
  //       Text('4.当前支付方式无法完成支付时，请切换不同支付方式尝试', style: style),
  //     ].joinHeight(8.w),
  //   );
  // }

  /// 支付按钮
  _buildPayButtonView() {
    return GestureDetector(
      onTap: () {
        if (controller.payType.isEmpty) {
          showToast("暂无支付方式");
          return;
        }
        if (controller.currentPayType.value == RechargeTypeModel.empty()) {
          showToast("请选择支付方式");
          return;
        }
        PayType payType;
        if (controller.currentPayType.value.isAlipay) {
          payType = PayTypeEnum.alipay;
        } else if (controller.currentPayType.value.isWechat) {
          payType = PayTypeEnum.wechat;
        } else if (controller.currentPayType.value.isUnion) {
          payType = PayTypeEnum.unionPay;
        } else {
          payType = PayTypeEnum.balance;
        }

        RechargeRequestModel rechargeRequest = RechargeRequestModel(
          money: "${widget.amount}",
          nums: widget.payNumber,
          purType: widget.purType,
          rechType: payType.toString(),
          source: widget.source,
          targetId: widget.payId,
        );
        if (payType == 0) {
          if (controller.balance < widget.amount) {
            showToast("余额不足");
            return;
          }
        }
        controller.startPay(rechargeRequest, widget.onPaySuccess);
      },
      child: widget.purType == PurTypeEnum.vip
          ? ImageView(
              src: AppImagePath.mine_icon_open_vip,
              width: 332.w,
              height: 40.w,
              fit: BoxFit.fitWidth,
            )
          : widget.purType == PurTypeEnum.gold
              ? ImageView(
                  src: AppImagePath.mine_coin_buy,
                  width: 332.w,
                  height: 40.w,
                  fit: BoxFit.fitWidth,
                )
              : Container(
                  width: double.infinity,
                  height: 50.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: COLOR.color_FABD95,
                    borderRadius: BorderRadius.circular(25.w),
                  ),
                  child: Text(
                    '立即付款',
                    style: TextStyle(
                      color: COLOR.color_14151D,
                      fontSize: 16.w,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
    );
  }

  /// 支付问题反馈
  // _buildPayFeedbackView() {
  //   return Container(
  //     child: !widget.isShowPayFeedback
  //         ? const SizedBox.shrink()
  //         : Center(
  //             child: RichText(
  //                 text: TextSpan(
  //               children: [
  //                 TextSpan(
  //                     text: '支付问题反馈，点击联系',
  //                     style:
  //                         TextStyle(color: COLOR.color_666666, fontSize: 12.w)),
  //                 TextSpan(
  //                   text: '在线客服',
  //                   style: TextStyle(color: COLOR.color_F52443, fontSize: 12.w),
  //                   recognizer: TapGestureRecognizer()
  //                     ..onTap = () {
  //                       if (widget.onTapPayFeedback == null) {
  //                         kOnLineService();
  //                       } else {
  //                         widget.onTapPayFeedback?.call();
  //                       }
  //                     },
  //                 ),
  //               ],
  //             )),
  //           ),
  //   );
  // }
}
