import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_widget.dart';
import 'package:xhs_app/components/image_view.dart';
import 'package:xhs_app/components/no_more/no_data.dart';
import 'package:xhs_app/components/text_view.dart';
import 'package:xhs_app/generate/app_image_path.dart';
import 'package:xhs_app/model/mine/profit_model.dart';
import 'package:xhs_app/routes/routes.dart';
import 'package:xhs_app/utils/color.dart';
import 'package:xhs_app/utils/extension.dart';

import 'mine_profit_page_controller.dart';

class MineProfitView extends StatelessWidget {
  final String title;
  const MineProfitView({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MineProfitPageController>(tag: title);
    if (title == "笔记收益") {
      controller.incomeType.value = 1;
    } else if (title == "粉丝团收益") {
      controller.incomeType.value = 2;
    } else if (title == "下载资源收益") {
      controller.incomeType.value = 3;
    }
    controller.onRefresh();
    return BaseRefreshWidget(
      controller,
      child: PagedListView<int, ProfitModel>(
        padding: EdgeInsets.only(top: 10, left: 14.w, right: 14.w),
        addAutomaticKeepAlives: true,
        pagingController: controller.pagingControllers,
        builderDelegate: PagedChildBuilderDelegate<ProfitModel>(
          firstPageProgressIndicatorBuilder: (context) =>
              const SizedBox.shrink(),
          newPageProgressIndicatorBuilder: (context) => const SizedBox.shrink(),
          noMoreItemsIndicatorBuilder: (context) => const SizedBox.shrink(),
          noItemsFoundIndicatorBuilder: (context) => const NoData(),
          itemBuilder: (context, item, index) {
            return title == "粉丝团收益"
                ? Container(
                    width: 333.w,
                    height: 84.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6.w),
                    ),
                    child: Row(
                      children: [
                        Row(
                          children: [
                            ImageView(
                                src: item.image ?? "",
                                width: 60.w,
                                height: 60.w,
                                borderRadius: BorderRadius.circular(30.w)),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextView(
                                    text: item.name ?? "",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13.w,
                                    color: COLOR.color_333333),
                                TextView(
                                        text: item.createdAt ?? "",
                                        fontSize: 12.w,
                                        color: COLOR.color_999999)
                                    .marginHorizontal(5.w),
                                TextView(
                                    text: item.desc ?? "",
                                    fontSize: 12.w,
                                    color: COLOR.color_999999),
                              ],
                            )
                          ],
                        ),
                        TextView(
                            text: "+${item.gold}",
                            fontWeight: FontWeight.w600,
                            fontSize: 20.w,
                            color: COLOR.color_faa06a),
                      ],
                    ),
                  )
                : Container(
                    width: 333.w,
                    height: 84.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6.w),
                    ),
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Stack(
                              children: [
                                ImageView(
                                    src: item.image ?? "",
                                    width: 60.w,
                                    height: 60.w,
                                    borderRadius: BorderRadius.circular(4.w)),
                                Positioned(
                                    child: Center(
                                  child: ImageView(
                                      src: AppImagePath.mine_icon_bofang,
                                      width: 25.w,
                                      height: 20.w),
                                ))
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextView(
                                    text: item.name ?? "",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13.w,
                                    color: COLOR.color_333333),
                                TextView(
                                        text: item.createdAt ?? "",
                                        fontSize: 12.w,
                                        color: COLOR.color_999999)
                                    .marginHorizontal(5.w),
                                Row(
                                  children: [
                                    TextView(
                                        text: "总收益：",
                                        fontSize: 12.w,
                                        color: COLOR.color_999999),
                                    TextView(
                                        text: "${item.gold}金币",
                                        fontSize: 12.w,
                                        color: COLOR.color_faa06a),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                        TextView(
                                text: "查看详情>",
                                fontWeight: FontWeight.w400,
                                fontSize: 12.w,
                                color: COLOR.color_666666)
                            .onTap(() {
                          if (title == "笔记收益") {
                            Get.toIncomeVideoDetail(
                                videoId: item.id ?? 0, videoMark: 0);
                          } else if (title == "下载资源收益") {
                            Get.toIncomeVideoDetail(
                                videoId: item.id ?? 0, videoMark: 1);
                          }
                        }),
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}
