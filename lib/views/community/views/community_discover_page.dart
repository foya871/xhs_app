/*
 * @Author: wangdazhuang
 * @Date: 2025-02-27 13:37:24
 * @LastEditTime: 2025-03-15 15:21:59
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /xhs_app/lib/views/community/views/community_discover_page.dart
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/views/community/common/base/community_classify_edit_cell.dart';

import '../../../assets/styles.dart';
import '../../../components/base_page/base_error_widget.dart';
import '../../../components/base_page/base_loading_widget.dart';
import '../../../components/tab_bar/expansion_tab_bar.dart';
import '../../../utils/color.dart';
import '../../../utils/extension.dart';
import '../common/classify_tabs/community_classify_factory.dart';
import '../controllers/community_discover_page_controller.dart';

// 首页-发现
class CommunityDiscoverPage extends GetView<CommunityDiscoverPageController> {
  const CommunityDiscoverPage({super.key});

  Widget _buildTabBar() => ExpansionTabBar(
        TabBar(
            controller: controller.tabController,
            tabs: controller.tabs
                .map((e) => Tab(
                      text: e.classifyTitle,
                      height: 25.w,
                    ))
                .toList(),
            indicatorColor: COLOR.transparent,
            dividerHeight: 0,
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            labelPadding: EdgeInsets.only(right: 10.w),
            unselectedLabelStyle:
                kTextStyle(COLOR.color_666666, fontsize: 15.w),
            labelStyle: kTextStyle(Colors.black,
                weight: FontWeight.bold, fontsize: 15.w)),
        controller: controller.expansionTileController,
        loadingTask: controller.loadOptionalClassify,
        loadingSuccessBuilder: (context) => [
          CommunityClassifyEditCell(
            selected: controller.selectedClassify,
            optional: controller.optionalClassify,
            onTapChangeClassify: controller.onChangeClassify,
            onEditDone: controller.onEditDone,
          )
        ],
        loadingBuilder: (context) => [
          SizedBox(
            height: 60.w,
            child: const Center(child: BaseLoadingWidget()),
          ),
        ],
        loadingFailBuilder: (context) => [
          SizedBox(
            height: 60.w,
            child: const Center(child: BaseErrorWidget()),
          )
        ],
      );

  Widget _buildTabBarView() => TabBarView(
        controller: controller.tabController,
        children: controller.tabs
            .map((e) => CommunityClassifyFactory.create(e).keepAlive)
            .toList(),
      );

  Widget _buildBody(BuildContext context) => Column(
        children: [
          _buildTabBar(),
          Expanded(child: _buildTabBarView()),
        ],
      );

  @override
  Widget build(BuildContext context) => controller.obx(
        (_) => _buildBody(context),
        onLoading: const BaseLoadingWidget(),
        onError: (_) =>
            BaseErrorWidget(onTap: controller.refreshCommunityClassify),
      );
}
