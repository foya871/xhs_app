import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:xhs_app/components/app_bg_view.dart';
import 'package:xhs_app/utils/color.dart';

///自定义toast
showToast(String message) {
  SmartDialog.showToast(
    message,
    alignment: Alignment.center,
    builder: (context) {
      return Container(
        decoration: BoxDecoration(
          color: COLOR.translucent_50,
          borderRadius: BorderRadius.circular(5.w),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Text(
          message,
          style: TextStyle(
            color: COLOR.white,
            fontSize: 16.w,
          ),
        ),
      );
    },
  );
}

dismiss({String? tag}) {
  SmartDialog.dismiss(tag: tag);
}

showAlertDialog(
  BuildContext context, {
  double? width,
  double? height,
  Widget? titleWidget,
  String? title,
  TextStyle? titleTextStyle,
  Color? titleTextColor,
  String? message,
  TextStyle? messageTextStyle,
  Color? messageTextColor,
  TextAlign? messageTextAlign,
  Widget? content,
  String leftText = "取消",
  String rightText = "确定",
  TextStyle? leftTextStyle,
  TextStyle? rightTextStyle,
  Color? leftTextColor,
  Color? rightTextColor,
  VoidCallback? onLeftButton,
  VoidCallback? onRightButton,
  Color? leftBgColor,
  Color? rightBgColor,
  String? leftImage,
  String? rightImage,
  bool clickMaskDismiss = false,
  bool isSingleButton = false,
  VoidCallback? onMask,
  Color? backgroundColor,
  String? backgroundImage,
}) {
  SmartDialog.show(
    clickMaskDismiss: clickMaskDismiss,
    onMask: onMask,
    builder: (context) {
      return Container(
        width: width ?? 286.w,
        height: height,
        decoration: BoxDecoration(
          color: backgroundColor ?? COLOR.color_F8F8F8,
          borderRadius: BorderRadius.circular(12.w),
          image: backgroundImage != null
              ? DecorationImage(
                  image: AssetImage(backgroundImage),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            20.verticalSpace,
            titleWidget ??
                Text(
                  title ?? "",
                  style: titleTextStyle ??
                      TextStyle(
                        color: titleTextColor ?? COLOR.color_333333,
                        fontSize: 15.w,
                        fontWeight: FontWeight.w600,
                      ),
                ),
            20.verticalSpace,
            content ??
                Text(
                  message ?? "",
                  style: messageTextStyle ??
                      TextStyle(
                        color: messageTextColor ?? COLOR.color_898A8E,
                        fontSize: 13.w,
                      ),
                  textAlign: messageTextAlign ?? TextAlign.start,
                ),
            27.verticalSpace,
            Row(
              children: [
                Visibility(
                    visible: !isSingleButton,
                    child: Expanded(
                        flex: 1,
                        child: AppBgView(
                          width: double.infinity,
                          height: 40.w,
                          backgroundColor: leftBgColor ?? COLOR.color_EEEEEE,
                          imagePath: leftImage,
                          radius: 20.w,
                          text: leftText,
                          textSize: 14.w,
                          textColor: leftTextColor ?? COLOR.color_666666,
                          onTap: () {
                            dismiss();
                            onLeftButton?.call();
                          },
                        ))),
                Visibility(
                  visible: !isSingleButton,
                  child: 16.horizontalSpace,
                ),
                Expanded(
                    flex: 1,
                    child: AppBgView(
                      width: double.infinity,
                      height: 40.w,
                      backgroundColor:
                          rightBgColor ?? COLOR.hexColor("#fb2d45"),
                      imagePath: rightImage,
                      radius: 20.w,
                      text: rightText,
                      textSize: 13.w,
                      textColor: rightTextColor ?? COLOR.white,
                      onTap: () {
                        dismiss();
                        onRightButton?.call();
                      },
                    )),
              ],
            ),
            20.verticalSpace,
          ],
        ),
      );
    },
  );
}
