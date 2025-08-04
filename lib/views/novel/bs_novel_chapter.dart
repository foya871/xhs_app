import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/generate/app_image_path.dart';
import '../../assets/colorx.dart';
import '../../model/fiction/fiction_info_model.dart';

class BsNovelChapter extends StatelessWidget {
  final List<Chapters> chapters;
  final int chapterIndex;

  BsNovelChapter(this.chapters, this.chapterIndex);

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
            height: 20.h,
          ),
          Wrap(
            spacing: 15.w,
            runSpacing: 15.h,
            children: chapters.map((item) => buildChapterItem(item)).toList(),
          ),
        ]));
  }

  Widget buildChapterItem(Chapters item) {
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
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
        child: Text(
          "${item.chapterNum ?? 0}",
          style: TextStyle(
              fontSize: 14.w,
              color: selected ? ColorX.color_fb2d45 : ColorX.color_666666),
        ),
      ),
    );
  }
}
