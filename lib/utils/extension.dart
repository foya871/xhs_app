import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/app.dart';
import 'package:xhs_app/utils/color.dart';
import 'package:tuple/tuple.dart';

import '../components/keep_alive_wrapper.dart';
import 'utils.dart';

extension WidgetSliver on Widget {
  Widget get sliver => SliverToBoxAdapter(child: this);

  Widget sliverOr(bool sliver) =>
      sliver ? SliverToBoxAdapter(child: this) : this;
}

extension WidgetAlignExtensions on Widget {
  Widget get center => Align(alignment: Alignment.center, child: this);
  Widget get centerLeft => Align(alignment: Alignment.centerLeft, child: this);
}

extension WidgetColor on Widget {
  Widget color(Color? c) => c != null ? Container(color: c, child: this) : this;
}

extension WidgetBorderRadius on Widget {
  Widget borderRadius(BorderRadiusGeometry? r) => r != null
      ? Container(decoration: BoxDecoration(borderRadius: r), child: this)
      : this;
}

final _baseSpace = 14.w;

extension WidgetMarginPadding on Widget {
  // 左右 base margin
  Widget get baseMarginHorizontal => marginHorizontal(_baseSpace);

  // 上下 base margin
  Widget get baseMarginVertical => marginVertical(_baseSpace);

  // 左上右margin
  Widget get baseMarginLtr => Container(
        margin: EdgeInsets.only(top: 5.w, left: _baseSpace, right: _baseSpace),
        child: this,
      );
  Widget get baseMarginLt => Container(
        margin: EdgeInsets.only(top: 5.w, left: _baseSpace),
        child: this,
      );
  Widget get baseMarginL => Container(
        margin: EdgeInsets.only(left: _baseSpace),
        child: this,
      );
  Widget get baseMarginR => Container(
        margin: EdgeInsets.only(right: _baseSpace),
        child: this,
      );
  Widget get baseMarginT => Container(
        margin: EdgeInsets.only(top: 5.w),
        child: this,
      );

  // 左右 margin
  Widget marginVertical(double? vertical) => vertical != null
      ? Container(
          margin: EdgeInsets.symmetric(vertical: vertical),
          child: this,
        )
      : this;

  // 上下 margin
  Widget marginHorizontal(double? horizontal) => horizontal != null
      ? Container(
          margin: EdgeInsets.symmetric(horizontal: horizontal),
          child: this,
        )
      : this;

  Widget marginLeft(double? left) => left != null
      ? Container(
          margin: EdgeInsets.only(left: left),
          child: this,
        )
      : this;

  Widget marginTop(double? top) => top != null
      ? Container(
          margin: EdgeInsets.only(top: top),
          child: this,
        )
      : this;

  Widget marginBottom(double? bottom) => bottom != null
      ? Container(
          margin: EdgeInsets.only(bottom: bottom),
          child: this,
        )
      : this;

  Widget marginRight(double? right) => right != null
      ? Container(
          margin: EdgeInsets.only(right: right),
          child: this,
        )
      : this;

  // 左右 base padding
  Widget get basePaddingHorizontal => Container(
        padding: EdgeInsets.symmetric(horizontal: _baseSpace),
        child: this,
      );

  // 上下 base padding
  Widget get basePaddingVertical => Container(
        padding: EdgeInsets.symmetric(vertical: _baseSpace),
        child: this,
      );

  // 左上下 base padding
  Widget get basePaddingLtr => Container(
        padding: EdgeInsets.only(
          top: _baseSpace,
          left: _baseSpace,
          right: _baseSpace,
        ),
        child: this,
      );

  // 左右padding
  Widget paddingVertical(double? vertical) => vertical != null
      ? Padding(
          padding: EdgeInsets.symmetric(vertical: vertical),
          child: this,
        )
      : this;

