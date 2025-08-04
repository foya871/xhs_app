import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/components/image_view.dart';

import '../../../utils/dialog_utils.dart';
import 'comics_chapter_logic.dart';
import 'comics_chapter_state.dart';

class ComicsChapterPage extends StatefulWidget {
  const ComicsChapterPage({Key? key}) : super(key: key);

  @override
  State<ComicsChapterPage> createState() => _ComicsChapterPageState();
}

class _ComicsChapterPageState extends State<ComicsChapterPage> {
  final ComicsChapterLogic logic = Get.put(ComicsChapterLogic());
  final ComicsChapterState state = Get.find<ComicsChapterLogic>().state;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<ComicsChapterLogic>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Obx(() {
          return Text(state.chapterDetail.value.chapterTitle ?? '');
        }),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Obx(() {
              return Column(
                children: state.chapterDetail.value.imgList?.map((item) {
                      return ImageView(
                        src: item ?? '',
                        fit: BoxFit.cover,
                      );
                    }).toList() ??
                    [],
              );
            }),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 35.h,
            child: Obx(() {
              if (((state.comicDetail.value.chapterList?.length ?? 0) <= 1))
                return Container();
              return Row(
                children: [
                  Obx(() {
                    return Visibility(
                      visible: state.chapterIndex.value > 0,
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      child: GestureDetector(
                        onTap: () =>
                            logic.jumpPage(state.chapterIndex.value - 1),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 10.h),
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.3),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20.r),
                                  bottomRight: Radius.circular(20.r))),
                          child: Text(
                            "上一话",
                            style: TextStyle(
                                fontSize: 15.w,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    );
                  }),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      DialogUtils.showComicsChapterSheet(
                              context,
                              state.comicDetail.value.chapterList ?? [],
                              state.chapterIndex.value)
                          .then((index) {
                        if (index != null) {
                          logic.jumpPage(index);
                        }
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 10.h),
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.r))),
                      child: Text(
                        "目录",
                        style: TextStyle(
                            fontSize: 15.w,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  Spacer(),
                  Obx(() {
                    return Visibility(
                      visible: state.chapterIndex.value <
                          (state.comicDetail.value.chapterList?.length ?? 0) -
                              1,
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      child: GestureDetector(
                          onTap: () =>
                              logic.jumpPage(state.chapterIndex.value + 1),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 10.h),
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.3),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20.r),
                                    bottomLeft: Radius.circular(20.r))),
                            child: Text(
                              "下一话",
                              style: TextStyle(
                                  fontSize: 15.w,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          )),
                    );
                  }),
                ],
              );
            }),
          )
        ],
      ),
    );
  }
}
