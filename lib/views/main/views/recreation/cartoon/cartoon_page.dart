import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:xhs_app/assets/colorx.dart';
import 'package:xhs_app/assets/styles.dart';
import 'package:xhs_app/components/ad_banner/classify_ads.dart';
import 'package:xhs_app/components/base_page/base_error_widget.dart';
import 'package:xhs_app/components/base_page/base_loading_widget.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_simple_widget.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_widget.dart';
import 'package:xhs_app/components/comics_cell/comics_cell.dart';
import 'package:xhs_app/components/image_view.dart';
import 'package:xhs_app/components/no_more/no_data.dart';
import 'package:xhs_app/components/no_more/no_data_sliver_masonry_grid.dart';
import 'package:xhs_app/components/tab_bar/expansion_tab_bar.dart';
import 'package:xhs_app/model/axis_cover.dart';
import 'package:xhs_app/model/comics/comics_base.dart';
import 'package:xhs_app/model/video/find_video_classify_model.dart';
import 'package:xhs_app/routes/routes.dart';
import 'package:xhs_app/utils/color.dart';
import 'package:xhs_app/utils/extension.dart';
import 'package:xhs_app/views/main/views/recreation/cartoon/cartoon_logic.dart';
import 'package:xhs_app/views/main/views/recreation/cartoon/cartoon_state.dart';

// 漫画
class CartoonPage extends StatefulWidget {
  const CartoonPage({super.key});

  @override
  State<CartoonPage> createState() => _CartoonPageState();
}

class _CartoonPageState extends State<CartoonPage> {
  final CartoonLogic logic = Get.put(CartoonLogic());
  final CartoonState state = Get.find<CartoonLogic>().state;

  @override
  void initState() {
    super.initState();
    logic.refreshController.pagingControllers.itemList?.clear();
  }

  @override
  void dispose() {
    Get.delete<CartoonLogic>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: logic.obx(
          (_) {
            return Column(
              children: [
                Expanded(
                  child: BaseRefreshWidget(logic.refreshController,
                      child: _buildBody()),
                ),
              ],
            );
          },
          onLoading: const BaseLoadingWidget(),
          onError: (_) =>
              BaseErrorWidget(onTap: logic.refreshCommunityClassify),
        ))
      ],
    );
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
  Widget _buildSliverCommunity() {
    return GetBuilder<CartoonLogic>(builder: (controll) {
      return SliverMasonryGrid.count(
        childCount:
            logic.refreshController.pagingControllers.itemList?.length ?? 0,
        itemBuilder: (ctx, i) => ComicsCell(
            model: logic.refreshController.pagingControllers.itemList![i]),
        mainAxisSpacing: 10.w,
        crossAxisSpacing: 8.w,
        crossAxisCount: 3,
      );
    }).sliverPaddingHorizontal(14.w);
  }

  Widget buildShortVideoCell(FindVideoClassifyModel item) {
    return InkWell(
      onTap: () {
        Get.toComicsDetail(comicsId: item.comicsId ?? 0);
      },
      child: Column(
        children: [
          Stack(
            children: [
              ImageView(
                src: "${logic.refreshController.domain}${item.coverImg}",
                width: double.infinity,
                height: 120.h,
                fit: BoxFit.cover,
                borderRadius: Styles.borderRaidus.m,
                axis: CoverImgAxis.horizontal,
              ),
              Positioned(
                  top: 6.w,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: (item.isEnd ?? false)
                            ? const Color(0xFFFF8652)
                            : const Color(0xFFFF4B5F),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20.w),
                            bottomRight: Radius.circular(20.w))),
                    width: 40.w,
                    height: 16.w,
                    child: Text(
                      (item.isEnd ?? false) ? "已完结" : "连载中",
                      style: TextStyle(fontSize: 10.sp, color: Colors.white),
                    ),
                  ))
            ],
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(
            item.comicsTitle ?? "",
            style: TextStyle(fontSize: 13.sp, color: ColorX.color_333333),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  buildSelectBtn(List<String> list, int index, int selectIndex) {
    {
      return SizedBox(
        width: 1.sw,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 8.w),
              alignment: Alignment.centerLeft,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: list
                      .map((e) => GestureDetector(
                            onTap: () {
                              Get.log(
                                  "=======>参数  childIndex  ${list.indexOf(e)} index   $index");
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
                                        color:
                                            COLOR.color_666666.withAlpha(150)),
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  Text(
                                    e,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 13.w,
                                        fontWeight:
                                            list.indexOf(e) == selectIndex
                                                ? FontWeight.w600
                                                : FontWeight.w300,
                                        color: list.indexOf(e) == selectIndex
                                            ? COLOR.color_333333
                                            : COLOR.color_666666
                                                .withAlpha(180)),
                                  )
                                ],
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
            )
          ],
        ),
      );
    }
  }

  Widget buildSelectList() {
    return GetBuilder<CartoonLogic>(
        id: "buildSelectBtn",
        builder: (context) {
          Get.log(
              "=========>index1 后 ${state.index1}  index2 ${state.index2}  index3 ${state.index3}  index4 ${state.index4}   index5 ${state.index5}");
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            child: Column(
              children: [
                buildSelectBtn(state.list1.map((e) => "${e.title}").toList(), 0,
                    state.index1),
                buildSelectBtn(state.list2, 1, state.index2),
                buildSelectBtn(state.list3.map((e) => "${e.title}").toList(), 2,
                    state.index3),
                buildSelectBtn(state.list4, 3, state.index4),
                buildSelectBtn(state.list5, 4, state.index5),
              ],
            ),
          );
        });
  }
}
