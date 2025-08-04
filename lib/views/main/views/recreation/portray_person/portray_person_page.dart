import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:xhs_app/assets/colorx.dart';
import 'package:xhs_app/assets/styles.dart';
import 'package:xhs_app/components/ad_banner/classify_ads.dart';
import 'package:xhs_app/components/ad_banner/insert_ad.dart';
import 'package:xhs_app/components/base_page/base_error_widget.dart';
import 'package:xhs_app/components/base_page/base_loading_widget.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_widget.dart';
import 'package:xhs_app/components/image_view.dart';
import 'package:xhs_app/components/no_more/no_data.dart';
import 'package:xhs_app/model/axis_cover.dart';
import 'package:xhs_app/model/video/community_resource_classify_model.dart';
import 'package:xhs_app/model/video/fiction_base_find_model.dart';
import 'package:xhs_app/routes/routes.dart';
import 'package:xhs_app/utils/color.dart';
import 'package:xhs_app/utils/extension.dart';
import 'package:xhs_app/views/main/views/recreation/fiction/fiction_logic.dart';
import 'package:xhs_app/views/main/views/recreation/fiction/fiction_state.dart';
import 'package:xhs_app/views/main/views/recreation/portray_person/portray_person_logic.dart';

import '../../../../../model/picture_cell_model/picture_cell_model.dart';
import '../../../../../model/video/find_video_classify_model.dart';
import 'portray_person_state.dart';

// 写真
class PortrayPersonPage extends StatefulWidget {
  const PortrayPersonPage({super.key});

  @override
  State<PortrayPersonPage> createState() => _PortrayPersonPageState();
}

class _PortrayPersonPageState extends State<PortrayPersonPage> {
  final PortrayPersonLogic logic = Get.put(PortrayPersonLogic());
  final PortrayPersonState state = Get.find<PortrayPersonLogic>().state;

  @override
  void dispose() {
    Get.delete<PortrayPersonLogic>();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    logic.refreshController.pagingControllers.itemList?.clear();
  }

  Widget _buildSliverCommunity() {
    return GetBuilder<PortrayPersonLogic>(builder: (controll) {
      Get.log(
          "=====================>刷新数据${logic.refreshController.pagingControllers.itemList?.length}");

      return SliverMasonryGrid.count(
        childCount:
            logic.refreshController.pagingControllers.itemList?.length ?? 0,
        itemBuilder: (ctx, i) => buildShortVideoCell(
            logic.refreshController.pagingControllers.itemList![i], () {
          Get.toPortrayPlay(
              portrayPicId: logic.refreshController.pagingControllers
                      .itemList![i].portrayPicId ??
                  0);
        }),
        mainAxisSpacing: 10.w,
        crossAxisSpacing: 8.w,
        crossAxisCount: 3,
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
        // const ClassifyAds(),
        // buildSelectList(),
        Expanded(
          child: Expanded(
            child: BaseRefreshWidget(logic.refreshController,
                enableLoad: true, refreshOnStart: true, child: _buildBody()),
          ),
        )

        // Expanded(
        //   child: BaseRefreshWidget(
        //     logic.refreshController,
        //     refreshOnStart: false,
        //     child: PagedGridView<int, PictureCellModel>(
        //       padding: EdgeInsets.only(top: 10, left: 14.w, right: 14.w),
        //       addAutomaticKeepAlives: true,
        //       pagingController: logic.refreshController.pagingControllers,
        //       builderDelegate: PagedChildBuilderDelegate<PictureCellModel>(
        //         firstPageProgressIndicatorBuilder: (context) =>
        //         const SizedBox.shrink(),
        //         newPageProgressIndicatorBuilder: (context) =>
        //         const SizedBox.shrink(),
        //         noMoreItemsIndicatorBuilder: (context) => const SizedBox.shrink(),
        //         noItemsFoundIndicatorBuilder: (context) => const NoData(),
        //         itemBuilder: (context, item, index) =>
        //
        //         buildShortVideoCell(item,(){
        //           Get.toPortrayPlay(portrayPicId: item.portrayPicId ?? 0);
        //         }),
        //       ),
        //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //           mainAxisSpacing: 10.w,
        //           crossAxisSpacing: 8.w,
        //           crossAxisCount: 3,
        //           childAspectRatio: 140 / 280),
        //
        //     ),
        //   ),
        // ),
      ],
    );
  }

  Widget buildShortVideoCell(PictureCellModel item, Function()? onTap) {
    if (item.isAd) {
      return InsertAd(
        adress: item.ad!,
        height: 140.w,
        spacing: 5.w,
        showMark: false,
        showName: true,
        borderRadius: Styles.borderRaidus.m,
      );
    }
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ImageView(
                src: item.coverImg ?? "",
                width: double.infinity,
                height: 140.w,
                fit: BoxFit.cover,
                borderRadius: Styles.borderRaidus.m,
                axis: CoverImgAxis.horizontal,
              ),
              Positioned(
                  right: 5.w,
                  bottom: 5.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(80),
                      borderRadius: BorderRadius.all(Radius.circular(35)),
                    ),
                    child: Text(
                      "${item.imgNum}张",
                      style: TextStyle(fontSize: 10.sp, color: Colors.white),
                    ),
                  ))
            ],
          ),
          SizedBox(
            height: 5.w,
          ),
          Text(
            item.title ?? "",
            style: TextStyle(fontSize: 13.sp, color: ColorX.color_333333),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  buildSelectBtn(List<String> list, int index, int selectIndex) {
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
                        logic.setListIndex(list.indexOf(e), index);
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
                                  fontWeight: list.indexOf(e) == selectIndex
                                      ? FontWeight.w600
                                      : FontWeight.w300,
                                  color: list.indexOf(e) == selectIndex
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

  Widget buildSelectList() {
    return GetBuilder<PortrayPersonLogic>(
        id: "buildSelectBtn",
        builder: (context) {
          return Container(
            margin: EdgeInsets.only(left: 8.w),
            child: Column(
              children: [
                buildSelectBtn(state.list1.map((e) => "${e.title}").toList(), 0,
                    state.index1),
                buildSelectBtn(state.list2, 1, state.index2),
              ],
            ),
          );
        });
  }
}
