import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xhs_app/utils/color.dart';

class AppBarView extends StatelessWidget implements PreferredSizeWidget {
  Widget? title;
  String? titleText;
  double? titleSpacing;
  List<Widget>? actions;
  PreferredSizeWidget? bottom;
  double? elevation;
  bool? primary;
  bool? isShowBottomLine;
  TextStyle? titleStyle;

  AppBarView({
    super.key,
    this.title,
    this.titleText,
    this.titleSpacing,
    this.actions,
    this.elevation,
    this.bottom,
    this.primary,
    this.isShowBottomLine,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title ??
          Text(titleText ?? '',
              overflow: TextOverflow.ellipsis,
              style: titleStyle ??
                  TextStyle(
                    fontSize: 16.w,
                    fontWeight: FontWeight.w600,
                    color: COLOR.color_333333,
                  )),
      titleSpacing: titleSpacing,
      actions: actions,
      bottom: isShowBottomLine == true
          ? PreferredSize(
              preferredSize: preferredSize,
              child: Divider(
                color: COLOR.color_F0F0F0,
                thickness: 1.h,
              ),
            )
          : bottom,
      elevation: elevation ?? 0,
      primary: primary ?? true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
