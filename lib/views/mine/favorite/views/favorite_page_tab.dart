/*
 * @Author: wangdazhuang
 * @Date: 2025-01-17 17:21:54
 * @LastEditTime: 2025-03-04 11:15:26
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /xhs_app/lib/views/mine/favorite/views/favorite_page_tab.dart
 */
import 'package:xhs_app/components/tab_bar_indicator/easy_fixed_indicator.dart';

import 'package:xhs_app/utils/color.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xhs_app/views/mine/favorite/views/mine_favorite_page.dart';

class FavoriteTabPage extends StatelessWidget {
  FavoriteTabPage({super.key});

  final List tabs = ['视频', '刷片', 'G圈', '合集'];

  Widget initList(String v) {
    return MineFavoritePage(title: v);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: TabBarView(
          children: tabs.map((v) {
            return initList(v);
          }).toList(),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text("我的收藏",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: COLOR.hexColor("#ffffff"),
            fontSize: 16.w,
            fontWeight: FontWeight.w500,
          )),
      bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: TabBar(
              tabAlignment: TabAlignment.start,
              isScrollable: true,
              labelColor: COLOR.hexColor('#B93FFF'),
              unselectedLabelColor: COLOR.hexColor('#808080'),
              indicatorColor: COLOR.hexColor('B93FFF'),
              labelStyle:
                  TextStyle(fontSize: 14.w, fontWeight: FontWeight.w600),
              unselectedLabelStyle:
                  TextStyle(fontSize: 14.w, fontWeight: FontWeight.w500),
              dividerColor: Colors.transparent,
              indicatorPadding: EdgeInsets.only(bottom: 6.w),
              indicator: EasyFixedIndicator(
                color: COLOR.hexColor('B93FFF'),
                width: 10.w,
                height: 3.w,
              ),
              tabs: tabs.map((v) => Tab(text: v)).toList())),
    );
  }
}
