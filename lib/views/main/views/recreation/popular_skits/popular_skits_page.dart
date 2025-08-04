import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:xhs_app/assets/colorx.dart';
import 'package:xhs_app/assets/styles.dart';
import 'package:xhs_app/components/ad_banner/classify_ads.dart';
import 'package:xhs_app/components/ad_banner/insert_ad.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_widget.dart';
import 'package:xhs_app/components/image_view.dart';
import 'package:xhs_app/components/no_more/no_data.dart';
import 'package:xhs_app/model/axis_cover.dart';

import 'package:xhs_app/model/video/popular_skits_base_model.dart';
import 'package:xhs_app/routes/routes.dart';
import 'package:xhs_app/utils/color.dart';
import 'package:xhs_app/utils/extension.dart';
import 'package:xhs_app/views/main/views/recreation/popular_skits/popular_skits_logic.dart';
import 'package:xhs_app/views/main/views/recreation/popular_skits/popular_skits_state.dart';

// 热门短剧
class PopularSkitsPage extends StatefulWidget {
  const PopularSkitsPage({super.key});

  @override
  State<PopularSkitsPage> createState() => _PopularSkitsPageState();
}

class _PopularSkitsPageState extends State<PopularSkitsPage> {
  final PopularSkitsLogic logic = Get.put(PopularSkitsLogic());
  final PopularSkitsState state = Get.find<PopularSkitsLogic>().state;

  @override
  void dispose() {
    Get.delete<PopularSkitsLogic>();
    super.dispose();
  }

  Widget _buildSliverCommunity() {
    return GetBuilder<PopularSkitsLogic>(builder: (controller) {
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
      ],
    );
  }

  Widget buildShortVideoCell(PopularSkitsBaseFindModel item) {
    if (item.isAd) {
      return InsertAd(
        adress: item.ad!,
        height: 230.w,
        showMark: false,
        showName: true,
        spacing: 5.w,
        borderRadius: Styles.borderRaidus.m,
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ImageView(
          src: "${item.coverImg}",
          width: double.infinity,
          height: 230.w,
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
        SizedBox(
          height: 4.w,
        ),
        Text(
          "  更新至${item.serialVideoNum ?? 0}集",
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
    return GetBuilder<PopularSkitsLogic>(
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
                buildSelectBtn(state.list2, 1, state.index2),
              ],
            ),
          );
        });
  }
}
