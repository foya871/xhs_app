import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../assets/styles.dart';
import '../../../../components/circle_image.dart';
import '../../../../components/easy_button.dart';
import '../../../../components/image_view.dart';
import '../../../../components/safe_state.dart';
import '../../../../components/short_widget/video_duration_cell.dart';
import '../../../../event_bus/event_bus.dart';
import '../../../../event_bus/events/dynamic_event.dart';
import '../../../../generate/app_image_path.dart';
import '../../../../http/api/api.dart';
import '../../../../model/community/community_base_model.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/color.dart';
import '../../../../utils/enum.dart';
import '../../../../utils/extension.dart';
import '../../../../utils/utils.dart';
import '../popup/community_complaint_and_unattention_bottom_sheet.dart';
import '../popup/community_content_and_comment_bottom_sheet.dart';
import 'community_carouse_silder.dart';

// 动态 大竖版，一行一个
class CommunityBigVerticalCell extends StatelessWidget {
  final CommunityBaseModel model;

  const CommunityBigVerticalCell(this.model, {super.key});

  Widget _buildProfile() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleImage.network(model.logo, size: 32.w),
              9.horizontalSpace,
              Text(model.nickName, style: TextStyle(fontSize: 13.w)),
              4.horizontalSpace,
              const Text('·', style: TextStyle(color: COLOR.color_979797)),
              5.horizontalSpace,
              Text(
                Utils.dateFmt(model.checkAt, ['mm', '-', 'dd']),
                style: TextStyle(color: COLOR.color_999999, fontSize: 11.w),
              ),
              8.horizontalSpace,
              ImageView(
                src: VipTypeEnum.badge(model.vipType),
                shrinkIfSrcEmpty: true,
                width: 40.w,
                height: 16.w,
                fit: BoxFit.fitWidth,
              )
            ],
          ).onOpaqueTap(() => Get.toBloggerDetail(userId: model.userId)),
          Image.asset(
            AppImagePath.community_attention_dot_more,
            width: 20.2.w,
            height: 3.6.w,
          ).onTap(
            () => CommunityComplaintAndUnattentionBottomSheet(model).show(),
          ),
        ],
      );

  Widget _buildImages() {
    if (model.isVideo) {
      final videoCoverImg = model.video?.coverImg;
      return Stack(
        children: [
          ImageView(src: videoCoverImg ?? ''),
          Positioned(
            top: 16.w,
            right: 10.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.w),
              decoration: BoxDecoration(
                  color: COLOR.black.withOpacity(0.5),
                  borderRadius: Styles.borderRadius.all(12.w)),
              child: VideoDurationCell(playTime: model.video?.playTime),
            ),
          )
        ],
      );
    }
    if (model.images.isNotEmpty) {
      return CommunityCarouseSlider(model.images);
    }
    return const SizedBox.shrink();
  }

  Widget _buildTitle() => Row(
        children: [
          Expanded(
            child: Text(
              model.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 13.w),
            ),
          ),
          6.horizontalSpace,
          Text(
            '查看全文',
            style: TextStyle(fontSize: 13.w, fontWeight: FontWeight.w500),
          )
        ],
      );

  @override
  Widget build(BuildContext context) => Container(
        color: COLOR.white,
        child: Column(
          children: [
            11.verticalSpaceFromWidth,
            _buildProfile().baseMarginHorizontal,
            9.verticalSpaceFromWidth,
            _buildImages(),
            13.verticalSpaceFromWidth,
            _OperationRow(model).baseMarginHorizontal,
            13.verticalSpaceFromWidth,
            _buildTitle().baseMarginHorizontal,
            14.verticalSpaceFromWidth,
          ],
        ).onTap(() => Get.toCommunityDetail(model)),
      );
}

class _OperationRow extends StatefulWidget {
  final CommunityBaseModel model;

  const _OperationRow(this.model);
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends SafeState<_OperationRow> {
  CommunityBaseModel get model => widget.model;
  final numStyle = TextStyle(fontSize: 13.w);

  @override
  void initState() {
    super.initState();
    EventBusInst.listen<DynamicChangeEvent>(
      (e) => setState(() => model.onChangeEvent(e)),
      test: (e) => e.id == model.dynamicId,
    );
  }

  Future<void> _onTapLike() async {
    final ok =
        await Api.toggleCommunityLike(model.dynamicId, isLike: model.isLike);
    if (!ok) return;
    setState(() {
      model.onToggleLikeSuccess();
    });
  }

  Future<void> _onTapFav() async {
    final ok = await Api.toggleCommunityFavorite(
      model.dynamicId,
      isFavorite: model.isFavorite,
    );
    if (!ok) return;
    setState(() {
      model.onToggleFavoriteSuccess();
    });
  }

  Widget _buildShare() => Image.asset(
        AppImagePath.community_attention_share_black,
        width: 22.w,
        height: 22.w,
      ).onTap(() => Get.toShare());

  Widget _buildLike() => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          EasyButton.child(
            Image.asset(
              model.isLike
                  ? AppImagePath.community_discover_like_y
                  : AppImagePath.community_discover_like,
            ),
            width: 22.w,
            height: 22.w,
            loadingSize: 10.w,
            onTap: _onTapLike,
          ),
          4.horizontalSpace,
          Text(Utils.numFmt(model.fakeLikes), style: numStyle)
        ],
      );

  Widget _buildFav() => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          EasyButton.child(
            Image.asset(
              model.isFavorite
                  ? AppImagePath.community_discover_fav_y
                  : AppImagePath.community_discover_fav,
            ),
            width: 22.w,
            height: 22.w,
            loadingSize: 10.w,
            onTap: _onTapFav,
          ),
          4.horizontalSpace,
          Text(Utils.numFmt(model.fakeFavorites), style: numStyle)
        ],
      );

  Widget _buildComment() => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            AppImagePath.community_discover_comment,
            width: 22.w,
            height: 22.w,
          ),
          4.horizontalSpace,
          Text(Utils.numFmt(model.commentNum), style: numStyle)
        ],
      ).onOpaqueTap(() {
        CommunityContentAndCommentBottomSheet(model).show();
      });

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildShare(),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildLike(),
              _buildFav(),
              _buildComment(),
            ].joinWidth(20.w),
          )
        ],
      );
}
