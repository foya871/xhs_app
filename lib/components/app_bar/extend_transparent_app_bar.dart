import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xhs_app/utils/color.dart';
import 'package:xhs_app/utils/consts.dart';

class ExtendTransparentAppBar extends AppBar {
  final bool showBack;
  final Color? backColor;

  ExtendTransparentAppBar({
    this.showBack = true,
    this.backColor,
    super.key,
    super.title,
    super.centerTitle,
    super.leadingWidth,
    super.actionsIconTheme,
    super.actions,
  }) : super(
          backgroundColor: COLOR.transparent,
          automaticallyImplyLeading: showBack,
          elevation: 0,
          leading: backColor != null
              ? IconButton(
                  onPressed: () => Get.back(),
                  icon: Icon(
                    Consts.defaultBackButtonIcon,
                    color: backColor,
                  ),
                )
              : null,
        );
}
