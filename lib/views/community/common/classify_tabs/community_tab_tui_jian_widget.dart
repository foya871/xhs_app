import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/components/ad/ad_enum.dart';
import 'package:xhs_app/components/ad/ad_utils.dart';

import '../../../../components/ad_banner/classify_ads.dart';
import '../../../../components/base_refresh/base_refresh_simple_widget.dart';
import '../../../../components/no_more/no_data_sliver_masonry_grid.dart';
import '../../../../utils/extension.dart';
import '../base/community_base_or_ad_cell.dart';
import 'community_tab_base_widget.dart';
import 'community_tab_tui_jian_controller.dart';

class CommunityTabTuiJianWidget extends CommunityTabBaseWidget {
  const CommunityTabTuiJianWidget({super.key, required super.controllerTag});
  Widget _buildSliverCommunity(CommunityTabTuiJianController _) => Obx(
        () {
          final data = _.data;
          final dataInited = _.dataInited;
          const place = AdApiType.TWO_COLUMN_WATERFALL_VERTICAL;
          final interval = adHelper.getInsertWeight(place);
          return NoDataSliverMasonryGrid.count(
            crossAxisCount: 2,
            itemCount: adHelper.withAdLength(data.length, interval: interval),
            itemBuilder: (ctx, i) => CommunityBaseOrAdCell(
              adHelper.modelByBuildIndex(
                i,
                models: data,
                interval: interval,
                place: place,
              ),
            ),
            crossAxisSpacing: 4.w,
            mainAxisSpacing: 4.w,
            noData: dataInited,
          ).sliverPaddingHorizontal(14.w);
        },
      );

  Widget _buildBody(CommunityTabTuiJianController _) => CustomScrollView(
        cacheExtent: 4.sh, // 减缓重绘带来的子元素左右位置改变的问题
        slivers: [
          const ClassifyAds().sliver,
          5.verticalSpaceFromWidth.sliver,
          _buildSliverCommunity(_),
        ],
      );

  @override
  Widget build(BuildContext context) {
    final _ = Get.find<CommunityTabTuiJianController>(tag: controllerTag);
    return BaseRefreshSimpleWidget(_, child: _buildBody(_));
  }
}
