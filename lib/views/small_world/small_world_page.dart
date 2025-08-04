import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:xhs_app/components/app_bg_view.dart';
import 'package:xhs_app/components/rich_text_view.dart';
import 'package:xhs_app/components/tab_bar_indicator/easy_fixed_indicator.dart';
import 'package:xhs_app/components/text_view.dart';
import 'package:xhs_app/generate/app_image_path.dart';
import 'package:xhs_app/http/api/api.dart';
import 'package:xhs_app/model/video/video_classify_model.dart';
import 'package:xhs_app/routes/routes.dart';
import 'package:xhs_app/services/user_service.dart';
import 'package:xhs_app/utils/color.dart';
import 'package:xhs_app/utils/extension.dart';
import 'package:xhs_app/views/small_world/small_word_child_page.dart';

import '../../utils/logger.dart';

// 禁播奇案
class SmallWorldPage extends StatefulWidget {
  final int mark;

  const SmallWorldPage({super.key, required this.mark});

  @override
  State<SmallWorldPage> createState() => _SmallWorldPageState();
}

class _SmallWorldPageState extends State<SmallWorldPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  ///分类
  List<VideoClassifyModel> tabs = <VideoClassifyModel>[];

  ///是否是main
  bool get isMain => widget.mark == 1;

  ///获取分类
  getClassify() {
    Api.getShortVideoClassify(mark: widget.mark).then((value) {
      if (value.isNotEmpty) {
        tabs.clear();
        if (widget.mark == 3) {
          value.insert(0, VideoClassifyModel.fromJson({"classifyTitle": "全部"}));
        }
        tabs.assignAll(value);
        tabController = TabController(length: tabs.length, vsync: this);
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  @override
  void initState() {
    getClassify();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key('forbidden'),
      onVisibilityChanged: (info) {
        final visible = info.visibleFraction;
        logger.d('small world visibility >>>>> $visible');
        if (visible == 1.0 && isMain) {
          Get.find<UserService>().updateAPIUserInfo();
        }
      },
      child: Scaffold(
        appBar: widget.mark == 3
            ? null
            : AppBar(
                automaticallyImplyLeading: false,
                title: const Text('萝莉岛'),
              ),
        body: _buildBodyView(),
      ),
    );
  }

  _buildBodyView() {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          if (tabs.isNotEmpty) _buildTabView(),
          if (isMain) _buildNoWatchedView(),
        ],
      ),
    );
  }

  _buildTabView() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: TabBar(
            controller: tabController,
            tabs: tabs
                .map((e) => Tab(
                      text: e.classifyTitle ?? "",
                    ))
                .toList(),
            labelColor: COLOR.color_333333,
            tabAlignment: TabAlignment.start,
            isScrollable: true,
            labelStyle: TextStyle(
              fontSize: 12.w,
              fontWeight: FontWeight.w500,
              color: COLOR.color_333333,
            ),
            unselectedLabelColor: COLOR.color_999999,
            unselectedLabelStyle: TextStyle(
              fontSize: 12.w,
              color: COLOR.color_999999,
            ),
            padding: EdgeInsets.zero,
            indicator: EasyFixedIndicator(
              color: COLOR.color_FB2D45,
              height: 0.w,
              width: 0.w,
            ),
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: tabs
                .map((e) => SmallWordChildPage(
                      classifyId: e.classifyId ?? 0,
                      videoMark: widget.mark,
                    ).keepAlive)
                .toList(),
          ),
        ),
      ],
    );
  }

  _buildNoWatchedView() {
    return Obx(() {
      final service = Get.find<UserService>();
      if (service.canWatchSmallWorld) return const SizedBox.shrink();
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: AppBgView(
          width: double.infinity,
          height: double.infinity,
          imagePath: AppImagePath.icons_samll_world_bg,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppBgView(
                  backgroundColor: COLOR.black.withOpacity(0.6),
                  radius: 12.w,
                  margin: EdgeInsets.symmetric(horizontal: 40.w),
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Column(
                    children: [
                      23.verticalSpace,
                      TextView(
                        text: '系统警告',
                        color: COLOR.color_FB2D45,
                        fontSize: 17.w,
                        fontWeight: FontWeight.w500,
                      ),
                      29.verticalSpace,
                      TextView(
                        text: '萝莉岛含有全球禁止流出及其稀缺资源，'
                            '独家黑料，暴虐强奸，变态重口血腥战场，同性人妖，泄物人兽，禁漫呦呦，少女破处，N号房等等，'
                            '稀缺资源！仅对少量用户开放，内容过于真实可能引起极度不适，请谨慎进入，禁止分享传播，',
                        color: COLOR.white,
                        fontSize: 13.w,
                      ),
                      23.verticalSpace,
                      RichTextView(
                        text: '马上开萝莉岛专属卡，即刻解锁无限暗网视频资格',
                        style: TextStyle(
                          color: COLOR.white,
                          fontSize: 13.w,
                        ),
                        specifyTexts: const ['萝莉岛专属卡', '解锁无限暗网视频资格'],
                        highlightStyle: TextStyle(
                          color: COLOR.color_FB2D45,
                          fontSize: 13.w,
                        ),
                      ),
                      60.verticalSpace,
                    ],
                  ),
                ),
                20.verticalSpace,
                AppBgView(
                  width: 120.w,
                  height: 40.w,
                  radius: 20.w,
                  backgroundColor: COLOR.color_FB2D45,
                  text: '开通会员',
                  textColor: COLOR.white,
                  textSize: 14.w,
                  onTap: () {
                    Get.toVip();
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
