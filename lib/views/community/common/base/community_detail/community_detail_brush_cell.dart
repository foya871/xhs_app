import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../components/base_page/base_error_widget.dart';
import '../../../../../components/base_page/base_loading_widget.dart';
import '../../../../../utils/color.dart';
import '../../../../../utils/enum.dart';
import 'community_detail_ad_mode_cell.dart';
import 'community_detail_brush_cell_controller.dart';
import 'community_detail_text_picture_mode_cell.dart';
import 'community_detail_video_mode_cell.dart';

class CommunityBrushDetailCell extends StatelessWidget {
  final CommunityBrushDetailCellController controller;
  const CommunityBrushDetailCell({required this.controller, super.key});

  Widget _buildBody() => switch (controller.model.base.dynamicType) {
        CommunityTypeEnum.text ||
        CommunityTypeEnum.picture =>
          CommunityDetailTextPictureModeCell(controller.model.detail!),
        CommunityTypeEnum.video => CommunityDetailVideoModeCell(
            controller.model.detail!,
            playerController: controller.playerController,
            doRefresh: () => controller.waitLoadingDetail(forceRetry: true),
          ),
        CommunityTypeEnum.ad => CommunityDetailAdModeCell(
            controller.model.detail!,
            playerController: controller.playerController,
          ),
        _ => const SizedBox.shrink(),
      };

  @override
  Widget build(BuildContext context) => controller.obx(
        (_) => Scaffold(
          backgroundColor:
              controller.model.detail!.hasVideo ? COLOR.black : COLOR.white,
          body: SafeArea(top: false, child: _buildBody()),
        ),
        onLoading: const BaseLoadingWidget(),
        onError: (_) => BaseErrorWidget(
          onTap: () => controller.waitLoadingDetail(forceRetry: true),
        ),
      );
}
