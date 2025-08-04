/*
 * @Author: ziqi jhzq12345678
 * @Date: 2024-09-10 19:22:33
 * @LastEditors: wangdazhuang
 * @LastEditTime: 2025-02-20 10:56:57
 * @FilePath: /xhs_app/lib/components/navigation_bar/easy_bottom_navigation_bar.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xhs_app/utils/color.dart';

class EasyBottomNavigationBar extends BottomNavigationBar {
  EasyBottomNavigationBar.common({
    super.key,
    required super.items,
    required super.currentIndex,
    required super.onTap,
    bool showLabels = true,
  }) : super(
          showSelectedLabels: showLabels,
          showUnselectedLabels: showLabels,
          elevation: 0,
          backgroundColor: Colors.white,
          unselectedItemColor: COLOR.hexColor("#999999"),
          selectedItemColor: Colors.black,
          selectedLabelStyle:
              TextStyle(fontSize: 15.w, fontWeight: FontWeight.w500),
          unselectedLabelStyle:
              TextStyle(fontSize: 15.w, fontWeight: FontWeight.w500),
          type: BottomNavigationBarType.fixed,
        );
}