  Widget paddingHorizontal(double? horizontal) => horizontal != null
      ? Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontal),
          child: this,
        )
      : this;

  Widget sliverPaddingHorizontal(double? horizontal) => horizontal != null
      ? SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: horizontal),
          sliver: this,
        )
      : this;

  Widget paddingTop(double? top) => top != null
      ? Padding(padding: EdgeInsets.only(top: top), child: this)
      : this;

  Widget paddingLeft(double? left) => left != null
      ? Padding(padding: EdgeInsets.only(left: left), child: this)
      : this;

  Widget sliverPaddingLeft(double? left) => left != null
      ? SliverPadding(padding: EdgeInsets.only(left: left), sliver: this)
      : this;

  Widget paddingRight(double? right) => right != null
      ? Padding(padding: EdgeInsets.only(right: right), child: this)
      : this;
  Widget sliverPaddingRight(double? right) => right != null
      ? SliverPadding(padding: EdgeInsets.only(right: right), sliver: this)
      : this;
  Widget paddingBottom(double? bottom) => bottom != null
      ? Padding(padding: EdgeInsets.only(bottom: bottom), child: this)
      : this;

  Widget paddingAll(double? value) => value != null
      ? Padding(padding: EdgeInsets.all(value), child: this)
      : this;

  Widget padding(EdgeInsets? padding) =>
      padding != null ? Padding(padding: padding, child: this) : this;
}

extension GestureDetectorExtensions on Widget {
  Widget onTap(VoidCallback? onTap) => onTap != null
      ? GestureDetector(
          onTap: onTap,
          child: this,
        )
      : this;

  Widget onOpaqueTap(VoidCallback? onTap) => onTap != null
      ? GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: this,
        )
      : this;
}

extension KeepAliveExtensions on Widget {
  Widget get keepAlive => KeepAliveWrapper(child: this);
  // Widget get keepAlive => this;
}

extension ListExtensions<E> on List<E> {
  List<E> trimLeading(bool Function(E e) test) {
    final index = indexWhere(test);
    if (index == -1) return this;
    final start = index + 1;
    if (start >= length - 1) {
      return [];
    }
    return sublist(start);
  }

  // 向指定位置插入，长度不够则add
  List<E> insertOrAdd(int index, E e) {
    if (index < length) {
      insert(index, e);
    } else {
      add(e);
    }
    return this;
  }
}

extension ListWidgetExtensions on List<Widget> {
  List<Widget> joinSeperator(
    Widget sep, {
    bool head = false,
    bool tail = false,
  }) =>
      Utils.widgetsJoinSeperator(this, sep, head: head, tail: tail);

  List<Widget> joinWidth(
    double? width, {
    bool head = false,
    bool tail = false,
    bool silver = false,
  }) =>
      width != null && width > 0
          ? joinSeperator(
              silver ? SizedBox(width: width).sliver : SizedBox(width: width),
              head: head,
              tail: tail,
            )
          : this;

  List<Widget> joinHeight(
    double? height, {
    bool head = false,
    bool tail = false,
    bool silver = false,
  }) =>
      height != null && height > 0
          ? joinSeperator(
              silver
                  ? SizedBox(height: height).sliver
                  : SizedBox(height: height),
              head: head,
              tail: tail,
            )
          : this;
}

extension PathPointExtensions on Path {
  lineToPoint(Point<double> point) => lineTo(point.x, point.y);
  moveToPoint(Point<double> point) => moveTo(point.x, point.y);
}

extension ScrollControllerExtensions on ScrollController {
  void jumpToBottomIfNecessary() {
    final maxScrollExtent = position.maxScrollExtent;
    final current = offset;

    if (maxScrollExtent > current) {
      jumpTo(maxScrollExtent);
    }
  }
}

extension DoubleExtension on double {
  // 1.0 -> 1
  // 1.234 => 1.234
  String toStringAsShort() => '$this'.trimTrailing('0').trimTrailing('.');
}

extension StringExtension on String {
  String trimLeading(String pattern) {
    if (pattern.isEmpty) return this;
    var i = 0;
    while (startsWith(pattern, i)) {
      i += pattern.length;
    }
    return substring(i);
  }

  String trimTrailing(String pattern) {
    if (pattern.isEmpty) return this;
    var i = length;
    while (startsWith(pattern, i - pattern.length)) {
      i -= pattern.length;
    }
    return substring(0, i);
  }

  String trimString(String pattern) =>
      trimLeading(pattern).trimTrailing(pattern);
}

extension DateTimeExtension on DateTime {
  DateTime beginningOfMonth(int next) {
    var newYear = year + next ~/ 12;
    var newMonth = 0;
    if (next >= 0) {
      newMonth = month + next % 12;
    } else {
      newMonth = month - ((-next) % 12);
    }
    if (newMonth > 12) {
      newYear++;
      newMonth = newMonth % 12;
    } else if (newMonth <= 0) {
      newYear--;
      newMonth = 12 + newMonth;
    }
    return DateTime(newYear, newMonth, 1);
  }
}

