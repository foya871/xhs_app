import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/generate/app_image_path.dart';
import 'package:xhs_app/model/comics/comic_detail_model.dart';
import '../../assets/colorx.dart';
// import '../../model/fiction/fiction_info_model.dart';
import '../../utils/utils.dart';

class BsComicsChapter extends StatelessWidget {
  final List<ChapterList> chapters;
  final int chapterIndex;

  BsComicsChapter(this.chapters, this.chapterIndex, {super.key});

  late var groupList = Utils.chunkList<ChapterList>(chapters, 50);
  var selectedIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        child: Column(children: [
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 40.w,
              ),
              Text(
                "选集",
                style: TextStyle(fontSize: 16.w, color: ColorX.color_333333),
              ),
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  padding: EdgeInsets.all(10.r),
                  child: Image.asset(
                    AppImagePath.icons_close,
                    width: 15.r,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Obx(() {
              selectedIndex.value == 0;
              return Row(
                children: groupList
                    .map((group) =>
                        buildGroupItem(groupList.indexOf(group), group))
                    .toList(),
              );
            }),
          ),
          SizedBox(
            height: 10.h,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Obx(() {
                return Wrap(
                  spacing: 15.w,
                  runSpacing: 15.h,
                  children: groupList[selectedIndex.value]
                      .map((item) => buildChapterItem(item))
                      .toList(),
                );
              }),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
        ]));
  }

  Widget buildChapterItem(ChapterList item) {
    var selected = chapters.indexOf(item) == chapterIndex;
    return GestureDetector(
      onTap: () {
        Get.back(result: chapters.indexOf(item));
      },
      child: Container(
        decoration: BoxDecoration(
            color: selected
                ? ColorX.color_fb2d45.withOpacity(0.2)
                : ColorX.color_eeeeee,
            borderRadius: BorderRadius.all(Radius.circular(5.r))),
        width: 50.w,
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

  Widget buildGroupItem(int index, List<ChapterList> group) {
    var selected = selectedIndex.value == index;
    return GestureDetector(
      onTap: () {
        selectedIndex.value = index;
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: selected
              ? ColorX.color_fb2d45.withOpacity(0.2)
              : ColorX.color_eeeeee,
        ),
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
        margin: EdgeInsets.only(right: 10.w),
        child: Text(
          "${index * 50 + 1}-${(index + 1) * 50}",
          style: TextStyle(
              fontSize: 12.w,
              color: selected ? ColorX.color_fb2d45 : ColorX.color_666666),
        ),
      ),
    );
  }
}
