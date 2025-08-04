/*
 * @Author: wangdazhuang
 * @Date: 2024-08-21 14:23:37
 * @LastEditTime: 2025-01-06 19:15:43
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /xhs_app/lib/assets/styles.dart
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xhs_app/generate/app_image_path.dart';

const _am = 0xff000000; // alpha max

@Deprecated('Use [COLOR]')
class _Color {
  // final transparent = Colors.transparent;
  final bgColor = const Color(_am | 0xfafafa);
}

class _Gradient {
  Gradient get orangeToPink => const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Color(_am | 0xf78248),
          Color(_am | 0xf52c0f),
          Color(_am | 0xf5019a)
        ],
      );

  Gradient get pinkToBule => const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [Color(_am | 0xff01ed), Color(_am | 0x3137ff)],
      );

  Gradient get purpleDeepToLight => const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [Color(_am | 0xA62DE4), Color(_am | 0xD47FFF)],
      );

  // Gradient get videoCellShadow => const LinearGradient(colors: [
  //       Color.fromRGBO(0, 0, 0, 0.6),
  //       Color.fromRGBO(0, 0, 0, 0),
  //     ], begin: Alignment.bottomCenter, end: Alignment.topCenter);

  ////渐变色 用图片代替，上面那种方式有些耗费性能
  DecorationImage get gradientImage => const DecorationImage(
        image: AssetImage(AppImagePath.icons_ic_gradient),
        fit: BoxFit.fill,
        repeat: ImageRepeat.noRepeat,
      );
}

@Deprecated('')
class _FontSize {
  final xxxl = 26.w;
  final xxl = 24.w;
  final xl = 22.w;
  final l = 20.w;
  final lm = 18.w;
  final m = 16.w;
  final sm = 14.w;
  final s = 12.w;
  final xs = 10.w;
  final xxs = 8.w;
  //
  final pageTitle = 18.w;
  final appBarTitle = 18.w;
}

class _BorderRaidus {
  BorderRadius get xxl => all(20.w);
  BorderRadius get xl => all(16.w);
  BorderRadius get l => all(12.w);
  BorderRadius get m => all(8.w);
  BorderRadius get s => all(6.w);
  BorderRadius get xs => all(4.w);

  BorderRadius all(double r) => BorderRadius.circular(r);
  BorderRadius top(double r) => BorderRadius.vertical(top: Radius.circular(r));
  BorderRadius bottom(double r) =>
      BorderRadius.vertical(bottom: Radius.circular(r));
  BorderRadius left(double r) =>
      BorderRadius.horizontal(left: Radius.circular(r));
  BorderRadius right(double r) =>
      BorderRadius.horizontal(right: Radius.circular(r));
  // 对角(上) 左下-右上
  BorderRadius diagonalUp(double r) => BorderRadius.only(
      bottomLeft: Radius.circular(r), topRight: Radius.circular(r));
  // 对角(下) 左上-右下
  BorderRadius diagonalDown(double r) => BorderRadius.only(
      topLeft: Radius.circular(r), bottomRight: Radius.circular(r));

  BorderRadius get toast => BorderRadius.circular(12.w);

  BorderRadius get mTop => top(8.w);
  BorderRadius get xsLeft => left(4.w);

  // 对角 左下-右上
  BorderRadius get mDiagonalRight => BorderRadius.only(
      topRight: Radius.circular(8.w), bottomLeft: Radius.circular(8.w));
  // 右下
  BorderRadius get mRightBottom =>
      BorderRadius.only(bottomRight: Radius.circular(8.w));
  // 左下
  BorderRadius get mLeftBottom =>
      BorderRadius.only(bottomLeft: Radius.circular(8.w));
  // 左上
  BorderRadius get mLeftTop => BorderRadius.only(topLeft: Radius.circular(8.w));
// 右下左上
  BorderRadius get mRightBottomTopLeft => BorderRadius.only(
      bottomRight: Radius.circular(8.w), topLeft: Radius.circular(8.w));
//左下右下
  BorderRadius get mBottomLR => BorderRadius.only(
      bottomLeft: Radius.circular(8.w), bottomRight: Radius.circular(8.w));
}

class _Radius {
  Radius get l => Radius.circular(12.r);
  Radius get m => Radius.circular(8.r);
  Radius get s => Radius.circular(6.r);
  Radius get xs => Radius.circular(4.r);
}

abstract class Styles {
  Styles._();

  static final color = _Color();
  static final fontSize = _FontSize();
  static final gradient = _Gradient();
  static final borderRaidus = _BorderRaidus();
  static final borderRadius = _BorderRaidus();
  static final radius = _Radius();
}

kTextStyle(
  Color color, {
  double? fontsize,
  FontWeight? weight,
}) {
  return TextStyle(color: color, fontSize: fontsize, fontWeight: weight);
}
