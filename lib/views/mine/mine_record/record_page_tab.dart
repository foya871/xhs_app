/*
 * @Author: david wumingshi555888@gmail.com
 * @Date: 2025-02-21 22:36:01
 * @LastEditors: david wumingshi555888@gmail.com
 * @LastEditTime: 2025-03-02 09:37:20
 * @FilePath: /xhs_app/lib/views/mine/mine_record/record_page_tab.dart
 * @Description: 
 * Copyright (c) 2025 by ${git_name} email: ${git_email}, All Rights Reserved.
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xhs_app/components/tab_bar_indicator/easy_fixed_indicator.dart';
import 'package:xhs_app/utils/color.dart';
import 'package:xhs_app/utils/extension.dart';

import '../../../assets/colorx.dart';
import 'mine_record_page.dart';

class MineRecordTabPage extends StatelessWidget {
  MineRecordTabPage({super.key});

  final List tabs = ['笔记', '漫画', '小说', '写真', '内涵图', '热门短剧', '禁播奇案', '商品', '游戏'];

  Widget initList(String v) {
    return MineRecordPage(
      title: v,
    ).keepAlive;
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
      title: Text("浏览记录",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: COLOR.hexColor("#333333"),
            fontSize: 16.w,
            fontWeight: FontWeight.w600,
          )),
      bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: TabBar(
              tabAlignment: TabAlignment.start,
              isScrollable: true,
              labelColor: ColorX.color_333333,
              unselectedLabelColor: ColorX.color_999999,
              indicatorColor: COLOR.hexColor('ffffff'),
              labelStyle:
                  TextStyle(fontSize: 15.w, fontWeight: FontWeight.w600),
              unselectedLabelStyle:
                  TextStyle(fontSize: 15.w, fontWeight: FontWeight.w500),
              dividerColor: Colors.transparent,
              indicatorPadding: EdgeInsets.only(bottom: 6.w),
              indicator: EasyFixedIndicator(
                color: COLOR.hexColor('B93FFF'),
                width: 0.w,
                height: 0.w,
              ),
              tabs: tabs.map((v) => Tab(text: v)).toList())),
    );
  }
}
