import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/views/search/search_state.dart';
import 'package:xhs_app/views/search/classify/search_post_widget.dart';

import '../../../utils/color.dart';
import 'classify/search_ban_case_widget.dart';
import 'classify/search_blogger_widget.dart';
import 'classify/search_comic_widget.dart';
import 'classify/search_connotation_widget.dart';
import 'classify/search_novel_widget.dart';
import 'classify/search_photo_widget.dart';
import 'classify/search_playlet_widget.dart';
import 'search_logic.dart';

class SearchResultWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SearchResultWidgetState();
}

class SearchResultWidgetState extends State<SearchResultWidget> {
  final SearchLogic logic = Get.put(SearchLogic());
  final SearchState state = Get.find<SearchLogic>().state;

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
          child: PageView(
            controller: logic.pageController,
            onPageChanged: (index) {
              logic.tabController?.animateTo(index);
            },
            children: [
              SearchPostWidget(),
              SearchBloggerWidget(),
              SearchComicWidget(),
              SearchNovelWidget(),
              SearchPhotoWidget(),
              SearchConnotationWidget(),
              SearchPlayletWidget(),
              SearchBanCaseWidget(),
            ],
          ),
        ),
      ],
    );
  }

  buildTabBar() {
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
  }
}
