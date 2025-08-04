/*
 * @Author: wangdazhuang
 * @Date: 2024-10-16 19:14:58
 * @LastEditTime: 2025-03-02 11:52:08
 * @LastEditors: david wumingshi555888@gmail.com
 * @Description: 
 * @FilePath: /xhs_app/lib/views/mine/mine_download/mine_download_page.dart
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/assets/styles.dart';
import 'package:xhs_app/components/app_bar/app_bar_view.dart';
import 'package:xhs_app/components/tab_bar_indicator/easy_fixed_indicator.dart';
import 'package:xhs_app/model/community/community_classify_model.dart';
import '../../../utils/color.dart';
import 'mine_download_list_page.dart';
import 'mine_download_page_controller.dart';

class DownloadPage extends GetView<MineDownloadPageController> {
  const DownloadPage({super.key});

  _buildAppBar() => AppBarView(
        titleText: "我的下载",
      );

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: COLOR.color_F5F5F5,
      appBar: _buildAppBar(),
      body: GetBuilder<MineDownloadPageController>(
        builder: (_) => DefaultTabController(
          length: controller.classifyItems.length,
          child: Column(
            children: [
              _buildTabBar(),
              Expanded(
                child: TabBarView(
                  children: controller.classifyItems.map((v) {
                    return initTabBarView(v);
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ));

  Widget _buildTabBar() => SizedBox(
        child: TabBar(
          tabs: controller.classifyItems
              .map((e) => Tab(text: e.classifyTitle))
              .toList(),
          dividerHeight: 0,
          isScrollable: true,
          indicator: EasyFixedIndicator(
            color: COLOR.color_FB2D45,
            height: 0.w,
            borderRadius: Styles.borderRadius.all(2.w),
          ),
          tabAlignment: TabAlignment.center,
          // labelPadding: EdgeInsets.zero,
          labelStyle: TextStyle(
            fontSize: 15.w,
            fontWeight: FontWeight.w600,
            color: COLOR.primaryText,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 15.w,
            fontWeight: FontWeight.w400,
            color: COLOR.color_999999,
          ),
        ),
      );

  Widget initTabBarView(CommunityClassifyModel item) {
    return MineDownloadListPage(
      classifyTitle: item.classifyTitle,
      classifyId: item.classifyId,
    );
  }
}
