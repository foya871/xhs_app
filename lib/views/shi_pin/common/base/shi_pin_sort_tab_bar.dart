import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tuple/tuple.dart';

import '../../../../components/short_widget/video_layout_button.dart';
import '../../../../utils/color.dart';
import '../../../../utils/enum.dart';
import '../../../../utils/extension.dart';
import 'shi_pin_sort_layout_controller.dart';

class ShiPinSortTabBar extends StatelessWidget {
  static const tabs = [
    Tuple2<String, int>('最近更新', VideoSortTypeEnum.latest),
    Tuple2<String, int>('最多观看', VideoSortTypeEnum.mostPlayed),
    Tuple2<String, int>('最多购买', VideoSortTypeEnum.mostSale),
    Tuple2<String, int>('十分钟以上', VideoSortTypeEnum.minute10),
  ];
  static int get tabsLength => tabs.length;
  static int get defaultIndex =>
      tabs.indexWhere((e) => e.item2 == VideoSortTypeEnum.latest);
  static int getSortType(int index) => tabs[index].item2;
  final TabController? tabController;
  final ShiPinSortLayoutController controller;

  const ShiPinSortTabBar(
      {super.key, required this.controller, this.tabController});

  Widget _buildTabBar() => SizedBox(
        height: 26.w,
        child: TabBar(
          tabs: tabs.map((e) => Tab(text: e.item1)).toList(),
          controller: tabController,
          dividerHeight: 0,
          indicatorColor: COLOR.transparent,
          labelStyle: TextStyle(color: COLOR.color_DDDDDD, fontSize: 14.w),
          unselectedLabelStyle:
              TextStyle(color: COLOR.color_808080, fontSize: 14.w),
          indicatorPadding: EdgeInsets.zero,
          labelPadding: EdgeInsets.symmetric(horizontal: 10.5.w),
          isScrollable: true,
          tabAlignment: TabAlignment.start,
        ),
      ).marginLeft(3.5.w);

  Widget _buildTabBarRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: _buildTabBar()),
        2.horizontalSpace,
        Obx(
          () => VideoLayoutButton(
            controller.layout.value,
            text: '切换',
            onTap: controller.toogleLayout,
          ),
        )
      ],
    ).baseMarginR;
  }

  @override
  Widget build(BuildContext context) => _buildTabBarRow();
}