extension TabControllerExtension on TabController {
  // 监听动画，滑到一半就回调
  // 相同index会产生多次回调，外部处理
  // 两个都需要监听,动画只能监听滑动，不能监听点击
  Tuple2<VoidCallback, VoidCallback> makeFastListener(
      void Function(int) listener) {
    return Tuple2(
      () {
        listener(index);
      },
      () {
        final current = index;
        final index_ = current + offset.round();
        if (index_ != current) {
          listener(index_);
        }
      },
    );
  }

  void addFastListenerTuple(Tuple2<VoidCallback, VoidCallback> listener) {
    addListener(listener.item1);
    animation?.addListener(listener.item2);
  }

  void removeFasterListenerTuple(Tuple2<VoidCallback, VoidCallback> listener) {
    removeListener(listener.item1);
    animation?.removeListener(listener.item2);
  }

  void addFastListener(void Function(int) listener) {
    addFastListenerTuple(makeFastListener(listener));
  }
}

extension GetExtension on GetInterface {
  showDialog({
    String? title,
    String? content,
    String backText = '取消',
    String nextText = '确定',
    VoidCallback? backTap,
    VoidCallback? nextTap,
  }) {
    return Get.dialog(Center(
      child: Container(
        width: 310.w,
        height: 166.w,
        padding:
            EdgeInsets.only(left: 32.w, right: 32.w, top: 20.w, bottom: 20.w),
        decoration: BoxDecoration(
          color: COLOR.hexColor("#2C2C2C"),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              title ?? "温馨提示",
              style: TextStyle(color: COLOR.white, fontSize: 16.w),
            ),
            if (content != null && content.isNotEmpty)
              Text(
                content,
                style:
                    TextStyle(color: COLOR.hexColor("#898A8E"), fontSize: 14.w),
              ).marginTop(20.w),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 112.w,
                  height: 36.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: COLOR.hexColor("#666666"),
                    borderRadius: BorderRadius.circular(18.w),
                  ),
                  child: Text(
                    backText,
                    strutStyle: StrutStyle.fromTextStyle(TextStyle(
                      color: COLOR.hexColor("#CFCFCF"),
                      fontSize: 16.w,
                      height: 22 / 16,
                    )),
                    style: TextStyle(
                      color: COLOR.hexColor("#CFCFCF"),
                      fontSize: 16.w,
                      height: 22 / 16,
                    ),
                  ),
                ).onTap(() {
                  Get.back();
                  if (backTap != null) {
                    backTap.call();
                  }
                }),
                Container(
                  width: 112.w,
                  height: 36.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: COLOR.hexColor("#B93FFF"),
                    borderRadius: BorderRadius.circular(18.w),
                  ),
                  child: Text(
                    nextText,
                    strutStyle: StrutStyle.fromTextStyle(TextStyle(
                      color: COLOR.hexColor("#FFFFFF"),
                      fontSize: 16.w,
                      height: 22 / 16,
                    )),
                    style: TextStyle(
                      color: COLOR.hexColor("#FFFFFF"),
                      fontSize: 16.w,
                      height: 22 / 16,
                    ),
                  ),
                ).onTap(() {
                  Get.back();
                  if (nextTap != null) {
                    nextTap.call();
                  }
                }),
              ],
            ).marginTop(20.w)
          ],
        ),
      ),
    ));
  }
}

extension NiceGet on GetInterface {
  void untilNamed(String name) => until((r) => r.settings.name == name);

  // 保证路由中只有一个页面，并且都是新push的
  Future<T?>? offUniqueNamed<T>(
    String page, {
    dynamic arguments,
    int? id,
    Map<String, String>? parameters,
  }) {
    if (MainApp.customNavigatorObserver.hasNamedRoute(page)) {
      // pop 到 之前的页面
      until((e) => e.settings.name == page);
      // replace
      return offNamed(
        page,
        arguments: arguments,
        id: id,
        preventDuplicates: false,
        parameters: parameters,
      );
    } else {
      return toNamed(
        page,
        arguments: arguments,
        id: id,
        preventDuplicates: true,
        parameters: parameters,
      );
    }
  }
}
