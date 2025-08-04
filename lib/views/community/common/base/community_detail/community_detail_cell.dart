import 'package:flutter/material.dart';

import '../../../../../model/community/community_model.dart';
import '../../../../../utils/color.dart';
import '../../../../../utils/enum.dart';
import 'community_detail_ad_mode_cell.dart';
import 'community_detail_text_picture_mode_cell.dart';

class CommunityDetailCell extends StatelessWidget {
  final CommunityModel model;
  final VoidCallback? onBuySuccess;
  const CommunityDetailCell(
    this.model, {
    super.key,
    this.onBuySuccess,
  });

  Widget _buildBody() => switch (model.dynamicType) {
        CommunityTypeEnum.text ||
        CommunityTypeEnum.picture =>
          CommunityDetailTextPictureModeCell(model, onBuySuccess: onBuySuccess),
        // CommunityTypeEnum.video => CommunityDetailVideoModeCell(model),
        CommunityTypeEnum.ad => CommunityDetailAdModeCell(model),
        _ => const SizedBox.shrink(),
      };

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: model.hasVideo ? COLOR.black : COLOR.white,
        body: SafeArea(top: false, child: _buildBody()),
      );
}
