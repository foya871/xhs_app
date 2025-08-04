/*
 * @Author: wangdazhuang
 * @Date: 2025-03-04 09:56:13
 * @LastEditTime: 2025-03-04 17:06:02
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /xhs_app/lib/views/player/views/video_common_box.dart
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/assets/styles.dart';
import 'package:xhs_app/components/ad/ad_enum.dart';
import 'package:xhs_app/components/ad/ad_info_model.dart';
import 'package:xhs_app/components/easy_button.dart';
import 'package:xhs_app/components/image_view.dart';
import 'package:xhs_app/model/advertisements/ad_resp_model.dart';
import 'package:xhs_app/model/video_base_model.dart';
import 'package:xhs_app/utils/ad_jump.dart';
import 'package:xhs_app/utils/enum.dart';
import 'package:xhs_app/utils/extension.dart';
import 'package:xhs_app/utils/utils.dart';
import 'package:xhs_app/views/player/controllers/video_play_controller.dart';

import '../../../components/grid_view/heighted_grid_view.dart';
import '../../../generate/app_image_path.dart';
import '../../../utils/color.dart';

class VideoCommonBox extends StatelessWidget {
  final VideoPlayController controller;
  const VideoCommonBox({super.key, required this.controller});

  ///视频标题
  Widget _buildTitle() {
    final title = controller.currentVideo.value.title ?? '';
    return Text(
      title,
      style: kTextStyle(Colors.black, fontsize: 16.w, weight: FontWeight.bold),
    );
  }

  /// 发布时间
  Widget _buildTime() {
    final title =
        '${Utils.dateAgo(controller.currentVideo.value.createdAt ?? '')}发布';
    return Text(
      title,
      style: kTextStyle(COLOR.color_666666, fontsize: 12.w),
    );
  }

  ///相关推荐
  Widget _buildRcTitle() {
    return Text(
      '相关推荐',
      style: kTextStyle(Colors.black, fontsize: 16.w, weight: FontWeight.bold),
    ).marginTop(15.w);
  }

  Widget _buildVideosWithList(List<VideoBaseModel> arr,
      {ValueCallback<int>? tap}) {
    return SizedBox(
      width: 332.w,
      child: Wrap(
        spacing: 10.w,
        runSpacing: 10.w,
        children: arr.map((e) {
          final itemw = (332.w - 50.w) / 6.0;
          final isme = e.videoId == controller.currentVideo.value.videoId;
          final bgColor = isme
              ? COLOR.hexColor('#fb2d45').withOpacity(0.1)
              : COLOR.hexColor('#eee');
          final txtColor =
              isme ? COLOR.hexColor('#fb2d45') : COLOR.hexColor('#666');
          final isPay = e.videoType == VideoTypeValueEnum.Pay;

          final index = arr.indexOf(e) + 1;
          return Container(
            width: itemw,
            height: itemw,
            decoration: BoxDecoration(
                color: bgColor, borderRadius: BorderRadius.circular(4.w)),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Center(
                    child: Text(
                      '$index',
                      style: kTextStyle(txtColor,
                          fontsize: 16.w, weight: FontWeight.bold),
                    ),
                  ),
                ),
                if (isme)
                  Positioned(
                    left: 0,
                    bottom: 3.w,
                    child: Image.asset(
                      AppImagePath.player_id_s,
                      width: 9.w,
                      height: 6.w,
                    ),
                  ),
                if (isPay)
                  Positioned(
                    right: 0,
                    top: 2.w,
                    child: Image.asset(
                      AppImagePath.player_pay,
                      width: 18.w,
                      height: 9.w,
                    ),
                  )
              ],
            ),
          ).onTap(() => tap?.call(e.videoId ?? 0));
        }).toList(),
      ),
    );
  }

  ///全部选集
  void _chooseAllVideos() {
    final h = 1.sh - VideoPlayController.videoH;
    final arr = controller.currentVideo.value.videos ?? [];
    Get.bottomSheet(
      SizedBox(
        height: h,
        child: Stack(
          children: [
            Positioned.fill(
              child: Center(
                child: SizedBox(
                  width: 332.w,
                  child: CustomScrollView(
                    slivers: [
                      10.w.verticalSpaceFromWidth.sliverBox,
                      Text("选集",
                              style: kTextStyle(Colors.black,
                                  fontsize: 16.w, weight: FontWeight.bold),
                              textAlign: TextAlign.center)
                          .sliverBox,
                      20.w.verticalSpaceFromWidth.sliverBox,
                      _buildVideosWithList(arr, tap: (_) {
                        controller.fetchVideoDetailById(_);
                        Get.back();
                      }).sliverBox,
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 15.w,
              right: 12.w,
              child: Image.asset(
                AppImagePath.player_cancel,
                width: 16.w,
                height: 16.w,
              ).onTap(() {
                Get.back();
              }),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  ///选集标题
  Widget _serialsTitle() {
    final videos = controller.currentVideo.value.videos ?? [];
    if (videos.isEmpty) return const SizedBox.shrink();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            '选集',
            style: kTextStyle(Colors.black,
                fontsize: 15.w, weight: FontWeight.bold),
          ),
        ),
        Text(
          '全部选集',
          style: kTextStyle(COLOR.color_666666, fontsize: 12.w),
        ),
        5.w.horizontalSpace,
        Image.asset(AppImagePath.player_arrow, width: 11.w, height: 11.w),
      ],
    ).marginOnly(top: 15.w).onTap(_chooseAllVideos);
  }

  ///选集
  Widget _buildSerialVideos() {
    final videos = controller.currentVideo.value.videos ?? [];
    if (videos.isEmpty) return const SizedBox.shrink();
    final arr = videos.length > 6 ? videos.sublist(0, 7) : videos;
    return _buildVideosWithList(
      arr,
      tap: (_) {
        controller.fetchVideoDetailById(_);
      },
    ).marginTop(10.w);
  }

  ///相关推荐
  HeightedGridView _buildVideos() {
    return HeightedGridView.sliver(
      rowSepratorBuilder: (context, index) => SizedBox(height: 12.w),
      crossAxisCount: 2,
      itemCount: controller.guessLikeItems.length,
      columnSpacing: 8.w,
      itemBuilder: (context, index) {
        final item = controller.guessLikeItems.value[index];
        return SizedBox(
          width: 162.w,
          child: Column(
            children: [
              SizedBox(
                width: 162.w,
                height: 90.w,
                child: Stack(
                  children: [
                    ImageView(
                      src: item.hCover,
                      borderRadius: BorderRadius.circular(5.w),
                      width: 162.w,
                      height: 90.w,
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 22.w,
                        decoration:
                            BoxDecoration(image: Styles.gradient.gradientImage),
                        alignment: Alignment.centerRight,
                        child: Text(
                          Utils.secondsToTime(item.playTime ?? 0),
                          style: kTextStyle(Colors.white, fontsize: 10.w),
                        ).marginRight(5.w),
                      ),
                    )
                  ],
                ),
              ),
              6.w.verticalSpaceFromWidth,
              SizedBox(
                width: 162.w,
                child: Text(item.title ?? '',
                    style: kTextStyle(Colors.black, fontsize: 13.w),
                    maxLines: 1),
              ),
            ],
          ),
        ).onTap(() {
          controller.fetchVideoDetailById(item.videoId ?? 0);
        });
      },
    );
  }

  ///广告
  Widget _buildAd() {
    final empty = controller.ad.value.isEmpty;
    if (empty) return const SizedBox.shrink();
    final ad = controller.ad.value;
    return AspectRatio(
      aspectRatio: AdApiType.INSERT_IMAGE.ratio,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ImageView(
            src: ad.adImage ?? '',
            width: double.infinity,
            height: double.infinity,
            borderRadius: BorderRadius.circular(6.w),
          ),
          Positioned(
            right: 3.w,
            bottom: 3.w,
            child: EasyButton(
              '广告',
              width: 28.w,
              height: 14.w,
              borderRadius: BorderRadius.circular(4.w),
              backgroundColor: Colors.black.withOpacity(0.7),
              textStyle: kTextStyle(Colors.white, fontsize: 11.w),
            ),
          )
        ],
      ),
    ).onTap(() => kAdjump(ad));
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: SizedBox(
          width: 332.w,
          child: CustomScrollView(
            slivers: [
              10.w.verticalSpaceFromWidth.sliverBox,
              _buildTitle().sliverBox,
              12.w.verticalSpaceFromWidth.sliverBox,
              // _buildTime().sliverBox,
              _serialsTitle().sliverBox,
              _buildSerialVideos().sliverBox,
              _buildAd().sliverBox,
              _buildRcTitle().sliverBox,
              10.w.verticalSpaceFromWidth.sliverBox,
              _buildVideos(),
            ],
          ),
        ),
      ),
    );
  }
}
