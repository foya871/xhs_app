import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/components/image_view.dart';
import 'package:xhs_app/routes/routes.dart';
import 'package:xhs_app/utils/dialog_utils.dart';
import 'package:xhs_app/utils/widget_utils.dart';

import '../../assets/colorx.dart';
import '../../assets/styles.dart';
import '../../generate/app_image_path.dart';
import '../../model/axis_cover.dart';
import '../../model/comics/comic_detail_model.dart';
import 'comic_detail_logic.dart';
import 'comic_detail_state.dart';

//娱乐页面
class ComicDetailPage extends StatelessWidget {
  ComicDetailPage({Key? key}) : super(key: key);

  final ComicDetailLogic logic =
      Get.put(ComicDetailLogic(), tag: Get.parameters['comicId']);
  final ComicDetailState state =
      Get.find<ComicDetailLogic>(tag: Get.parameters['comicId']).state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: ColorX.color_FaFaFa,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Obx(() {
                        return ImageView(
                          src: state.comicDetail.value.backImg ?? "",
                          width: 1.sw,
                          height: 180.h,
                          fit: BoxFit.cover,
                        );
                      }),
                      Positioned(
                          left: 15.w,
                          bottom: 10.h,
                          right: 15.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Obx(() {
                                var end = state.comicDetail.value.isEnd == true
                                    ? "已完结"
                                    : "连载中";
                                var num =
                                    state.comicDetail.value.chapterNewNum ?? 0;
                                var likeNum =
                                    state.comicDetail.value.fakeLikes ?? 0;
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      state.comicDetail.value.comicsTitle ?? "",
                                      style: TextStyle(
                                          fontSize: 18.w,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 8.h,
                                    ),
                                    Text(
                                      "$end｜共$num话｜$likeNum次收藏",
                                      style: TextStyle(
                                          fontSize: 12.w, color: Colors.white),
                                    ),
                                  ],
                                );
                              }),
                              GestureDetector(
                                onTap: () => logic.comicsLike(
                                    state.comicDetail.value.isLike ?? false),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Obx(() {
                                      if (state.comicDetail.value.isLike ==
                                          true) {
                                        return Image.asset(
                                          AppImagePath.player_collect_y,
                                          width: 22.r,
                                        );
                                      } else {
                                        return Image.asset(
                                          AppImagePath.icons_ic_star_0,
                                          width: 22.r,
                                        );
                                      }
                                    }),
                                    SizedBox(
                                      height: 8.h,
                                    ),
                                    Text(
                                      "收藏",
                                      style: TextStyle(
                                          fontSize: 13.w, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Text(
                      "详情",
                      style: TextStyle(
                          fontSize: 15.w,
                          color: ColorX.color_333333,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Obx(() {
                      return Text(
                        state.comicDetail.value.info ?? "",
                        style: TextStyle(
                            fontSize: 13.w, color: ColorX.color_666666),
                      );
                    }),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(() {
                          var end = state.comicDetail.value.isEnd == true
                              ? "已完结"
                              : "连载中";
                          return Text(
                            end,
                            style: TextStyle(
                                fontSize: 15.w,
                                color: ColorX.color_333333,
                                fontWeight: FontWeight.w500),
                          );
                        }),
                        GestureDetector(
                          onTap: () {
                            DialogUtils.showComicsChapterSheet(
                                    context,
                                    state.comicDetail.value.chapterList ?? [],
                                    state.selectIndex.value)
                                .then((index) {
                              if (index != null) {
                                state.selectIndex.value = index;
                                Get.toNamed(Routes.comicChapter,
                                    arguments: state
                                        .comicDetail.value.chapterList?[index]);
                              }
                            });
                          },
                          child: Row(
                            children: [
                              Obx(() {
                                return Text(
                                  "更新至${state.comicDetail.value.chapterNewNum ?? 0}话",
                                  style: TextStyle(
                                      fontSize: 13.w,
                                      color: ColorX.color_999999),
                                );
                              }),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 13.r,
                                color: ColorX.color_999999,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Obx(() {
                      state.selectIndex.value == 0;
                      var list =
                          (state.comicDetail.value.chapterList?.length ?? 0) > 6
                              ? state.comicDetail.value.chapterList
                                  ?.sublist(0, 6)
                              : state.comicDetail.value.chapterList;
                      return Wrap(
                        spacing: 15.w,
                        children: list
                                ?.map((item) => buildChapterItem(item))
                                .toList() ??
                            [],
                      );
                    }),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Visibility(
                    visible: false,
                    child: Center(
                      child: WidgetUtils.buildElevatedButton(
                          "购买会员观看完整版", 320.w, 40.h,
                          backgroundColor: ColorX.color_ffaa77,
                          borderRadius: BorderRadius.circular(20.r),
                          textColor: ColorX.color_bb602a,
                          onPressed: () {}),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "猜你喜欢",
                          style: TextStyle(
                              fontSize: 15.w,
                              color: ColorX.color_333333,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Obx(() {
                      var list = state.recommendComic;
                      return Wrap(
                        spacing: 6.w,
                        alignment: WrapAlignment.center,
                        children: list
                            .map((item) => buildComicsVideoCell(item, () {
                                  Get.toComicsDetail(
                                      comicsId: item.comicsId ?? 0);
                                }))
                            .toList(),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (GetUtils.isNullOrBlank(state.comicDetail.value.chapterList) !=
                  true) {
                state.selectIndex.value =
                    state.selectIndex.value > 0 ? state.selectIndex.value : 0;
                Get.toNamed(Routes.comicChapter,
                    arguments: state.comicDetail.value
                        .chapterList?[state.selectIndex.value]);
              }
            },
            child: Container(
              height: 50.h,
              color: Colors.white,
              alignment: Alignment.center,
              child: Text(
                "开始阅读",
                style: TextStyle(
                    fontSize: 15.w,
                    color: ColorX.color_fb2d45,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildChapterItem(ChapterList item) {
    var selected = state.comicDetail.value.chapterList?.indexOf(item) ==
        state.selectIndex.value;
    return GestureDetector(
      onTap: () {
        state.selectIndex.value =
            state.comicDetail.value.chapterList?.indexOf(item) ?? 0;
        Get.toNamed(Routes.comicChapter, arguments: item);
      },
      child: Container(
        decoration: BoxDecoration(
            color: selected
                ? ColorX.color_fb2d45.withOpacity(0.2)
                : ColorX.color_eeeeee,
            borderRadius: BorderRadius.all(Radius.circular(5.r))),
        width: 42.w,
        height: 30.h,
        alignment: Alignment.center,
        child: Text(
          "${item.chapterNum ?? 0}",
          style: TextStyle(
              fontSize: 14.w,
              color: selected ? ColorX.color_fb2d45 : ColorX.color_666666),
        ),
      ),
    );
  }

  Widget buildComicsVideoCell(ComicDetailModel item, Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 106.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ImageView(
                  src: "${item.coverImg}",
                  width: double.infinity,
                  height: 130.h,
                  fit: BoxFit.cover,
                  borderRadius: Styles.borderRaidus.xs,
                  axis: CoverImgAxis.horizontal,
                ),
                Positioned(
                  top: 14.h,
                  left: 0,
                  child: Image.asset(
                    item.isEnd == true
                        ? AppImagePath.search_ic_work_end
                        : AppImagePath.search_ic_work_ing,
                    height: 15.h,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              item.comicsTitle ?? "",
              style: TextStyle(
                  fontSize: 13.w,
                  color: ColorX.color_333333,
                  fontWeight: FontWeight.w500),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
