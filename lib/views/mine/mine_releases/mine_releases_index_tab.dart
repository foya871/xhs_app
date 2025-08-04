/*
 * @Author: david wumingshi555888@gmail.com
 * @Date: 2025-02-20 23:07:21
 * @LastEditors: david wumingshi555888@gmail.com
 * @LastEditTime: 2025-03-03 16:18:22
 * @FilePath: /xhs_app/lib/views/mine/mine_releases/mine_releases_index_tab.dart
 * @Description: 
 * Copyright (c) 2025 by ${git_name} email: ${git_email}, All Rights Reserved.
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/components/keep_alive_wrapper.dart';
import '../../../assets/colorx.dart';
import '../../../components/tab_bar_indicator/easy_fixed_indicator.dart';
import '../../../utils/color.dart';
import 'mine_release_collection_page.dart';
import 'mine_release_community_page.dart';

// ignore: must_be_immutable
class MineRealeasesIndexTab extends StatelessWidget {
  MineRealeasesIndexTab({super.key});

  final List tabs = ['全部', '审核中', '审核失败', "合集", "粉丝专属"];

  Widget initTabBarView(String text) {
    if (text == '合集') {
      return Obx(
        () => KeepAliveWrapper(
            child: MinesReleaseCollectionPage(isManage: isManage.value)),
      );
    }
    return Obx(() =>
        MinesReleaseCommunityPage(text: text, isManage: isManage.value));
  }

  RxBool isManage = false.obs;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        backgroundColor: COLOR.color_FAFAFA,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text("作品中心",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ColorX.color_333333,
                fontSize: 16.w,
                fontWeight: FontWeight.w600,
              )),
          centerTitle: true,
          actions: [
            TextButton(
                onPressed: () {
                  isManage.value = !isManage.value;
                },
                child: Obx(() => Text(
                      isManage.value ? "取消" : "管理",
                      style: TextStyle(
                        color: COLOR.hexColor('#666666'),
                        fontSize: 14.w,
                        fontWeight: FontWeight.w500,
                      ),
                    )))
          ],
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(44),
              child: TabBar(
                  tabAlignment: TabAlignment.center,
                  isScrollable: true,
                  labelColor: ColorX.color_333333,
                  unselectedLabelColor: ColorX.color_999999,
                  labelPadding: EdgeInsets.symmetric(horizontal: 12.w),
                  labelStyle:
                      TextStyle(fontSize: 15.w, fontWeight: FontWeight.w600),
                  unselectedLabelStyle:
                      TextStyle(fontSize: 15.w, fontWeight: FontWeight.w500),
                  dividerColor: Colors.transparent,
                  // indicatorPadding: EdgeInsets.only(bottom: 6.w),
                  indicator: EasyFixedIndicator(
                    width: 0.w,
                    height: 0.w,
                  ),
                  tabs: tabs.map((v) => Tab(text: v)).toList())),
        ),
        body: TabBarView(
          children: tabs.map((v) {
            return initTabBarView(v);
          }).toList(),
        ),
      ),
    );
  }
}
