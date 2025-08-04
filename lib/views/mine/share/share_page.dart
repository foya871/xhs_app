import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/components/app_bar/app_bar_view.dart';
import 'package:xhs_app/routes/routes.dart';
import 'package:xhs_app/views/mine/share/agent/agent_page.dart';
import 'share_page_controller.dart';

class SharePage extends GetView<SharePageController> {
  const SharePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: AgentPage(),
    );
  }

  _buildAppBar() {
    return AppBarView(
      titleText: "分享推广",
      actions: [
        TextButton(
            onPressed: () {
              Get.toNamed(Routes.shareRecord);
            },
            child: Text(
              "我的推广",
              style: TextStyle(
                color: const Color(0xff999999),
                fontSize: 14.w,
              ),
            ))
      ],
    );
    // return AppBar(
    //   backgroundColor: Colors.transparent,
    //   shadowColor: Colors.transparent,
    //   title: TabBar(
    //     tabs: controller.tabs,
    //     controller: controller.tabController,
    //     labelStyle: TextStyle(
    //       color: COLOR.white,
    //       fontSize: 16.w,
    //       fontWeight: FontWeight.bold,
    //     ),
    //     unselectedLabelStyle: TextStyle(
    //       color: COLOR.white,
    //       fontSize: 16.w,
    //     ),
    //     isScrollable: false,
    //     dividerHeight: 0,
    //     indicator: EasyFixedIndicator(
    //       color: COLOR.color_B93FFF,
    //       width: 10.w,
    //       height: 3.w,
    //     ),
    //     indicatorPadding: EdgeInsets.only(bottom: 5.w),
    //     labelPadding: EdgeInsets.only(right: 30.w),
    //   ),
    // );
  }
}
