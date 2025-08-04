import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../assets/styles.dart';
import '../../../../components/image_view.dart';
import '../../../../generate/app_image_path.dart';
import '../../../../model/community/community_base_model.dart';
import '../../../../utils/color.dart';
import '../../../../utils/extension.dart';
import '../../../../utils/utils.dart';

// 动态 一行一个，左右的那种
class CommunityBaseTileCell extends StatelessWidget {
  final CommunityBaseModel model;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  const CommunityBaseTileCell(
    this.model, {
    super.key,
    this.onTap,
    this.backgroundColor,
    this.padding,
  });

  Widget _buildCover() => Stack(
        children: [
          ImageView(
            src: model.cover,
            width: 64.w,
            height: 64.w,
            borderRadius: Styles.borderRadius.all(4.w),
          ),
          if (model.hasVideo)
            Positioned.fill(
              child: Center(
                child: Image.asset(
                  AppImagePath.community_discover_play,
                  width: 16.w,
                  height: 16.w,
                ),
              ),
            )
        ],
      );

  Widget _buildTitle() => Text(
        model.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 13.w, fontWeight: FontWeight.w500),
      );

  Widget _buildOneOperation(String asset, int count) => Row(
        children: [
          Image.asset(asset, width: 15.w, height: 15.w),
          3.horizontalSpace,
          Text(
            Utils.numFmt(count),
            style: TextStyle(color: COLOR.color_666666, fontSize: 10.w),
          )
        ],
      );

  Widget _buildOperation() => Row(
        children: [
          _buildOneOperation(
            AppImagePath.community_discover_like,
            model.fakeLikes,
          ),
          _buildOneOperation(
            AppImagePath.community_discover_fav,
            model.fakeFavorites,
          ),
          _buildOneOperation(
            AppImagePath.community_discover_comment,
            model.commentNum,
          ),
        ].joinWidth(10.w),
      );

  // Widget _buildCover() => model.cover;
  Widget _buildRight() => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(),
          _buildOperation(),
        ],
      ).marginVertical(4.w);

  @override
  Widget build(BuildContext context) => Container(
        color: backgroundColor,
        padding: padding,
        child: IntrinsicHeight(
          child: Row(
            children: [
              _buildCover(),
              7.horizontalSpace,
              Flexible(child: _buildRight()),
            ],
          ),
        ).onOpaqueTap(onTap),
      );
}
