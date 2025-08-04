import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/views/portrait/portrait_list/view.dart';

import '../../assets/styles.dart';
import '../../components/tab_bar_indicator/easy_fixed_indicator.dart';
import '../../utils/color.dart';
import 'logic.dart';
import 'state.dart';

//娱乐页面
class PortraitPage extends StatelessWidget {
  PortraitPage({Key? key}) : super(key: key);

  final PortraitLogic logic = Get.put(PortraitLogic());
  final PortraitState state = Get.find<PortraitLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          _buildTabBar(),
          Expanded(
            child: TabBarView(
              children: logic.tabs.map((_) {
                return PortraitListPage();
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() => SizedBox(
        child: TabBar(
          tabs: logic.tabs.map((e) => Tab(text: e.title)).toList(),
          dividerHeight: 0,
          indicator: EasyFixedIndicator(
            color: COLOR.color_FB2D45,
            height: 0.w,
            borderRadius: Styles.borderRadius.all(2.w),
          ),
          tabAlignment: TabAlignment.fill,
          labelPadding: EdgeInsets.zero,
          labelStyle: TextStyle(
            fontSize: 15.w,
            fontWeight: FontWeight.w500,
            color: COLOR.primaryText,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 15.w,
            fontWeight: FontWeight.w400,
            color: COLOR.color_999999,
          ),
        ),
      );
}
