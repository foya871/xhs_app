import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xhs_app/utils/color.dart';

class DefaultDivider extends StatelessWidget {
  final Color? color;
  final double? height;
  final double? thickness;
  final double? marginTop;
  final double? marginBottom;
  final double? marginLeft;
  final double? marginRight;
  final double? marginHorizontal;
  final double? marginVertical;

  const DefaultDivider({
    super.key,
    this.color,
    this.height,
    this.thickness,
    this.marginTop,
    this.marginBottom,
    this.marginLeft,
    this.marginRight,
    this.marginHorizontal,
    this.marginVertical,
  });

  EdgeInsets _calcMargin() {
    double top = (marginVertical ?? .0) + (marginTop ?? .0);
    double bottom = (marginVertical ?? .0) + (marginBottom ?? .0);
    double left = (marginHorizontal ?? .0) + (marginLeft ?? .0);
    double right = (marginHorizontal ?? .0) + (marginRight ?? .0);
    return EdgeInsets.only(top: top, bottom: bottom, left: left, right: right);
  }

  @override
  Widget build(BuildContext context) => Container(
        margin: _calcMargin(),
        child: Divider(
          color: color ?? COLOR.color_EEEEEE,
          height: height ?? 1.w,
          thickness: thickness,
        ),
      );
}
