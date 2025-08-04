
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../assets/colorx.dart';

class WidgetUtils{


  ///构建文本框
  static Widget buildTextField(double? width, double? height, double textSize,
      Color textColor, String? hint,
      {Color backgroundColor = Colors.white,
        Color hintColor = ColorX.color_5b6d7b,
        String? defText,
        ValueChanged<String>? onChanged,
        TextInputType? inputType,
        bool obscureText = false,
        bool autofocus = false,
        bool enabled = true,
        bool suffixIcon = false,
        int maxLines = 1,
        int? maxLength,
        EdgeInsetsGeometry? padding,
        TextEditingController? controller,
        BorderRadius? borderRadius,
        TextAlign textAlign = TextAlign.start,
        List<TextInputFormatter>? inputFormatters,
        InputBorder? focusedBorder,
        FocusNode? focusNode}) {

    padding ??= EdgeInsets.symmetric(horizontal: 10.w);
    controller ??= TextEditingController.fromValue(
    TextEditingValue(text: defText ?? "",
    selection: TextSelection.fromPosition(TextPosition(
    affinity: TextAffinity.downstream,
    offset: defText?.length??0))));

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius,
      ),
      padding: padding,
      width: width,
      height: height,
      alignment: Alignment.center,
      child: suffixIcon
          ? Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              (defText == "" ? hint : defText) ?? "",
              style: TextStyle(
                  fontSize: textSize,
                  color: defText == "" ? hintColor : textColor,
                  overflow: TextOverflow.ellipsis),
              textAlign: textAlign,
            ),
          ),
          // Icon(Icons.keyboard_arrow_down,size: 18.r,color: Colors.black54),
        ],
      )
          : TextField(
        autofocus: autofocus,
        enabled: enabled,
        // cursorHeight: textSize,
        cursorColor: ColorX.color_091722,
        maxLines: maxLines,
        maxLength: maxLength,
        focusNode: focusNode,
        controller: controller,
        onChanged: onChanged,
        keyboardType: inputType,
        inputFormatters: inputFormatters,
        obscureText: obscureText,
        textAlign: textAlign,
        style: TextStyle(fontSize: textSize, color: textColor,fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
          enabled: enabled,
          isCollapsed: true,
          errorBorder: InputBorder.none,
          focusedBorder: focusedBorder,
          focusedErrorBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintStyle: TextStyle(fontSize: textSize, color: hintColor),
          labelStyle: TextStyle(fontSize: textSize, color: hintColor),
          errorStyle: TextStyle(fontSize: textSize, color: hintColor),
        ),
      ),
    );
  }

  static Widget buildElevatedButton(String text, double width, double height,
      {Color? backgroundColor,
        Color textColor = Colors.white,
        double textSize = 14,
        TextAlign? textAlign,
        BorderRadius? borderRadius,
        VoidCallback? onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.zero,
        ),
        backgroundColor: backgroundColor,
        minimumSize: Size(width, height),
        maximumSize: Size(width, height),
        padding: EdgeInsets.zero,
      ),
      child: Text(
        text,
        textAlign: textAlign,
        style: TextStyle(
            fontSize: textSize.sp,
            color: textColor,
            fontWeight: FontWeight.w700),
      ),
    );
  }

}



