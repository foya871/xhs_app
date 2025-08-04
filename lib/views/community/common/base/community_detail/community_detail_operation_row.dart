import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../assets/styles.dart';
import '../../../../../components/easy_button.dart';
import '../../../../../components/safe_state.dart';
import '../../../../../generate/app_image_path.dart';
import '../../../../../http/api/api.dart';
import '../../../../../model/community/community_model.dart';
import '../../../../../utils/color.dart';
import '../../../../../utils/extension.dart';
import '../../../../../utils/utils.dart';
import '../../popup/community_comment_bottom_sheet.dart';

enum _Mode { black, white }

// 操作栏
class CommunityDetailOperationRow extends StatefulWidget {
  final CommunityModel model;
  final _Mode _mode;
  final VoidCallback? onTapComment;
  final VoidCallback? onTapInput;
  const CommunityDetailOperationRow.black(this.model,
      {super.key, this.onTapComment, this.onTapInput})
      : _mode = _Mode.black;
  const CommunityDetailOperationRow.white(this.model,
      {super.key, this.onTapComment, this.onTapInput})
      : _mode = _Mode.white;
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends SafeState<CommunityDetailOperationRow> {
  CommunityModel get model => widget.model;

  bool get isBlack => widget._mode == _Mode.black;

  void _onTapLike() async {
    final ok = await Api.toggleCommunityLike(
      model.dynamicId,
      isLike: model.isLike,
    );
    if (!ok) return;
    setState(() {
      model.onToggleLikeSuccess(fire: true);
    });
  }

  void _onTapFav() async {
    final ok = await Api.toggleCommunityFavorite(
      model.dynamicId,
      isFavorite: model.isFavorite,
    );
    if (!ok) return;
    setState(() {
      model.onToggleFavoriteSuccess(fire: true);
    });
  }

  void _onTapComment() => widget.onTapComment == null
      ? CommunityCommentBottomSheet.detail(model).show()
      : widget.onTapComment!();

  Widget _buildLeft() => Container(
        width: 120.w,
        height: 36.w,
        decoration: BoxDecoration(
          color: isBlack ? COLOR.color_191919 : COLOR.black.withOpacity(0.11),
          borderRadius: Styles.borderRadius.all(20.w),
        ),
        padding: EdgeInsets.only(left: 13.w),
        alignment: Alignment.centerLeft,
        child: Text(
          '说点什么...',
          style: TextStyle(color: COLOR.color_999999, fontSize: 13.w),
        ),
      ).onOpaqueTap(widget.onTapInput ?? _onTapComment);

  Widget _buildOperation(String asset, int count, VoidCallback onTap) => Row(
        children: [
          EasyButton.child(
            Image.asset(asset),
            width: 22.w,
            height: 20.w,
            onTap: onTap,
          ),
          4.horizontalSpace,
          Text(
            Utils.numFmt(count),
            style: TextStyle(
                color: isBlack ? COLOR.white : COLOR.color_333333,
                fontSize: 13.w),
          )
        ],
      );

  Widget _buildRight() => Row(
        children: [
          _buildOperation(
            model.isLike
                ? AppImagePath.community_discover_like_y
                : isBlack
                    ? AppImagePath.community_discover_like_white
                    : AppImagePath.community_discover_like,
            model.fakeLikes,
            _onTapLike,
          ),
          _buildOperation(
            model.isFavorite
                ? AppImagePath.community_discover_fav_y
                : isBlack
                    ? AppImagePath.community_discover_fav_white
                    : AppImagePath.community_discover_fav,
            model.fakeFavorites,
            _onTapFav,
          ),
          _buildOperation(
            isBlack
                ? AppImagePath.community_discover_comment_white
                : AppImagePath.community_discover_comment,
            model.commentNum,
            _onTapComment,
          ),
        ].joinWidth(20.w),
      );

  @override
  Widget build(BuildContext context) => Container(
        color: widget._mode == _Mode.black ? COLOR.black : COLOR.white,
        height: 50.w,
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildLeft(),
            _buildRight(),
          ],
        ),
      );
}
