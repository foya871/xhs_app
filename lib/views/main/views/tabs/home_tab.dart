import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../assets/styles.dart';
import '../../../../components/tab_bar_indicator/easy_fixed_indicator.dart';
import '../../../../generate/app_image_path.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/color.dart';
import '../../../../utils/extension.dart';
import '../../../community/views/community_attention_page.dart';
import '../../../community/views/community_discover_page.dart';
import '../../controllers/main_controller.dart';
import '../recreation/recreation_page.dart';

class HomeTab extends StatelessWidget {
  static final tabs = ['关注', '发现', '娱乐'];
  static const attentionIndex = 0;
  static const discoverIndex = 1;
  static const defaultTabIndex = discoverIndex;

  const HomeTab({super.key});

  Widget _buildCheckIn() => Badge(
        backgroundColor: COLOR.transparent,
        label: Image.asset(
          AppImagePath.home_youjiang,
          width: 24.w,
          height: 13.1.w,
        ),
        offset: Offset(-1.w, -7.5.w),
        child: Text(
          '签到',
          style: TextStyle(
            fontSize: 14.w,
            fontWeight: FontWeight.w400,
          ),
        ),
      ).onOpaqueTap(() => Get.toNamed(Routes.check_in));

  Widget _buildAttentionTab(String tab) => Tab(
        icon: Obx(() {
          final count = Get.find<MainController>().communityPushedMessageCount;
          if (count > 0) {
            return Badge(
              backgroundColor: COLOR.color_FB2D45,
              offset: Offset(7.w, -8.5.w),
              label: Container(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                child: Text(
                  '${Get.find<MainController>().communityPushedMessageCount}',
                  style: TextStyle(
                    color: COLOR.white,
                    fontSize: 10.w,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              child: Text(tab),
            );
          } else {
            return Text(tab);
          }
        }),
      );

  Widget _buildTabBar() => SizedBox(
        width: 180.w,
        child: TabBar(
          isScrollable: false,
          tabs: tabs
              .mapIndexed(
                (i, e) =>
                    i == attentionIndex ? _buildAttentionTab(e) : Tab(text: e),
              )
              .toList(),
          dividerHeight: 0,
          indicator: EasyFixedIndicator(
            color: COLOR.color_FB2D45,
            height: 2.w,
            borderRadius: Styles.borderRadius.all(2.w),
          ),
          tabAlignment: TabAlignment.fill,
          labelPadding: EdgeInsets.zero,
          labelStyle: TextStyle(
            fontSize: 16.w,
            fontWeight: FontWeight.w500,
            color: COLOR.primaryText,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 16.w,
            fontWeight: FontWeight.w400,
            color: COLOR.color_999999,
          ),
        ),
      );

  Widget _buildSearch() => Image.asset(
        AppImagePath.home_search,
        width: 24.w,
        height: 24.w,
      ).onTap(() => Get.toNamed(Routes.search));

  Widget _buildAppBar() => Container(
        padding: EdgeInsets.only(top: 16.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildCheckIn(),
            SizedBox(height: 26.w, child: _buildTabBar()),
            _buildSearch(),
          ],
        ).marginHorizontal(18.w),
      );

  Widget _buildTabBarView() => TabBarView(
        children: [
          const CommunityAttentionPage().keepAlive,
          const CommunityDiscoverPage().keepAlive,
          const RecreationPage(),
        ],
      );

  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: tabs.length,
        initialIndex: HomeTab.defaultTabIndex,
        child: Scaffold(
          body: SafeArea(
            top: true,
            child: Column(
              children: [
                _buildAppBar(),
                Expanded(child: _buildTabBarView()),
              ],
            ),
          ),
        ),
      );
}
