import 'package:xhs_app/components/tab_bar_indicator/easy_fixed_indicator.dart';

import 'package:xhs_app/utils/color.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../assets/colorx.dart';
import 'mine_buy_page.dart';

class MineBuyTabPage extends StatelessWidget {
  MineBuyTabPage({super.key});

  final List tabs = ['笔记', '热门短剧', '禁播奇案', '商品', '游戏'];

  Widget initList(String v) {
    return MinesBuyPage(title: v);
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
      title: Text("我的购买",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: COLOR.hexColor("#333333"),
            fontSize: 16.w,
            fontWeight: FontWeight.w600,
          )),
      bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
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
