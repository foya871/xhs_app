import 'package:xhs_app/assets/styles.dart';
import 'package:xhs_app/components/image_view.dart';
import 'package:xhs_app/components/easy_button.dart';
import 'package:xhs_app/generate/app_image_path.dart';
import 'package:xhs_app/model/video_base_model.dart';
import 'package:xhs_app/utils/color.dart';
import 'package:xhs_app/utils/enum.dart';
import 'package:xhs_app/utils/extension.dart';
import 'package:xhs_app/utils/utils.dart';
import 'package:xhs_app/views/mine/favorite/controllers/favorite_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class VideoItem extends GetView<FavoritePageController> {
  final VideoBaseModel video;
  var index = 0;

  VideoItem({
    super.key,
    required this.video,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              _buildCover(),
              Positioned(top: 5.w, right: 5.w, child: _buildVipType()),
              _buildDuration(),
              _buildShadow(),
            ],
          ),
          SizedBox(width: 6.w),
          Expanded(
            child: _buildTitle(),
          ),
        ],
      );
    });
  }

  Widget _buildCover() {
    return ClipRRect(
      borderRadius: Styles.borderRaidus.xs,
      child: ImageView(
        src: video.hCover,
        width: double.maxFinite,
        height: 90.w,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildVipType() {
    String text = '';
    if (video.videoType == VideoTypeValueEnum.Pay) {
      if (video.price != null && video.price! > 0) {
        text = '${video.price}金币';
      }
    } else if (video.videoType == VideoTypeValueEnum.VIP) {
      text = 'VIP';
    }
    if (text.isEmpty) {
      return const SizedBox.shrink();
    }

    final textStyle = TextStyle(
      fontSize: Styles.fontSize.xs,
      color: COLOR.white,
    );
    return EasyButton.child(
      Text(text, style: textStyle),
      height: 16.w,
      minWidth: 32.w,
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      borderRadius: Styles.borderRaidus.xs,
      backgroundGradient: Styles.gradient.pinkToBule,
    );
  }

  Widget _buildDuration() {
    final text = Utils.secondsToTime(video.playTime);
    final textStyle = TextStyle(
      fontSize: Styles.fontSize.xs,
      color: COLOR.white,
    );
    return Positioned(
      bottom: 5.w,
      right: 5.w,
      child: EasyButton.child(
        Text(text, style: textStyle),
        height: 16.w,
        minWidth: 44.w,
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        borderRadius: Styles.borderRaidus.m,
        backgroundColor: Colors.black.withOpacity(0.4),
      ),
    );
  }

  Widget _buildShadow() {
    return Visibility(
      maintainSize: false,
      maintainAnimation: true,
      maintainState: true,
      maintainInteractivity: false,
      visible: controller.visible.value,
      child: Stack(
        children: <Widget>[
          Container(
            width: double.maxFinite,
            height: 90.w,
            decoration: BoxDecoration(
              color: COLOR.hexColor('#80000000'),
              borderRadius: Styles.borderRadius.xs,
            ),
          ),
          Positioned(
            top: 5.w,
            right: 5.w,
            child: Image.asset(
              video.isSelected!
                  ? AppImagePath.mine_icon_video_select
                  : AppImagePath.mine_icon_video_unselect,
              width: 22.w,
              height: 22.w,
            ),
          ),
        ],
      ),
    ).onOpaqueTap(() {
      controller.onSelectedItem(index);
    });
  }

  Widget _buildTitle() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.w),
      child: Text(
        video.title ?? '',
        maxLines: 1,
        style: TextStyle(
          color: COLOR.white,
          fontSize: Styles.fontSize.sm,
          overflow: TextOverflow.ellipsis,
        ).copyWith(fontSize: 13.w),
      ),
    );
  }
}
