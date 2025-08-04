import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_kit_video/media_kit_video.dart';

import '../../../../../assets/styles.dart';
import '../../../../../components/easy_button.dart';
import '../../../../../components/generic_player/generic_player.dart';
import '../../../../../components/generic_player/generic_player_model.dart';
import '../../../../../components/generic_player/generic_player_option.dart';
import '../../../../../components/safe_state.dart';
import '../../../../../generate/app_image_path.dart';
import '../../../../../model/community/community_model.dart';
import '../../../../../utils/ad_jump.dart';
import '../../../../../utils/color.dart';
import '../../../../../utils/extension.dart';
import '../community_carouse_silder.dart';
import 'community_detail_operation_row.dart';
import 'community_detail_video_app_bar.dart';
import 'community_video_pause_button.dart';

// 广告有两种模式
// 视频和图文
class CommunityDetailAdModeCell extends StatefulWidget {
  final CommunityModel model;
  final GenericPlayerController? playerController;
  final bool autoPlay;
  const CommunityDetailAdModeCell(this.model,
      {super.key, this.playerController, this.autoPlay = true});

  @override
  State<CommunityDetailAdModeCell> createState() => _State();
}

class _State extends SafeState<CommunityDetailAdModeCell> {
  CommunityModel get model => widget.model;

  GenericPlayerModel get playerModel => GenericPlayerModel(
        coverImg: widget.model.video!.coverImg,
        playUrl: widget.model.video!.authPlayUrl,
      );

  Widget _buildDownloadButton() => EasyButton(
        '点击下载',
        textStyle: TextStyle(
          color: COLOR.white,
          fontSize: 13.w,
          fontWeight: FontWeight.w500,
        ),
        backgroundColor: COLOR.color_FB2D45,
        borderRadius: Styles.borderRadius.all(29.w),
        width: 216.w,
        height: 36.w,
        onTap: () {
          // kAdjump(model.jumpUrl, 0);
          jumpExternalURL(model.jumpUrl);
        },
      );

  Widget _buildBottomBar() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            AppImagePath.community_detail_ad_label,
            width: 40.w,
            height: 24.w,
          ),
          3.5.verticalSpaceFromWidth,
          Text(
            model.title,
            style: TextStyle(
              color: COLOR.white,
              fontSize: 13.w,
              fontWeight: FontWeight.w500,
            ),
          ),
          6.verticalSpaceFromWidth,
          _buildDownloadButton(),
        ],
      ).baseMarginHorizontal;

  Widget _buildUILayer() => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CommunityDetailVideoAppBar().baseMarginR,
          _buildBottomBar(),
        ],
      );

  Widget _buildVideoMode() => Stack(
        children: [
          GenericPlayer(
            playerModel,
            option: GenericPlayerOption(
              width: 1.sw,
              autoPlay: widget.autoPlay,
              controller: widget.playerController,
              controlsThemeNormal: GeneriVideoControlsNormalThemeData(
                pause: const CommunityVideoPauseButton(),
                displaySeekBar: true,
                visibleOnMount: true,
                bottomButtonBar: [
                  const Expanded(child: MaterialSeekBar()),
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: _buildUILayer().marginBottom(25.w),
          ),
        ],
      );

  Widget _buildImageMode() => Stack(
        children: [
          Container(
            color: COLOR.black,
            alignment: Alignment.center,
            child: CommunityCarouseSlider(model.images),
          ),
          Positioned.fill(
            child: _buildUILayer().marginBottom(25.w),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: model.isVideoAd ? _buildVideoMode() : _buildImageMode(),
        ),
        CommunityDetailOperationRow.black(model)
      ],
    );
  }
}
