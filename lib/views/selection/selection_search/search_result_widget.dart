import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/views/selection/selection_search/selection_search_logic.dart';
import 'package:xhs_app/views/selection/selection_search/selection_search_state.dart';

import '../../../utils/color.dart';

class SearchResultWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SearchResultWidgetState();
}

class SearchResultWidgetState extends State<SearchResultWidget> {
  final SelectionSearchLogic logic = Get.put(SelectionSearchLogic());
  final SelectionSearchState state = Get.find<SelectionSearchLogic>().state;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTabBar(),
        Expanded(
          child: Obx(() {
            return PageView(
              controller: logic.pageController,
              onPageChanged: (index) {
                logic.tabController?.animateTo(index);
              },
              children: state.pages.value,
            );
          }),
        ),
      ],
    );
  }

  buildTabBar() {
    return Obx(() {
      if (state.tabs.isEmpty) return Container();
      return TabBar(
        controller: logic.tabController,
        tabs: state.tabs.map((e) {
          return Row(
            children: [
              SizedBox(
                width: 10.w,
              ),
              Tab(text: e.classifyTitle),
              SizedBox(
                width: 10.w,
              ),
            ],
          );
        }).toList(),
        indicatorColor: COLOR.transparent,
        dividerHeight: 0,
        isScrollable: true,
        labelStyle: TextStyle(fontSize: 15.w),
        unselectedLabelStyle: TextStyle(fontSize: 15.w),
        onTap: (index) {
          logic.pageController?.jumpToPage(index);
          logic.onChangeTab(state.tabs[index]);
        },
        tabAlignment: TabAlignment.start,
        labelPadding: EdgeInsets.zero,
      );
    });
  }
}
