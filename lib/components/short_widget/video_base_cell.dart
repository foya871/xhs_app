import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/components/keyword_color/keyword_color.dart';

import '../../assets/styles.dart';
import '../../generate/app_image_path.dart';
import '../../model/axis_cover.dart';
import '../../model/video_base_model.dart';
import '../../routes/routes.dart';
import '../../utils/color.dart';
import '../../utils/extension.dart';
import '../image_view.dart';
import 'video_official_recommend_cell.dart';
import 'video_rank_cell.dart';

class VideoBaseCell extends StatelessWidget {
  static final smallWidth = 162.w;
  static final smallImageHeight = 104.w;
  static final smallVerticalWidth = 119.w;
  static final smallVerticalImageHeight = 162.w;
  static final bigVerticalWidth = 162.w;
  static final bigVerticalImageHeight = 248.w;
  static const bigWidth = double.infinity;
  static final bigImageHeight = 209.w;

  final VideoBaseModel _video;
  final double? titleFontSize;
  final int titleMaxLines;
  final BorderRadius? borderRadius;
  final double imageHeight;
  final double? width;
  final bool showTopLeftBanner; // 是否显示左上
  final bool showTopRightBanner; // 是否显示右上
  final CoverImgAxis coverAxis;
  final double shadowRowHeight; // 次数和时长的高度
  final VoidCallback? onTap;
  final bool showShare; // title行的分享按钮
  final String? keyWord;

  // rank
  final int? rank;

  //横版 一行两个，图片高度104，宽度162
  VideoBaseCell.small({
    super.key,
    required VideoBaseModel video,
    this.showTopLeftBanner = true,
    this.showTopRightBanner = true,
    this.rank,
    this.onTap,
    this.keyWord = '',
  })  : _video = video,
        titleFontSize = 14.w,
        titleMaxLines = 1,
        borderRadius = Styles.borderRaidus.m,
        imageHeight = smallImageHeight,
        width = smallWidth,
        coverAxis = CoverImgAxis.horizontal,
        shadowRowHeight = 20.w,
        showShare = false;

  //竖版(小) 一行三个，图片高度162， 宽度119
  VideoBaseCell.smallVertical({
    super.key,
    required VideoBaseModel video,
    this.showTopLeftBanner = true,
    this.showTopRightBanner = true,
    this.rank,
    this.onTap,
    this.keyWord,
  })  : _video = video,
        titleFontSize = 14.w,
        borderRadius = Styles.borderRaidus.m,
        titleMaxLines = 1,
        imageHeight = smallVerticalImageHeight,
        width = smallVerticalWidth,
        coverAxis = CoverImgAxis.vertical,
        shadowRowHeight = 20.w,
        showShare = false;

  //竖版(大) 一行两个，图片高度248，宽度182
  VideoBaseCell.bigVertical({
    super.key,
    required VideoBaseModel video,
    this.showTopLeftBanner = true,
    this.showTopRightBanner = true,
    this.rank,
    this.onTap,
    this.keyWord = '',
  })  : _video = video,
        titleFontSize = 14.w,
        borderRadius = Styles.borderRaidus.m,
        titleMaxLines = 1,
        imageHeight = bigVerticalImageHeight,
        width = bigVerticalWidth,
        coverAxis = CoverImgAxis.vertical,
        shadowRowHeight = 20.w,
        showShare = false;

  // 图片高度180 圆角，不显示操作行
  VideoBaseCell.big(
      {super.key,
      required VideoBaseModel video,
      this.showTopLeftBanner = true,
      this.showTopRightBanner = true,
      this.rank,
      this.onTap,
      this.showShare = false,
      this.keyWord = ''})
      : _video = video,
        titleFontSize = 14.w,
        titleMaxLines = 1,
        borderRadius = Styles.borderRaidus.m,
        imageHeight = bigImageHeight,
        width = bigWidth,
        coverAxis = CoverImgAxis.horizontal,
        shadowRowHeight = 26.w;

  // Widget _buildVideoType() => VideoTypeBanner(
  //       videoType: _video.videoType!,
  //       price: _video.price,
  //     );

  Widget _buildTopLeft() {
    if (rank != null) {
      return VideoRankCell(rank!);
    }
    return const SizedBox.shrink();
  }

  Widget _buildTopRight() {
    if (_video.officialRecommend == true) {
      return const VideoOfficialRecommendCell();
    }
    return const SizedBox.shrink();
  }

  // Widget _buildPlayCount() =>
  //     VideoPlayCountCell(playCount: _video.fakeWatchNum ?? 0);

  // Widget _buildDuration() => VideoDurationCell(playTime: _video.playTime);

  Widget _buildCover() => ImageView(
        src: _video.coverByAxis(coverAxis),
        width: double.infinity,
        height: imageHeight,
        fit: BoxFit.cover,
        borderRadius: borderRadius,
        axis: coverAxis,
      );

  Widget _buildShare() => Container(
        decoration: BoxDecoration(
          borderRadius: Styles.borderRadius.all(4.w),
          color: COLOR.color_393939,
        ),
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.w),
        child: Row(
          children: [
            Image.asset(
              AppImagePath.shi_pin_green_share,
              width: 13.w,
              height: 10.w,
            ),
            3.horizontalSpace,
            Text('无限看', style: TextStyle(fontSize: 10.w)),
          ],
        ),
      ).onTap(() => Get.toShare());

  Widget _buildTitle() {
    final title = SizedBox(
      width: width,
      // height: titleHeight,
      child: keyWord != null
          ? KeywordColor(
              title: _video.title ?? '',
              keyWord: keyWord,
              style: TextStyle(
                fontSize: Styles.fontSize.s,
                color: Colors.black,
              ),
              kstyle: TextStyle(
                color: COLOR.hexColor('#B940FF'),
                fontSize: Styles.fontSize.s,
              ),
            )
          : Text(
              _video.title ?? '',
              maxLines: titleMaxLines,
              style: TextStyle(
                fontSize: titleFontSize,
                overflow: TextOverflow.ellipsis,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
    );
    return Row(
      children: [
        Expanded(child: title),
        if (showShare) ...[
          10.horizontalSpace,
          _buildShare(),
        ]
      ],
    );
  }

  // Widget _buildShadowRow() {
  //   return Container(
  //     height: shadowRowHeight,
  //     padding: EdgeInsets.symmetric(horizontal: 6.w),
  //     width: double.infinity,
  //     clipBehavior: Clip.hardEdge,
  //     decoration: BoxDecoration(
  //         image: Styles.gradient.gradientImage,
  //         borderRadius: Styles.borderRadius.mBottomLR),
  //     child: Center(
  //       child: Row(
  //         mainAxisSize: MainAxisSize.max,
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: [
  //           _buildPlayCount(),
  //           _buildDuration(),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildForgeroundLayer() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // 左上
            showTopLeftBanner ? _buildTopLeft() : const SizedBox.shrink(),
            // 右上
            showTopRightBanner ? _buildTopRight() : const SizedBox.shrink(),
          ],
        ),
        // _buildShadowRow(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> stack = [];
    stack.add(_buildCover());
    stack.add(Positioned.fill(child: _buildForgeroundLayer()));

    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(children: stack).onTap(
            onTap ?? () => Get.toPlayVideo(videoId: _video.videoId!),
          ),
          SizedBox(height: 6.w),
          _buildTitle(),
        ],
      ),
    );
  }
}
