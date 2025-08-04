import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:media_kit_video/media_kit_video.dart';

import '../../../../../assets/styles.dart';
import '../../../../../components/circle_image.dart';
import '../../../../../components/easy_button.dart';
import '../../../../../components/expandable/easy_expandable_text.dart';
import '../../../../../components/generic_player/generic_player.dart';
import '../../../../../components/generic_player/generic_player_model.dart';
import '../../../../../components/generic_player/generic_player_option.dart';
import '../../../../../components/safe_state.dart';
import '../../../../../generate/app_image_path.dart';
import '../../../../../http/api/api.dart';
import '../../../../../model/community/community_model.dart';
import '../../../../../routes/routes.dart';
import '../../../../../utils/color.dart';
import '../../../../../utils/enum.dart';
import '../../../../../utils/extension.dart';
import '../../../../player/views/av_player_loading.dart';
import '../../popup/community_collection_tile_bottom_sheet.dart';
import '../../popup/community_reason_type_dialog.dart';
import '../community_utils.dart';
import 'community_detail_buy_tips.dart';
import 'community_detail_free_watch.dart';
import 'community_detail_operation_row.dart';
import 'community_detail_video_app_bar.dart';
import 'community_video_pause_button.dart';

class CommunityDetailVideoModeCell extends StatefulWidget {
  final CommunityModel model;
  final bool autoPlay;
  final GenericPlayerController? playerController;
  final VoidCallback? doRefresh;
  const CommunityDetailVideoModeCell(
    this.model, {
    super.key,
    this.autoPlay = true,
    this.playerController,
    this.doRefresh,
  });
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends SafeState<CommunityDetailVideoModeCell> {
  CommunityModel get model => widget.model;
  bool _clearMode = false;

  GenericPlayerModel get playerModel => GenericPlayerModel(
        coverImg: widget.model.video!.coverImg,
        playUrl: widget.model.video!.authPlayUrl,
      );

  void _onTapAttention() async {
    final ok = await Api.toggleAttentionUser(
      model.userId,
      attention: model.isAttention,
    );
    if (!ok) return;
    setState(() {
      model.onToggleAttentionSuccess();
    });
  }

  void _onTapGoldBuy() => CommunityUtils.tryGoldBuy(
        model.dynamicId,
        price: model.price,
        onBuySuccess: () => widget.doRefresh?.call(),
      );

  void _onTapBuyVip() => Get.toVip();

  void _onTapJoinFans() => Get.toBloggerPrivateGroup(userId: model.userId);

  void _onPlayerCompleted(bool completed) {
    if (!completed) return;
    if (model.canWatch) return;
    CommunityReasonTypeDialog(
      model.reasonType,
      userId: model.userId,
    ).showUnique();
  }

  Widget _buildProfileRow() => Row(
        children: [
          CircleImage.network(
            model.logo,
            size: 32.w,
            onTap: () => Get.toBloggerDetail(userId: model.userId),
          ),
          9.horizontalSpace,
          Flexible(
            child: Text(
              model.nickName,
              style: TextStyle(
                color: COLOR.white,
                fontSize: 13.w,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          5.horizontalSpace,
          EasyButton(
            model.isAttention ? '已关注' : '关注',
            width: 46.w,
            height: 22.w,
            textStyle: TextStyle(
              color: model.isAttention ? null : COLOR.white,
              fontSize: 12.w,
            ),
            backgroundColor:
                model.isAttention ? COLOR.white : COLOR.color_FB2D45,
            borderRadius: Styles.borderRadius.all(23.w),
            onTap: _onTapAttention,
          )
        ],
      );

  Widget _buildTitle() => EasyExpandableText(
        model.contentText.isEmpty
            ? model.title
            : '${model.title}\n${model.contentText}',
        // List.generate(100, (i) => model.title).join(" "),
        style: TextStyle(
          color: COLOR.white,
          fontSize: 13.w,
          fontWeight: FontWeight.w500,
        ),
        maxLines: 2,
        toggleTextStyle: TextStyle(
          color: COLOR.white.withOpacity(0.6),
          fontSize: 13.w,
          fontWeight: FontWeight.w500,
        ),
        collapseInNewLine: true,
        maxHeight: 0.5.sh,
        tagLines: [
          EasyExpandableTextTagLine(
            model.topic
                .map(
                  (e) => EasyExpandableTextTag(
                    '#$e',
                    onTap: () => Get.toCommunityTopic(e),
                  ),
                )
                .toList(),
            style: TextStyle(
              color: COLOR.color_7EA4D7,
              fontSize: 13.w,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      );

  Widget _buildBuyTips() {
    if (model.canWatch) {
      if (model.dynamicMark == CommunityMarkTypeEnum.free) {
        return const CommunityDetailFreeWatch();
      }
    } else {
      return switch (model.reasonType) {
        CommunityReasonTypeEnum.noCount ||
        CommunityReasonTypeEnum.needBuy =>
          CommunityDetailBuyTips.gold(model.price, onTap: _onTapGoldBuy),
        CommunityReasonTypeEnum.needVip =>
          CommunityDetailBuyTips.vip(onTap: _onTapBuyVip),
        CommunityReasonTypeEnum.needFans =>
          CommunityDetailBuyTips.needFans(onTap: _onTapJoinFans),
        _ => const SizedBox.shrink()
      };
    }
    return const SizedBox.shrink();
  }

  Widget _buildCollection() => SizedBox(
        height: 34.w,
        child: Row(
          children: [
            Image.asset(
              AppImagePath.community_detail_icon_collection,
              width: 20.w,
              height: 20.w,
            ),
            10.horizontalSpace,
            Expanded(
              child: Text(
                '合集:${model.collectionName}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: COLOR.white,
                  fontSize: 13.w,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Image.asset(
              AppImagePath.icons_right_arrow_white,
              width: 6.w,
              height: 11.w,
            )
          ],
        ),
      ).onOpaqueTap(() {
        CommunityCollectionTileBottomSheet(
          model.collectionName,
          userId: model.userId,
        ).show();
      });

  Widget _buildUILayer() => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const CommunityDetailVideoAppBar().baseMarginR,
          _buildBottomBar(),
        ],
      );

  Widget _buildBottomBar() => Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        child: _clearMode
            ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [_buildClearScreenButton()],
              )
            : Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildProfileRow(),
                            _buildTitle(),
                            IntrinsicWidth(child: _buildBuyTips()),
                          ].joinHeight(6.w),
                        ),
                      ),
                      24.horizontalSpace,
                      _buildClearScreenButton(),
                    ],
                  ),
                  if (model.collectionName.isNotEmpty) ...[
                    6.verticalSpaceFromWidth,
                    _buildCollection(),
                  ]
                ],
              ),
      );

  Widget _buildClearScreenButton() => Center(
        child: Image.asset(
          _clearMode
              ? AppImagePath.community_detail_clear_screen_y
              : AppImagePath.community_detail_clear_screen,
          width: 26.w,
          height: 26.w,
        ).onTap(() {
          setState(() {
            _clearMode = !_clearMode;
          });
        }),
      );

  Widget _buildVideo() {
    return Stack(
      children: [
        GenericPlayer(
          playerModel,
          option: GenericPlayerOption(
            width: 1.sw,
            autoPlay: widget.autoPlay,
            controller: widget.playerController,
            // onCompleted: _onPlayerCompleted,
            controlsThemeNormal: GeneriVideoControlsNormalThemeData(
              pause: const CommunityVideoPauseButton(),
              displaySeekBar: true,
              visibleOnMount: true,
              bufferingIndicatorBuilder: (_) => const AvPlayerLoading(),
              seekBarAlignment: Alignment.center,
              bottomButtonBar: [
                const MaterialPositionIndicator(),
                10.horizontalSpace,
                const Expanded(child: MaterialSeekBar()),
              ],
            ),
          ),
        ),
        Positioned.fill(child: _buildUILayer().marginBottom(50.w)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(
          children: [
            Expanded(child: _buildVideo()),
            CommunityDetailOperationRow.black(model),
          ],
        ),
      );
}
