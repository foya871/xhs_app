import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/components/ad/ad_info_model.dart';
import 'package:xhs_app/components/ad_banner/classify_ads.dart';
import 'package:xhs_app/components/tab_bar_indicator/easy_fixed_indicator.dart';
import 'package:xhs_app/http/api/api.dart';
import 'package:xhs_app/utils/color.dart';
import 'package:xhs_app/utils/extension.dart';
import 'package:xhs_app/views/activity/activity_child_page.dart';

class ActivityPage extends StatefulWidget {
  final bool isShowAd;
  const ActivityPage({super.key, this.isShowAd = true});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  var tabs = <AdStations>[].obs;

  ///获取分类
  getClassify() {
    Api.fetchActivityClassifyList().then((value) {
      if (value.isNotEmpty) {
        tabs.assignAll(value);
        tabController = TabController(length: tabs.length, vsync: this);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getClassify();
  }

  @override
  void dispose() {
    tabController?.dispose();
    tabController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (tabs.isEmpty) {
          return const SizedBox.shrink();
        }
        return _buildTabView();
      }),
    );
  }

  _buildTabView() {
    return Column(
      children: [
        if (widget.isShowAd) const ClassifyAds(),
        Obx(() => SizedBox(
              width: double.infinity,
              child: TabBar(
                controller: tabController,
                tabs: tabs.map((e) => Tab(text: e.stationName ?? "")).toList(),
                labelColor: COLOR.color_333333,
                tabAlignment: TabAlignment.start,
                isScrollable: true,
                labelStyle: TextStyle(
                  fontSize: 15.w,
                  fontWeight: FontWeight.w600,
                  color: COLOR.color_333333,
                ),
                unselectedLabelColor: COLOR.color_999999,
                unselectedLabelStyle: TextStyle(
                  fontSize: 15.w,
                  color: COLOR.color_999999,
                ),
                indicator: EasyFixedIndicator(
                  color: COLOR.color_FB2D45,
                  height: 3.w,
                  width: 15.w,
                ),
              ),
            )),
        Expanded(
          child: Obx(() => TabBarView(
                controller: tabController,
                children: tabs
                    .map((e) => ActivityChildPage(stationId: e.stationId ?? 0)
                        .keepAlive)
                    .toList(),
              )),
        ),
      ],
    );
  }
}
