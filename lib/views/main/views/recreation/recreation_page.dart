import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/assets/colorx.dart';
import 'package:xhs_app/assets/styles.dart';
import 'package:xhs_app/components/base_page/base_error_widget.dart';
import 'package:xhs_app/components/base_page/base_loading_widget.dart';
import 'package:xhs_app/components/tab_bar/expansion_tab_bar.dart';
import 'package:xhs_app/components/tab_bar_indicator/easy_fixed_indicator.dart';
import 'package:xhs_app/utils/color.dart';
import 'package:xhs_app/utils/extension.dart';
import 'package:xhs_app/views/activity/activity_page.dart';
import 'package:xhs_app/views/ai/ai_web_view.dart';
import 'package:xhs_app/views/community/common/base/community_classify_edit_cell.dart';
import 'package:xhs_app/views/main/views/recreation/cartoon/cartoon_page.dart';
import 'package:xhs_app/views/main/views/recreation/fiction/fiction_page.dart';
import 'package:xhs_app/views/main/views/recreation/intension_map/intension_map_page.dart';
import 'package:xhs_app/views/main/views/recreation/popular_skits/popular_skits_page.dart';
import 'package:xhs_app/views/main/views/recreation/recreation_logic.dart';
import 'package:xhs_app/views/main/views/recreation/recreation_state.dart';

import 'banned_the_strange_case/banned_the_strange_case_page.dart';
import 'portray_person/portray_person_page.dart';

///娱乐页面
class RecreationPage extends StatefulWidget {
  const RecreationPage({super.key});

  @override
  State<RecreationPage> createState() => _RecreationPageState();
}

class _RecreationPageState extends State<RecreationPage> {
  final RecreationLogic logic = Get.put(RecreationLogic());
  final RecreationState state = Get.find<RecreationLogic>().state;

  @override
  void dispose() {
    Get.delete<RecreationLogic>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: COLOR.color_AFAFAF,
        ),
        Expanded(
            child: DefaultTabController(
          length: state.tabs.length,
          child: Column(
            children: [
              SizedBox(
                height: 11.h,
              ),
              SizedBox(
                height: 30.h,
                child: _buildTabBar(),
              ),
              Divider(
                height: 1.h,
                color: ColorX.color_eeeeee,
              ),
              Expanded(child: _buildTabBarView()),
            ],
          ),
        )),
      ],
    );
  }

  Widget _buildTabBar() => SizedBox(
        child: TabBar(
          isScrollable: true,
          tabs: state.tabs.map((e) => Tab(text: "  $e  ")).toList(),
          dividerHeight: 0,
          indicator: EasyFixedIndicator(
            color: COLOR.color_FB2D45,
            height: 0.w,
            borderRadius: Styles.borderRadius.all(2.w),
          ),
          tabAlignment: TabAlignment.start,
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

  Widget _buildTabBar1() => SizedBox(
          child: ExpansionTabBar(
        controller: logic.expansionTileController,
        loadingTask: logic.loadOptionalClassify,
        loadingSuccessBuilder: (context) => [
          CommunityClassifyEditCell(
            selected: logic.selectedClassify,
            optional: logic.optionalClassify,
            onTapChangeClassify: logic.onChangeClassify,
            onEditDone: logic.onEditDone,
          )
        ],
        loadingBuilder: (context) => [
          SizedBox(
            height: 80.w,
            child: const Center(child: BaseLoadingWidget()),
          ),
        ],
        loadingFailBuilder: (context) => [
          SizedBox(
            height: 80.w,
            child: const Center(child: BaseErrorWidget()),
          )
        ],
        TabBar(
          controller: logic.tabController,
          isScrollable: true,
          tabs: state.tabs.map((e) => Tab(text: "  $e  ")).toList(),
          dividerHeight: 0,
          indicator: EasyFixedIndicator(
            color: COLOR.color_FB2D45,
            height: 0.w,
            borderRadius: Styles.borderRadius.all(2.w),
          ),
          tabAlignment: TabAlignment.start,
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
      ));

  Widget _buildTabBarView() => TabBarView(
        children: [
          const CartoonPage(),
          const FictionPage(),
          const PortrayPersonPage(),
          const AiWebView().keepAlive,
          const IntensionMapPage(),
          const PopularSkitsPage(),
          const BannedTheStrangeCasePage(),
          const ActivityPage(isShowAd: false),
        ],
      );
}
