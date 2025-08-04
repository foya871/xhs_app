import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/utils/color.dart';

import '../../../assets/styles.dart';
import '../../../generate/app_image_path.dart';
import '../../../utils/extension.dart';
import '../../easy_button.dart';
import 'abstract_bottom_sheet.dart';

class BaseConfirmBuyBottomSheet extends AbstractBottomSheet {
  ///
  String? titleText;
  TextStyle? titleStyle;
  Widget? titleWidget;

  ///
  bool showClose;
  Widget? closeWidget;
  VoidCallback? onTapClose;
  bool autoBackOnTapClose;

  ///
  String? desc1Text;
  TextStyle? desc1Style;
  Widget? desc1Widget;

  ///
  String? desc2Text;
  TextStyle? desc2Style;
  Widget? desc2Widget;

  ///
  String? priceText;
  TextStyle? priceStyle;
  Widget? priceWidget;

  ///
  String? confirmText;
  TextStyle? confirmStyle;
  VoidCallback? onTapConfirm;
  bool autoBackOnTapConfirm;

  BaseConfirmBuyBottomSheet({
    this.titleText,
    this.titleStyle,
    this.titleWidget,
    this.closeWidget,
    this.showClose = true,
    this.onTapClose,
    this.autoBackOnTapClose = true,
    this.desc1Text,
    this.desc1Style,
    this.desc1Widget,
    this.desc2Text,
    this.desc2Style,
    this.desc2Widget,
    this.priceText,
    this.priceStyle,
    this.priceWidget,
    this.confirmText,
    this.confirmStyle,
    this.onTapConfirm,
    this.autoBackOnTapConfirm = false,
  }) : super(
          isDismissible: true,
          backgroundColor: COLOR.white,
          borderRadius: Styles.borderRadius.top(12.w),
        );

  Widget? _buildTitle() {
    Widget? widget = titleWidget;
    if (widget == null) {
      if (titleText != null) {
        widget = Text(
          titleText!,
          style: titleStyle ??
              TextStyle(
                fontSize: Styles.fontSize.m,
                fontWeight: FontWeight.w500,
              ),
        );
      }
    }
    return widget;
  }

  Widget? _buildClose() {
    if (!showClose) return null;
    return closeWidget ??
        Image.asset(
          AppImagePath.icons_close,
          width: 13.w,
          height: 13.w,
        ).onTap(() {
          if (autoBackOnTapClose) {
            Get.back();
          }
          onTapClose?.call();
        });
  }

  Widget? _buildDesc1() {
    Widget? widget = desc1Widget;
    if (widget == null) {
      if (desc1Text != null) {
        widget = Text(
          desc1Text!,
          style: desc1Style ??
              TextStyle(
                fontSize: Styles.fontSize.sm,
                fontWeight: FontWeight.w500,
              ),
        );
      }
    }
    return widget;
  }

  Widget? _buildDesc2() {
    Widget? widget = desc2Widget;
    if (widget == null) {
      if (desc2Text != null) {
        widget = Text(
          desc2Text!,
          style: desc2Style ??
              TextStyle(
                color: COLOR.color_666666,
                fontSize: Styles.fontSize.sm,
              ),
        );
      }
    }
    return widget;
  }

  Widget? _buildPrice() {
    Widget? widget = priceWidget;
    if (widget == null) {
      if (priceText != null) {
        widget = Text(
          priceText!,
          style: priceStyle ??
              TextStyle(
                fontSize: 24.w,
                color: COLOR.color_FB2D45,
                fontWeight: FontWeight.w500,
              ),
        );
      }
    }
    return widget;
  }

  Widget? _buildConfirm() {
    if (confirmText == null) return null;
    return EasyButton(
      confirmText!,
      width: double.infinity,
      height: 40.w,
      borderRadius: Styles.borderRaidus.all(30.w),
      backgroundColor: COLOR.color_FB2D45,
      textStyle: TextStyle(
        color: COLOR.white,
        fontSize: Styles.fontSize.sm,
      ),
      onTap: () {
        if (autoBackOnTapConfirm) {
          Get.back();
        }
        onTapConfirm?.call();
      },
    );
  }

  Widget _buildColumn() {
    Widget? title = _buildTitle();
    final close = _buildClose();
    final desc1 = _buildDesc1();
    final desc2 = _buildDesc2();
    final name = _buildPrice();
    final button = _buildConfirm();
    Widget? titleWidget;
    if (close == null) {
      titleWidget = title;
    } else {
      title ??= const SizedBox.shrink();
      titleWidget = Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [title],
          ),
          Positioned.fill(
            child: Align(alignment: Alignment.centerRight, child: close),
          ),
        ],
      );
    }

    final children = <Widget>[];
    if (titleWidget != null) children.add(titleWidget);
    if (desc1 != null) children.add(desc1.marginTop(35.w));
    if (desc2 != null) children.add(desc2.marginTop(10.w));
    if (name != null) children.add(name.marginTop(35.w));
    final upper = Column(children: children);
    final bottom = (button ?? const SizedBox.shrink()).marginBottom(15.w);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [upper, bottom],
    );
  }

  @override
  Widget build() {
    final height = 290.w;
    return Container(
      height: height,
      padding: EdgeInsets.symmetric(vertical: 15.w, horizontal: 14.w),
      alignment: Alignment.center,
      child: _buildColumn(),
    );
  }
}
