import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/generate/app_image_path.dart';

import '../../../../components/circle_image.dart';
import '../../../../http/api/api.dart';
import '../../../../model/play/video_detail_model.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/busy_future.dart';
import '../../../../utils/extension.dart';
import '../../../../utils/utils.dart';
import '../../../player/views/comment_list.dart';

///
/// 右边操作 关注, 收藏，评论，分享, 选线, 清屏模式
///
class ShortVPOperationArea extends StatefulWidget {
  final VideoDetail detail;
  final double topHeight;
  final bool clearMode;
  final VoidCallback onTapSelectCdn;
  final VoidCallback onTapClearMode;
  // final bool Function() onTapUnmute;
  final VoidCallback onTapUnmute;
  // final bool webUnmuteTouched;
  final bool webMuted;

  const ShortVPOperationArea(
    this.detail, {
    super.key,
    required this.topHeight,
    required this.clearMode,
    required this.onTapSelectCdn,
    required this.onTapClearMode,
    required this.onTapUnmute,
    // required this.webUnmuteTouched,
    required this.webMuted,
  });

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<ShortVPOperationArea> with BusyFuture {
  VideoDetail get detail => widget.detail;

  Future<void> _onTapAttention() async {
    final old = detail.attention ?? false;
    final result = await busyCall(
      'focus',
      () => Api.focusAction(
        userId: detail.userId ?? 0,
        attention: old,
      ),
    );
    if (!result.item1) return;
    if (result.item2 == true) {
      if (!mounted) return;
      setState(() {
        detail.attention = !old;
      });
    }
  }

  Future<void> _onTapFavorite() async {
    final old = detail.favorite ?? false;
    final result = await busyCall(
      'favorite',
      () => Api.toogleVideoFavorite(
        detail.videoId ?? 0,
        favorite: old,
      ),
    );
    if (!result.item1) return;
    if (result.item2 == true) {
      if (!mounted) return;
      setState(() {
        detail.favorite = !old;
        if (detail.favorite == true) {
          detail.fakeFavorites = (detail.fakeFavorites ?? 0) + 1;
        } else {
          detail.fakeFavorites = (detail.fakeFavorites ?? 1) - 1;
        }
      });
    }
  }

  void _onTapComment() {
    Get.bottomSheet(
      Container(
        width: double.infinity,
        height: 500.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.w),
            topRight: Radius.circular(15.w),
          ),
        ),
        child: PlayCommentList(
          videoId: detail.videoId,
          type: CommentTypeEnumValue.short,
          commentCount: detail.commentNum ?? 0,
        ),
      ),
    );
  }

  Widget _buildMutedButton() {
    if (!kIsWeb) return const SizedBox.shrink();
    // if (!widget.webMuted) {
    //   return Icon(Icons.volume_off, size: 35.w, color: Colors.white)
    //       .onTap(widget.onTapUnmute);
    // } else {
    //   return const SizedBox.shrink();
    // }
    return Icon(widget.webMuted ? Icons.volume_off : Icons.volume_up,
            size: 35.w, color: Colors.white)
        .onTap(widget.onTapUnmute);
  }

  Widget _buildLogo() {
    return Visibility(
      visible: !widget.clearMode,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CircleImage.network(
            detail.logo ?? '',
            size: 46.w,
            onTap: () => Get.toBloggerDetail(userId: detail.userId ?? 0),
          ),
          if (!(detail.attention ?? false))
            Positioned(
              left: 6.w,
              bottom: -8.w,
              child: Image.asset(
                AppImagePath.short_short_focus_y,
                width: 35.w,
                height: 17.w,
              ).onTap(_onTapAttention),
            )
        ],
      ),
    );
  }

  Widget _buildBtn({
    required String name,
    required String icon,
    required VoidCallback onTap,
    required double iconW,
    bool alwaryVisiable = false,
  }) {
    bool visible = !widget.clearMode;
    if (alwaryVisiable) {
      visible = true;
    }
    return Visibility(
      visible: visible,
      child: Column(
        children: [
          Image.asset(
            icon,
            width: iconW,
            fit: BoxFit.fitWidth,
          ),
          if (name.isNotEmpty) ...[
            SizedBox(height: 2.w),
            Text(
              name,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 12.w),
            )
          ]
        ],
      ).onTap(onTap),
    );
  }

  Widget _buildFavorite() => _buildBtn(
        name: Utils.numFmtCh(detail.fakeFavorites ?? 0),
        icon: detail.favorite == true
            ? AppImagePath.short_short_like_y
            : AppImagePath.short_short_like,
        onTap: _onTapFavorite,
        iconW: 31.w,
      );

  Widget _buildComment() => _buildBtn(
        name: Utils.numFmtCh(detail.commentNum ?? 0),
        icon: AppImagePath.short_short_comment,
        onTap: _onTapComment,
        iconW: 45.w,
      );

  Widget _buildShare() => _buildBtn(
        name: '分享',
        icon: AppImagePath.short_short_share,
        onTap: () => Get.toShare(),
        iconW: 29.w,
      );

  // Widget _buildSelectLine() => _buildBtn(
  //     name: '',
  //     icon: AppImagePath.short_line,
  //     onTap: widget.onTapSelectCdn,
  //     iconW: 30.w);

  // Widget _buildClearMode() => _buildBtn(
  //       name: '',
  //       icon: widget.clearMode
  //           ? AppImagePath.short_eye_open
  //           : AppImagePath.short_eye_close,
  //       onTap: widget.onTapClearMode,
  //       alwaryVisiable: true,
  //       iconW: 29.w,
  //     );
  @override
  Widget build(BuildContext context) {
    // final hasLine = detail.cdnRes != null;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Column(children: [
          SizedBox(height: widget.topHeight),
        ]),
        Column(
          children: [
            _buildLogo(),
            SizedBox(height: 30.w),
            _buildFavorite(),
            SizedBox(height: 15.w),
            _buildComment(),
            SizedBox(height: 15.w),
            _buildShare(),
            SizedBox(height: 15.w),
            _buildMutedButton(),
            // SizedBox(height: 30.w),
            // if (hasLine) ...[
            //   _buildSelectLine(),
            //   SizedBox(height: 20.w),
            // ],
            // _buildClearMode(),
          ],
        )
      ],
    );
  }
}
