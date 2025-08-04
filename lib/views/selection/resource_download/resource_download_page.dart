import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:xhs_app/assets/colorx.dart';
import 'package:xhs_app/components/ad_banner/insert_ad.dart';
import 'package:xhs_app/routes/routes.dart';

import '../../../assets/styles.dart';
import '../../../components/ad_banner/classify_ads.dart';
import '../../../components/base_refresh/base_refresh_widget.dart';
import '../../../components/image_view.dart';
import '../../../components/no_more/no_data.dart';
import '../../../model/axis_cover.dart';
import '../../../model/video/resource_download_model.dart';
import '../../../utils/color.dart';
import 'resource_download_logic.dart';
import 'resource_download_state.dart';

class ResourceDownloadPage extends StatefulWidget {
  const ResourceDownloadPage({super.key});

  @override
  State<ResourceDownloadPage> createState() => _ResourceDownloadPageState();
}

class _ResourceDownloadPageState extends State<ResourceDownloadPage> {
  final ResourceDownloadLogic logic = Get.put(ResourceDownloadLogic());
  final ResourceDownloadState state = Get.find<ResourceDownloadLogic>().state;

  @override
  void dispose() {
    Get.delete<ResourceDownloadLogic>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildTabBar(),
        Expanded(
          child: BaseRefreshWidget(
            logic.refreshController,
            refreshOnStart: false,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const ClassifyAds(),
                  PagedGridView<int, ResourceInfo>(
                    padding: EdgeInsets.only(top: 10, left: 14.w, right: 14.w),
                    addAutomaticKeepAlives: true,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    pagingController: logic.refreshController.pagingControllers,
                    builderDelegate: PagedChildBuilderDelegate<ResourceInfo>(
                      firstPageProgressIndicatorBuilder: (context) =>
                          const SizedBox.shrink(),
                      newPageProgressIndicatorBuilder: (context) =>
                          const SizedBox.shrink(),
                      noMoreItemsIndicatorBuilder: (context) =>
                          const SizedBox.shrink(),
                      noItemsFoundIndicatorBuilder: (context) => const NoData(),
                      itemBuilder: (context, item, index) =>
                          buildResourceCell(item, () {
                        Get.toResourceDetail(id: item.resourcesId ?? 0);
                      }),
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 10.w,
                        crossAxisSpacing: 8.w,
                        crossAxisCount: 2,
                        childAspectRatio: 162 / 130),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  buildTabBar() {
    return Obx(() {
      if (state.tabs.isEmpty) return Container();
      return TabBar(
        controller: logic.tabController,
        tabs: state.tabs.map((e) {
          return Row(
            children: [
              Visibility(
                visible: state.tabs.indexOf(e) != 0,
                child: Container(
                  height: 5.h,
                  width: 1.w,
                  color: ColorX.color_eeeeee,
                ),
              ),
              SizedBox(
                width: 7.w,
              ),
              Tab(
                text: e.classifyTitle,
                height: 30.h,
              ),
              SizedBox(
                width: 7.w,
              ),
            ],
          );
        }).toList(),
        indicatorColor: COLOR.transparent,
        dividerHeight: 0,
        isScrollable: true,
        onTap: (index) => logic.onChangeTab(state.tabs[index]),
        tabAlignment: TabAlignment.start,
        labelPadding: EdgeInsets.zero,
      );
    });
  }

  Widget buildResourceCell(ResourceInfo item, Function()? onTap) {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageView(
            src: "${logic.refreshController.domain}${item.coverImg}",
            width: double.infinity,
            height: 90.w,
            fit: BoxFit.cover,
            borderRadius: Styles.borderRaidus.m,
            axis: CoverImgAxis.horizontal,
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(
            item.resourcesTitle ?? "",
            style: TextStyle(fontSize: 13.w, color: ColorX.color_333333),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
