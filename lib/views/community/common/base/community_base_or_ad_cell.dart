import 'package:flutter/widgets.dart';
import 'package:xhs_app/components/ad/ad_enum.dart';
import 'package:xhs_app/components/ad/ad_info_model.dart';
import 'package:xhs_app/components/ad_banner/insert_ad.dart';
import 'package:xhs_app/model/community/community_base_model.dart';
import 'package:xhs_app/views/community/common/base/community_base_cell.dart';

class CommunityBaseOrAdCell extends StatelessWidget {
  final CommunityBaseOrAdPlaceHolderModel model;
  const CommunityBaseOrAdCell(this.model, {super.key});
  @override
  Widget build(BuildContext context) {
    if (model is CommunityBaseModel) {
      return CommunityBaseCell(model);
    } else if (model is AdApiType) {
      return InsertAd.fromPlaceholder(model, height: null);
    } else {
      assert(false, 'CommunityBaseOrAdCell未知类型 ${model.runtimeType}');
      return const SizedBox.shrink();
    }
  }
}
