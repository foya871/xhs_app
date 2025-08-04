import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../components/base_refresh/base_refresh_tab_key.dart';
import '../../../components/base_refresh/base_refresh_tab_widget.dart';
import '../../../components/no_more/no_data_masonry_grid_view.dart';
import '../../../utils/color.dart';
import '../../../utils/extension.dart';
import '../common/base/community_base_cell.dart';
import '../controllers/community_topic_page_controller.dart';

class CommunityTopicPage extends GetView<CommunityTopicPageController> {
  const CommunityTopicPage({super.key});

  AppBar _buildAppBar() => AppBar(title: Text('#${controller.topic}'));

  Widget _buildTabBar() => SizedBox(
        width: 120.w,
        child: TabBar(
          tabs: CommunityTopicPageController.tabs
              .map((e) => Tab(text: e.item1))
              .toList(),
          labelStyle: TextStyle(fontSize: 15.w, fontWeight: FontWeight.w500),
          unselectedLabelStyle: TextStyle(
            fontSize: 15.w,
            color: COLOR.color_999999,
          ),
          dividerColor: COLOR.transparent,
          dividerHeight: 0,
          indicator: const BoxDecoration(),
          tabAlignment: TabAlignment.fill,
        ),
      );

  Widget _buildTabBarView() => TabBarView(
        children: CommunityTopicPageController.tabs.mapIndexed((i, e) {
          final tabKey = BaseRefreshTabIndexKey(i);
          return BaseRefreshTabWidget(
            controller,
            tabKey: tabKey,
            child: Obx(
              () {
                final data = controller.getData(tabKey);
                final dataInited = controller.dataInited(tabKey);
                return NoDataMasonryGridView.count(
                  crossAxisCount: 2,
                  itemCount: data.length,
                  itemBuilder: (ctx, i) => CommunityBaseCell(data[i]),
                  crossAxisSpacing: 4.w,
                  mainAxisSpacing: 4.w,
                  noData: dataInited,
                );
              },
            ),
          ).keepAlive.baseMarginHorizontal;
        }).toList(),
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: _buildAppBar(),
        body: DefaultTabController(
          length: CommunityTopicPageController.tabs.length,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTabBar(),
              Expanded(child: _buildTabBarView()),
            ],
          ),
        ),
      );
}
