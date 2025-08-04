import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../abstract_popup.dart';

abstract class AbstractBottomSheet<T> extends AbstractPopup {
  final bool isDismissible;
  final Color? barrierColor;
  final Color? backgroundColor;
  final bool ignoreSafeArea;
  final bool isScrolledControlled;
  final BorderRadius borderRadius;

  AbstractBottomSheet({
    this.isDismissible = true,
    this.barrierColor,
    this.backgroundColor,
    this.ignoreSafeArea = false,
    this.isScrolledControlled = false,
    this.borderRadius = BorderRadius.zero,
  });

  @override
  Future<T?> show() {
    return Get.bottomSheet(
      build(),
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
      isDismissible: isDismissible,
      barrierColor: barrierColor,
      backgroundColor: backgroundColor,
      enableDrag: false,
      useRootNavigator: false,
      ignoreSafeArea: ignoreSafeArea,
      isScrollControlled: isScrolledControlled,
    );
  }
}
