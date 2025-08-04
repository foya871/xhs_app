import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../assets/colorx.dart';
import '../../../assets/styles.dart';
import '../../../components/ad_banner/classify_ads.dart';
import '../../../components/ad_banner/insert_ad.dart';
import '../../../components/base_page/base_error_widget.dart';
import '../../../components/base_page/base_loading_widget.dart';
import '../../../components/base_refresh/base_refresh_widget.dart';
import '../../../components/image_view.dart';
import '../../../components/no_more/no_data.dart';
import '../../../components/tab_bar/expansion_tab_bar.dart';
import '../../../model/axis_cover.dart';
import '../../../model/video/short_videos_resp.dart';
import '../../../routes/routes.dart';
import '../../../utils/color.dart';
import '../../video_collect/video_classify_edit_cell.dart';
import 'recommend_logic.dart';
import 'recommend_state.dart';

class RecommendPage extends StatefulWidget {
  const RecommendPage({super.key});

  @override
  State<RecommendPage> createState() => _RecommendPageState();
}

class _RecommendPageState extends State<RecommendPage> {
  final RecommendLogic logic = Get.put(RecommendLogic());
  final RecommendState state = Get.find<RecommendLogic>().state;

  @override
  void initState() {
    super.initState();
    logic.refreshController.pagingControllers.itemList?.clear();
    logic.refreshController.classifyId = "";
  }

  @override
  void dispose() {
    Get.delete<RecommendLogic>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTabBar(),
        Expanded(
          child: BaseRefreshWidget(
            logic.refreshController,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const ClassifyAds(),
                  PagedGridView<int, ShortVideoModel>(
                    padding: EdgeInsets.only(top: 10, left: 14.w, right: 14.w),
                    addAutomaticKeepAlives: true,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    pagingController: logic.refreshController.pagingControllers,
                    builderDelegate: PagedChildBuilderDelegate<ShortVideoModel>(
                      firstPageProgressIndicatorBuilder: (context) =>
                          const SizedBox.shrink(),
                      newPageProgressIndicatorBuilder: (context) =>
                          const SizedBox.shrink(),
                      noMoreItemsIndicatorBuilder: (context) =>
                          const SizedBox.shrink(),
                      noItemsFoundIndicatorBuilder: (context) => const NoData(),
                      itemBuilder: (context, item, index) =>
                          buildShortVideoCell(item, () {
                        Get.toPlayVideo(videoId: item.videoId ?? 0);
                      }),
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 0.w,
                      crossAxisSpacing: 8.w,
                      crossAxisCount: 2,
                      childAspectRatio: 162 / 130,
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildTabBar() {
    return Obx(() {
      if (logic.tabs.isEmpty) return Container();
      return ExpansionTabBar(
        TabBar(
          controller: logic.tabController,
          tabs: logic.tabs
              .map((e) => Tab(
                    text: e.classifyTitle ?? '',
                    height: 25.w,
                  ))
              .toList(),
          indicatorColor: COLOR.transparent,
          dividerHeight: 0,
          isScrollable: true,
          onTap: (index) => logic.onChangeTab(logic.tabs[index]),
          tabAlignment: TabAlignment.start,
          labelPadding: EdgeInsets.symmetric(horizontal: 6.w),
        ),
        controller: logic.expansionTileController,
        loadingTask: logic.loadOptionalClassify,
        loadingSuccessBuilder: (context) => [
          VideoClassifyEditCell(
            selected: logic.tabs,
            optional: logic.optionalClassify,
            onTapChangeClassify: logic.onChangeClassify,
            onEditDone: logic.onEditDone,
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
    });
  }

  Widget buildShortVideoCell(ShortVideoModel item, Function() onTap) {
    if (item.isAd) {
      return InsertAd(
        adress: item.ad!,
        height: 90.w,
        showMark: false,
        showName: true,
      );
    }
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          ImageView(
            src: "${logic.refreshController.domain}${item.coverImg}",
            width: double.infinity,
            height: 90.w,
            fit: BoxFit.cover,
            borderRadius: Styles.borderRaidus.m,
            axis: CoverImgAxis.horizontal,
          ),
          SizedBox(height: 5.w),
          Text(
            item.title ?? "",
            style: TextStyle(fontSize: 13.w, color: ColorX.color_333333),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
