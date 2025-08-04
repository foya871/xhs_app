import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:xhs_app/assets/colorx.dart';
import 'package:xhs_app/assets/styles.dart';
import 'package:xhs_app/components/ad/ad_enum.dart';
import 'package:xhs_app/components/ad_banner/classify_ads.dart';
import 'package:xhs_app/components/ad_banner/insert_ad.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_widget.dart';
import 'package:xhs_app/components/image_view.dart';
import 'package:xhs_app/components/no_more/no_data.dart';
import 'package:xhs_app/model/axis_cover.dart';
import 'package:xhs_app/model/video/community_resource_classify_model.dart';
import 'package:xhs_app/model/video/fiction_base_find_model.dart';
import 'package:xhs_app/model/video/intension_map_base_model.dart';
import 'package:xhs_app/routes/routes.dart';
import 'package:xhs_app/utils/color.dart';
import 'package:xhs_app/utils/extension.dart';
import 'package:xhs_app/views/main/views/recreation/fiction/fiction_logic.dart';
import 'package:xhs_app/views/main/views/recreation/fiction/fiction_state.dart';
import 'package:xhs_app/views/main/views/recreation/intension_map/intension_map_logic.dart';
import 'package:xhs_app/views/main/views/recreation/intension_map/intension_map_state.dart';

import '../../../../../model/video/find_video_classify_model.dart';

// 小说
class IntensionMapPage extends StatefulWidget {
  const IntensionMapPage({super.key});

  @override
  State<IntensionMapPage> createState() => _IntensionMapPageState();
}

class _IntensionMapPageState extends State<IntensionMapPage> {
  final IntensionMapLogic logic = Get.put(IntensionMapLogic());
  final IntensionMapState state = Get.find<IntensionMapLogic>().state;

  @override
  void dispose() {
    Get.delete<IntensionMapLogic>();
    super.dispose();
  }

  Widget _buildSliverCommunity() {
    return GetBuilder<IntensionMapLogic>(builder: (controller) {
      Get.log("===========>刷新完成");
      return SliverMasonryGrid.count(
        childCount:
            logic.refreshController.pagingControllers.itemList?.length ?? 0,
        itemBuilder: (ctx, i) => buildShortVideoCell(
            logic.refreshController.pagingControllers.itemList![i]),
        mainAxisSpacing: 20.w,
        crossAxisSpacing: 8.w,
        crossAxisCount: 1,
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
        //     child: PagedGridView<int, IntensionMapBaseFindModel>(
        //       padding: EdgeInsets.only(top: 10, left: 14.w, right: 14.w),
        //       addAutomaticKeepAlives: true,
        //       pagingController: logic.refreshController.pagingControllers,
        //       builderDelegate:
        //           PagedChildBuilderDelegate<IntensionMapBaseFindModel>(
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
        //           mainAxisSpacing: 20.w,
        //           crossAxisSpacing: 8.w,
        //           crossAxisCount: 1,
        //           childAspectRatio: 400 / 100
        //
        //           ),
        //     ),
        //   ),
        // ),
      ],
    );
  }

  Widget buildShortVideoCell(IntensionMapBaseFindModel item) {
    if (item.isAd) {
      return InsertAd(
        adress: item.ad!,
        height: 80.w,
        spacing: 12.w,
        showMark: false,
        showName: false,
        borderRadius: Styles.borderRadius.m,
      );
    }
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.intensionMapDetailPage, parameters: {
          "connotationId": "${item.connotationId}",
          "title": item.title ?? ""
        });
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ImageView(
            src: "${item.coverImg}",
            width: 130.w,
            height: 80.w,
            fit: BoxFit.cover,
            borderRadius: Styles.borderRaidus.m,
            axis: CoverImgAxis.horizontal,
          ),
          SizedBox(
            width: 12.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 180.w,
                    child: Text(
                      item.title ?? "",
                      maxLines: 2,
                      style:
                          TextStyle(fontSize: 13.w, color: ColorX.color_333333),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    width: 140.w,
                    child: Text(
                      item.summary ?? "",
                      style:
                          TextStyle(fontSize: 13.w, color: ColorX.color_666666),
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
              Container(
                width: 120.w,
                child: Text(
                  item.checkAt ?? "",
                  style: TextStyle(fontSize: 13.w, color: ColorX.color_999999),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  buildSelectBtn(List<String> list, int index) {
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
                          logic.setListIndex(list, list.indexOf(e));
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
                                    color: index == list.indexOf(e)
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
    return GetBuilder<IntensionMapLogic>(
        id: "buildSelectBtn",
        builder: (context) {
          return Container(
            margin: EdgeInsets.only(left: 8.w),
            child: Column(
              children: [
                buildSelectBtn(
                    state.list1.map((e) => "${e.name}").toList(), state.index1),
              ],
            ),
          );
        });
  }
}
