import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:xhs_app/assets/colorx.dart';
import 'package:xhs_app/assets/styles.dart';
import 'package:xhs_app/components/ad_banner/classify_ads.dart';
import 'package:xhs_app/components/ad_banner/insert_ad.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_widget.dart';
import 'package:xhs_app/components/image_view.dart';
import 'package:xhs_app/model/axis_cover.dart';

import 'package:xhs_app/model/video/popular_skits_base_model.dart';
import 'package:xhs_app/routes/routes.dart';
import 'package:xhs_app/utils/color.dart';
import 'package:xhs_app/utils/extension.dart';
import 'package:xhs_app/views/main/views/recreation/banned_the_strange_case/banned_the_strange_case_logic.dart';
import 'package:xhs_app/views/main/views/recreation/banned_the_strange_case/banned_the_strange_case_state.dart';

// 禁播短剧
class BannedTheStrangeCasePage extends StatefulWidget {
  const BannedTheStrangeCasePage({super.key});

  @override
  State<BannedTheStrangeCasePage> createState() =>
      _BannedTheStrangeCasePageState();
}

class _BannedTheStrangeCasePageState extends State<BannedTheStrangeCasePage> {
  final BannedTheStrangeCaseLogic logic = Get.put(BannedTheStrangeCaseLogic());
  final BannedTheStrangeCaseState state =
      Get.find<BannedTheStrangeCaseLogic>().state;

  @override
  void dispose() {
    Get.delete<BannedTheStrangeCaseLogic>();
    super.dispose();
  }

  Widget _buildSliverCommunity() {
    return GetBuilder<BannedTheStrangeCaseLogic>(builder: (controller) {
      Get.log("===========>刷新完成");
      return SliverMasonryGrid.count(
        childCount:
            logic.refreshController.pagingControllers.itemList?.length ?? 0,
        itemBuilder: (ctx, i) => buildShortVideoCell(
            logic.refreshController.pagingControllers.itemList![i]),
        mainAxisSpacing: 10.w,
        crossAxisSpacing: 8.w,
        crossAxisCount: 2,
      );
    }).sliverPaddingHorizontal(14.w);
  }

  Widget _buildBody() => CustomScrollView(
        controller: ScrollController(),
        slivers: [
          const ClassifyAds().sliver,
          5.verticalSpaceFromWidth.sliver,
          buildSelectList().sliver,
          12.verticalSpaceFromWidth.sliver,
          _buildSliverCommunity(),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child:
              BaseRefreshWidget(logic.refreshController, child: _buildBody()),
        )
        // Expanded(
        //   child: BaseRefreshWidget(
        //     logic.refreshController,
        //     refreshOnStart: false,
        //     child: PagedGridView<int, PopularSkitsBaseFindModel>(
        //       padding: EdgeInsets.only(top: 20.w, left: 14.w, right: 14.w),
        //       addAutomaticKeepAlives: true,
        //       pagingController: logic.refreshController.pagingControllers,
        //       builderDelegate:
        //           PagedChildBuilderDelegate<PopularSkitsBaseFindModel>(
        //         firstPageProgressIndicatorBuilder: (context) =>
        //             const SizedBox.shrink(),
        //         newPageProgressIndicatorBuilder: (context) =>
        //             const SizedBox.shrink(),
        //         noMoreItemsIndicatorBuilder: (context) =>
        //             const SizedBox.shrink(),
        //         noItemsFoundIndicatorBuilder: (context) => const NoData(),
        //         itemBuilder: (context, item, index) =>
        //             buildShortVideoCell(item),
        //       ),
        //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //           mainAxisSpacing: 10.w,
        //           crossAxisSpacing: 8.w,
        //           crossAxisCount: 2,
        //           childAspectRatio: 86 / 65),
        //     ),
        //   ),
        // ),
      ],
    );
  }

  Widget buildShortVideoCell(PopularSkitsBaseFindModel item) {
    if (item.isAd) {
      return InsertAd(
        adress: item.ad!,
        height: 90.w,
        spacing: 5.w,
        showMark: false,
        showName: true,
        borderRadius: Styles.borderRaidus.m,
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ImageView(
          src: "${item.coverImg}",
          width: double.infinity,
          height: 90.w,
          fit: BoxFit.cover,
          borderRadius: Styles.borderRaidus.m,
          axis: CoverImgAxis.horizontal,
        ),
        SizedBox(
          height: 5.w,
        ),
        Text(
          item.title ?? "",
          style: TextStyle(fontSize: 13.w, color: ColorX.color_333333),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ).onTap(() {
      Get.toPlayVideo(videoId: item.videoId ?? 0);
    });
  }

  buildSelectBtn(List<String> list, int index, int selectIndex) {
    {
      return Container(
        width: 1.sw,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          controller: ScrollController(),
          child: Container(
            padding: EdgeInsets.only(top: 8.w),
            child: Row(
              children: list
                  .map((e) => GestureDetector(
                        onTap: () {
                          logic.setListIndex(index, list.indexOf(e));
                        },
                        child: Container(
                          height: 22.w,
                          alignment: Alignment.center,
                          child: Row(
                            children: [
                              if (list.indexOf(e) != 0)
                                SizedBox(
                                  width: 8.w,
                                ),
                              if (list.indexOf(e) != 0)
                                Container(
                                    height: 10.w,
                                    width: 1,
                                    color: COLOR.color_666666.withAlpha(150)),
                              SizedBox(
                                width: 8.w,
                              ),
                              Text(
                                e,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 13.w,
                                    fontWeight: index == list.indexOf(e)
                                        ? FontWeight.w600
                                        : FontWeight.w300,
                                    color: selectIndex == list.indexOf(e)
                                        ? COLOR.color_333333
                                        : COLOR.color_666666.withAlpha(180)),
                              )
                            ],
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
        ),
      );
    }
  }

  Widget buildSelectList() {
    return GetBuilder<BannedTheStrangeCaseLogic>(
        id: "buildSelectBtn",
        builder: (context) {
          return Container(
            margin: EdgeInsets.only(left: 8.w),
            child: Column(
              children: [
                buildSelectBtn(
                    state.list1.map((e) => "${e.classifyTitle}").toList(),
                    0,
                    state.index1),
              ],
            ),
          );
        });
  }
}
