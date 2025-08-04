import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker_fork/flutter_cupertino_date_picker_fork.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xhs_app/assets/styles.dart';
import 'package:xhs_app/components/keep_alive_wrapper.dart';
import 'package:xhs_app/components/tab_bar_indicator/easy_fixed_indicator.dart';
import 'package:xhs_app/components/text_view.dart';
import 'package:xhs_app/generate/app_image_path.dart';
import 'package:xhs_app/http/api/api.dart';
import 'package:xhs_app/utils/color.dart';
import 'package:xhs_app/utils/extension.dart';
import 'package:xhs_app/views/mine/mine_profit/mine_profit_view.dart';

import '../../../model/mine/profit_total_model.dart';

class MineProfitPage extends StatefulWidget {
  const MineProfitPage({super.key});

  @override
  State<MineProfitPage> createState() => _MineProfitPageState();
}

class _MineProfitPageState extends State<MineProfitPage>
    with TickerProviderStateMixin {
  ProfitTotalModel _model = ProfitTotalModel.fromJson({});
  Future getData() async {
    final rsp = await Api.fecthSpreadTotalData();
    if (rsp != null) {
      _model = rsp;
      if (mounted) {
        setState(() {});
      }
    }
  }

  late TabController tabController;
  List<String> tabItems = ["笔记收益", "粉丝团收益", "下载资源收益"];
  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLOR.color_FAFAFA,
      body: ExtendedNestedScrollView(
        onlyOneScrollInBody: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              elevation: 0.0,
              pinned: true,
              actions: [
                TextView(
                  text: "筛选",
                  fontSize: 14.w,
                  color: COLOR.color_666666,
                ).onTap(() {
                  DatePicker.showDatePicker(
                    context,
                    locale: DateTimePickerLocale.zh_cn,
                    dateFormat: 'yyyy-MM',
                    onConfirm: (dateTime, selectedIndex) {},
                  );
                }).marginRight(16.w)
              ],
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextView(
                      text: "我的收益", fontSize: 16.w, color: COLOR.color_666666)
                ],
              ),
              toolbarHeight: 56,
              centerTitle: true,
              forceElevated: false,
              scrolledUnderElevation: 0,
            ),
            Container(
              width: 331.w,
              height: 120.w,
              margin: EdgeInsets.only(left: 14.w, right: 14.w, top: 10.w),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImagePath.mine_icon_profit_bg),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 164.w,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextView(
                            text: "今日收益 (金币）",
                            fontSize: 13.w,
                            color: COLOR.color_666666),
                        TextView(
                                text: "${_model.todayIncome}",
                                fontSize: 24.w,
                                color: COLOR.color_faa06a)
                            .paddingTop(14.w)
                      ],
                    ),
                  ),
                  Container(
                      width: 1, height: 40, color: COLOR.hexColor("#faa06a")),
                  Container(
                    width: 164.w,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextView(
                            text: "总收益 (金币）",
                            fontSize: 13.w,
                            color: COLOR.color_666666),
                        TextView(
                                text: "${_model.totalIncome}",
                                fontSize: 24.w,
                                color: COLOR.color_faa06a)
                            .paddingTop(14.w)
                      ],
                    ),
                  ),
                ],
              ),
            ).sliver,
            SliverPersistentHeader(
                pinned: true,
                delegate: _StickyTabBarDelegate(
                  child: _buildTabBar(),
                ))
          ];
        },
        body: TabBarView(
            controller: tabController,
            children: tabItems.map((v) {
              return KeepAliveWrapper(
                  child: MineProfitView(
                title: v,
              ));
            }).toList()),
      ),
    );
  }

  _buildTabBar() {
    return TabBar(
      tabs: tabItems.map((e) => Tab(text: e)).toList(),
      labelStyle: TextStyle(
        color: COLOR.color_333333,
        fontSize: 15.w,
        fontWeight: FontWeight.w600,
      ),
      tabAlignment: TabAlignment.start,
      isScrollable: true,
      controller: tabController,
      unselectedLabelStyle:
          TextStyle(fontSize: 15.w, color: COLOR.color_999999),
      indicator: EasyFixedIndicator(
        widthExtra: 0.w,
        height: 0.w,
        borderRadius: Styles.borderRadius.all(12.w),
        color: COLOR.color_B93FFF,
      ),
      padding: EdgeInsets.zero,
      indicatorWeight: 0,
      dividerColor: COLOR.transparent,
      dividerHeight: 0,
    );
  }
}

class _StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar child;

  _StickyTabBarDelegate({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
        color: COLOR.color_FAFAFA,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            child,
          ],
        ));
  }

  @override
  double get maxExtent => 44;

  @override
  double get minExtent => 44;

  @override
  bool shouldRebuild(_StickyTabBarDelegate oldDelegate) {
    return maxExtent != oldDelegate.maxExtent ||
        minExtent != oldDelegate.minExtent ||
        child != oldDelegate.child;
  }
}
