import 'package:downloadsfolder/downloadsfolder.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:screenshot/screenshot.dart';
import 'package:xhs_app/assets/colorx.dart';
import 'package:xhs_app/generate/app_image_path.dart';
import 'package:xhs_app/utils/dialog_utils.dart';

import '../../../../webview/webview_android.dart';
import '../../../../webview/webview_web.dart';
import 'novel_detail_logic.dart';
import 'novel_detail_state.dart';

class NovelDetailPage extends StatefulWidget {
  const NovelDetailPage({Key? key}) : super(key: key);

  @override
  State<NovelDetailPage> createState() => _NovelDetailPageState();
}

class _NovelDetailPageState extends State<NovelDetailPage> {
  final NovelDetailLogic logic = Get.put(NovelDetailLogic());
  final NovelDetailState state = Get.find<NovelDetailLogic>().state;

  @override
  void dispose() {
    Get.delete<NovelDetailLogic>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage(AppImagePath.community_bg_novel),
              fit: BoxFit.fill,
            )),
            width: 1.sw,
            height: 1.sh,
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 60.h,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 14.w),
                  child: Obx(() {
                    return Text(
                      state.chapterInfo.value.chapterTitle ?? "",
                      style:
                          TextStyle(fontSize: 20.w, color: ColorX.color_333333),
                    );
                  }),
                ),
                Container(
                  padding: EdgeInsets.all(14.r),
                  child: Obx(() {
                    if (GetUtils.isNullOrBlank(
                            state.chapterInfo.value.playPath) ==
                        true) return Container();
                    return Text(
                      state.content.value,
                      style:
                          TextStyle(fontSize: 16.w, color: ColorX.color_333333),
                    );
                  }),
                )
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 35.h,
            child: Obx(() {
              if (((state.fictionInfo.value.chapters?.length ?? 0) <= 1))
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
                      DialogUtils.showNovelChapterSheet(
                              context,
                              state.fictionInfo.value.chapters ?? [],
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
                          (state.fictionInfo.value.chapters?.length ?? 0) - 1,
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
