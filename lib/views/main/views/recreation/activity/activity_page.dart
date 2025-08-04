import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:xhs_app/assets/colorx.dart';
import 'package:xhs_app/assets/styles.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_widget.dart';
import 'package:xhs_app/components/image_view.dart';
import 'package:xhs_app/components/no_more/no_data.dart';
import 'package:xhs_app/model/axis_cover.dart';
import 'package:xhs_app/model/fiction/fiction_base_model.dart';
import 'package:xhs_app/model/video/fiction_base_find_model.dart';
import 'package:xhs_app/routes/routes.dart';
import 'package:xhs_app/utils/color.dart';
import 'package:xhs_app/views/main/views/recreation/activity/activity_logic.dart';
import 'package:xhs_app/views/main/views/recreation/activity/activity_state.dart';
import 'package:xhs_app/views/main/views/recreation/fiction/fiction_logic.dart';
import 'package:xhs_app/views/main/views/recreation/fiction/fiction_mask_down.dart';
import 'package:xhs_app/views/main/views/recreation/fiction/fiction_state.dart';

// 小说
class ActivityPage extends StatefulWidget {
  const ActivityPage({Key? key}) : super(key: key);

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  final ActivityLogic logic = Get.put(ActivityLogic());
  final ActivityState state = Get.find<ActivityLogic>().state;

  @override
  void dispose() {
    Get.delete<ActivityLogic>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSelectList(),
        Expanded(
          child: BaseRefreshWidget(
            logic.refreshController,
            refreshOnStart: false,
            child: PagedGridView<int, FictionBase>(
              padding: EdgeInsets.only(top: 10, left: 14.w, right: 14.w),
              addAutomaticKeepAlives: true,
              pagingController: logic.refreshController.pagingControllers,
              builderDelegate: PagedChildBuilderDelegate<FictionBase>(
                firstPageProgressIndicatorBuilder: (context) =>
                    const SizedBox.shrink(),
                newPageProgressIndicatorBuilder: (context) =>
                    const SizedBox.shrink(),
                noMoreItemsIndicatorBuilder: (context) =>
                    const SizedBox.shrink(),
                noItemsFoundIndicatorBuilder: (context) => const NoData(),
                itemBuilder: (context, item, index) => buildNovelCell(item, () {
                  Get.toNovelDetail(id: item.fictionId ?? 0)?.then((value) {
                    logic.loadResourceClassify();
                  });
                }),
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 10.w,
                  crossAxisSpacing: 8.w,
                  crossAxisCount: 3,
                  childAspectRatio: 140 / 280),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildNovelCell(FictionBase item, Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ImageView(
                src: "${logic.refreshController.domain}${item.coverImg ?? ""}",
                width: double.infinity,
                height: 140.h,
                fit: BoxFit.cover,
                borderRadius: Styles.borderRaidus.m,
                axis: CoverImgAxis.horizontal,
              ),
              if (item.watched == true)
                Positioned(
                  right: 0,
                  top: 0,
                  child: ClipPath(
                      clipper: FictionMaskDown(
                        up: true,
                      ),
                      child: Container(
                        width: 38.w,
                        height: 38.w,
                        color: Color(0xFFF4B314),
                        child: Stack(
                          children: [
                            Transform.rotate(
                              //旋转的弧度
                              angle: pi / 4,
                              alignment: Alignment.center,
                              //旋转的子Widget
                              child: Container(
                                height: 40.w,
                                padding: EdgeInsets.only(left: 6.w),
                                width: 40.w,
                                child: Text(
                                  "已观看",
                                  style: TextStyle(
                                      fontSize: 8.sp, color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        ),
                      )),
                )
            ],
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(
            item.fictionTitle ?? "",
            style: TextStyle(fontSize: 13.w, color: ColorX.color_333333),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  buildSelectBtn(List<String> list, int index) {
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

  Widget buildSelectList() {
    return GetBuilder<ActivityLogic>(
        id: "buildSelectBtn",
        builder: (context) {
          return Container(
            margin: EdgeInsets.only(left: 8.w),
            child: Column(
              children: [
                buildSelectBtn(state.list1, state.index1),
                buildSelectBtn(state.list2, state.index2),
              ],
            ),
          );
        });
  }
}
