import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../model/classify/classify_models.dart';
import '../../../../services/app_service.dart';
import '../../../../utils/color.dart';
import '../../../../utils/extension.dart';
import '../../../shi_pin/common/base/shi_pin_search_cell.dart';
import '../../../shi_pin/common/shi_pin_tab/shi_pin_tab_factory.dart';
import '../../controllers/shi_pin_tab_controller.dart';

class ShiPinTab extends GetView<ShiPinTabController> {
  const ShiPinTab({super.key});


  Widget _buildTabBar(List<ClassifyModel> shiPinTabs) {
    return SizedBox(
      height: 28.w,
      child: TabBar(
        controller: controller.tabController,
        tabs: shiPinTabs.map((e) => Tab(text: e.classifyTitle)).toList(),
        tabAlignment: TabAlignment.start,
        labelStyle: TextStyle(
          color: COLOR.color_F0D94C,
          fontSize: 16.w,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          color: COLOR.color_DDDDDD,
          fontSize: 16.w,
        ),
        isScrollable: true,
        dividerHeight: 0,
        indicatorColor: COLOR.transparent,
        indicatorPadding: EdgeInsets.only(bottom: 6.w),
        indicatorWeight: 1,
        labelPadding: EdgeInsets.only(right: 20.w),
      ),
    );
  }

  Widget _buildTabBarView(List<ClassifyModel> homeTabs) {
    final views = homeTabs
        .map((e) => ShiPinTabFactory.create(e.classifyId, e.type).keepAlive)
        .toList();
    return TabBarView(controller: controller.tabController, children: views);
  }

  @override
  Widget build(BuildContext context) {
    final shiPinTabs = Get.find<AppService>().shiPinTabs;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ShiPinSearchCell().baseMarginHorizontal,
            10.verticalSpaceFromWidth,
            Align(
              alignment: Alignment.centerLeft,
              child: _buildTabBar(shiPinTabs).baseMarginL,
            ),
            8.verticalSpaceFromWidth,
            Expanded(child: _buildTabBarView(shiPinTabs))
          ],
        ),
      ),
    );
  }
}
