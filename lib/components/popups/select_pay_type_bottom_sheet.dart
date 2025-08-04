import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:xhs_app/components/pay/model/recharge_type_model.dart';
import 'package:xhs_app/generate/app_image_path.dart';
import 'package:xhs_app/utils/ad_jump.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/utils/color.dart';

import '../../assets/styles.dart';
import '../easy_button.dart';
import '../easy_toast.dart';
import '../inkwell_button.dart';
import '../popup/bottomsheet/abstract_bottom_sheet.dart';
import '../../utils/enum.dart';
import '../../utils/extension.dart';

class DefaultSelectPayTypeBottomSheet extends SelectPayTypeBottomSheet {
  DefaultSelectPayTypeBottomSheet({
    required super.amount,
    required super.payTypes,
    super.onPay,
    super.autoBackOnPay,
  }) : super(onKf: () => kOnLineService());
}

class SelectPayTypeBottomSheet extends AbstractBottomSheet {
  final List<RechargeTypeModel> payTypes;
  final String amount;
  final FutureOrValueCallback<RechargeTypeModel, bool?>? onPay;
  final VoidCallback? onKf;
  final bool? autoBackOnPay;

  SelectPayTypeBottomSheet({
    required this.amount,
    required this.payTypes,
    this.onPay,
    this.onKf,
    this.autoBackOnPay,
  }) : super(isScrolledControlled: true);

  Widget _buildTitle() {
    return SizedBox(
      width: double.infinity,
      height: 50.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            '选择支付方式',
            style: TextStyle(
              color: COLOR.color_333333,
              fontSize: 16.w,
              fontWeight: FontWeight.bold,
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            bottom: 0,
            child: Image.asset(
              AppImagePath.icons_close,
              width: 14.w,
              height: 14.w,
            ).onTap(() => Get.back()),
          ),
        ],
      ),
    );
  }

  Widget _buildAmount() {
    final yuan = '$amount元';
    return Align(
      alignment: Alignment.centerLeft,
      child: EasyRichText(
        '支付金额：$yuan',
        defaultStyle: TextStyle(
          color: COLOR.color_666666,
          fontSize: 12.w,
        ),
        patternList: [
          EasyRichTextPattern(
            targetString: yuan,
            style: TextStyle(
              color: COLOR.color_F22F40,
              fontSize: 12.w,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPayTypes(_CheckController _) {
    if (payTypes.isEmpty) {
      return Text(
        '暂无可用支付方式',
        style: TextStyle(color: COLOR.color_333333, fontSize: 16.w),
      );
    }
    final rows = payTypes.map((model) {
      String icon;
      if (model.isAlipay) {
        icon = AppImagePath.icons_ali;
      } else if (model.isWechat) {
        icon = AppImagePath.icons_wx;
      } else if (model.isUnion) {
        icon = AppImagePath.icons_ysf;
      } else {
        icon = AppImagePath.icons_pay_balance;
      }

      final row = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(icon, width: 32.w, height: 32.w),
              10.horizontalSpace,
              Text(
                model.name,
                style: TextStyle(
                  color: COLOR.color_333333,
                  fontSize: 16.w,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
          Obx(
            () => _.isSelected(model)
                ? Image.asset(AppImagePath.icons_check_y,
                    width: 22.w, height: 22.w)
                : Image.asset(AppImagePath.icons_check,
                    width: 22.w, height: 22.w),
          )
        ],
      );

      return InkwellButton(
        height: 37.w,
        child: row,
        onTap: () => _.onTapSelect(model),
      );
    }).toList();
    return Column(children: rows.joinHeight(10.w));
  }

  Widget _buildTips() {
    final style = TextStyle(
      color: COLOR.color_666666,
      fontSize: 10.w,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('支付提示',
            style: TextStyle(
              color: COLOR.color_333333,
              fontSize: 12.w,
            )),
        Text('1.跳转后请及时付款，超时支付无法到账，需要重新发起', style: style),
        Text('2.每天发起支付不可超过5次，连续发起且未支付，当心账号将回加入黑名单', style: style),
        Text('3.支付通道在夜间比较忙碌，为保证您的体验，尽量选择白天支付', style: style),
        Text('4.当前支付方式无法完成支付时，请切换不同支付方式尝试', style: style),
      ].joinHeight(8.w),
    );
  }

  Widget _buildButton(_CheckController _) {
    return EasyButton(
      '立即付款',
      width: double.infinity,
      height: 40.w,
      textStyle: TextStyle(
        color: COLOR.color_14151D,
        fontSize: 16.w,
        fontWeight: FontWeight.bold,
      ),
      backgroundColor: COLOR.color_FABD95,
      borderRadius: Styles.borderRaidus.xxl,
      onTap: () async {
        if (_.selected.value.isEmpty) {
          EasyToast.show('没有可用支付方式');
          return;
        }
        if (onPay == null) return;

        final close = await onPay!(_.selected.value);
        if (autoBackOnPay == true || close == true) {
          Get.back();
        }
      },
    );
  }

  Widget _buildFeedback() {
    final style = TextStyle(color: COLOR.color_666666, fontSize: 10.w);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('支付问题反馈，点击', style: style),
        InkwellButton(
          width: 48.w,
          height: 17.w,
          onTap: onKf,
          child: Text(
            '在线客服',
            style: style.copyWith(color: COLOR.color_F52443),
          ),
        )
      ],
    );
  }

  Widget _buildBody(_CheckController _) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: Styles.borderRaidus.mTop,
          ),
          child: Column(
            children: [
              _buildTitle(),
              5.verticalSpace,
              const Divider(height: 0.5, thickness: 0),
              15.verticalSpace,
              _buildAmount(),
              15.verticalSpace,
              _buildPayTypes(_),
              20.verticalSpace,
              _buildTips(),
              20.verticalSpace,
              _buildButton(_),
              15.verticalSpace,
              _buildFeedback(),
              30.verticalSpace,
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build() {
    return GetBuilder<_CheckController>(
      init: _CheckController(defaultSelected: payTypes.firstOrNull),
      builder: (_) => _buildBody(_),
    );
  }
}

class _CheckController extends GetxController {
  final RechargeTypeModel? _default;
  final selected = RechargeTypeModel.empty().obs;

  _CheckController({required RechargeTypeModel? defaultSelected})
      : _default = defaultSelected;

  bool isSelected(RechargeTypeModel model) =>
      model.payMent == selected.value.payMent;

  void onTapSelect(RechargeTypeModel model) => selected.value = model;

  @override
  void onInit() {
    if (_default != null) {
      selected.value = _default;
    }
    super.onInit();
  }
}
