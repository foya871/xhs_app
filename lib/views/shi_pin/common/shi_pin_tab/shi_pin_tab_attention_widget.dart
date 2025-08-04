import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../components/ad_banner/ad_banner.dart';
import '../../../../components/base_refresh/base_refresh_simple_widget.dart';
import '../../../../components/no_more/no_data_candom.dart';
import '../../../../model/video_base_model.dart';
import '../../../../utils/color.dart';
import '../../../../utils/extension.dart';
import '../base/shi_pin_recommend_user_cell.dart';
import '../base/shi_pin_sort_tab_bar.dart';
import '../base/shi_pin_utils.dart';
import 'shi_pin_tab_attention_controller.dart';
import 'shi_pin_tab_base_widget.dart';

class ShiPinTabAttentionWidget extends ShiPinTabBaseWidget {
  const ShiPinTabAttentionWidget({super.key, required super.controllerTag});

  List<Widget> _buildVideoModeSilvers(ShiPinTabAttentionController _) {
    return [
      const AdBanner.index().baseMarginHorizontal.sliver,
      ShiPinSortTabBar(
        controller: _,
        tabController: _.tabController,
      ).sliver,
      14.verticalSpaceFromWidth.sliver,
      Obx(() {
        final data = _.data.map((e) => e as VideoBaseModel).toList();
        return ShiPinUtils.buildSilverLayoutVideos(
          data,
          layout: _.layout.value,
          dataInited: _.dataInited,
        ).sliverPaddingHorizontal(14.w);
      })
    ];
  }

  Widget _buildRecommendMode(ShiPinTabAttentionController _) {
    return Column(
      children: [
        17.verticalSpaceFromWidth,
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            '热门推荐',
            style: TextStyle(color: COLOR.color_DDDDDD, fontSize: 12.w),
          ),
        ),
        10.verticalSpaceFromWidth,
        EasyRefresh(
          footer: const ClassicFooter(
            noMoreIcon: SizedBox.shrink(),
            showText: false,
            showMessage: false,
            iconTheme: IconThemeData(color: COLOR.white),
          ),
          onLoad: _.onLoad,
          child: Obx(() {
            final data = _.data;
            return SizedBox(
              height: ShiPinRecommendUserCell.height,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, i) => ShiPinRecommendUserCell(data[i]),
                separatorBuilder: (ctx, i) => 20.horizontalSpace,
                itemCount: data.length,
              ),
            );
          }),
        ),
        60.verticalSpaceFromWidth,
        const NoDataCandom(),
      ],
    );
  }

  Widget _buildBody(ShiPinTabAttentionController _, ScrollPhysics physics) {
    return CustomScrollView(
      physics: physics,
      slivers: switch (_.mode.value) {
        ShiPinTabAttentionMode.video => _buildVideoModeSilvers(_),
        ShiPinTabAttentionMode.recommend => [
            _buildRecommendMode(_).baseMarginL.sliver
          ],
        ShiPinTabAttentionMode.none => [const SizedBox.shrink().sliver]
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final _ = Get.find<ShiPinTabAttentionController>(tag: controllerTag);
    return Obx(
      () => BaseRefreshSimpleWidget.builder(
        _,
        enableLoad: _.mode.value == ShiPinTabAttentionMode.video,
        childBuilder: (ctx, physics) => _buildBody(_, physics),
      ),
    );
  }
}
