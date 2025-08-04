/*
 * @Author: ziqi jhzq12345678
 * @Date: 2025-01-23 17:46:00
 * @LastEditors: ziqi jhzq12345678
 * @LastEditTime: 2025-01-24 19:17:16
 * @FilePath: /xhs_app/lib/views/shi_pin/common/shi_pin_tab/shi_pin_tab_videos_widget.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../components/ad_banner/ad_banner.dart';
import '../../../../components/base_refresh/base_refresh_share_tab_widget.dart';
import '../../../../components/grid_view/heighted_grid_view.dart';
import '../../../../model/video_base_model.dart';
import '../../../../utils/extension.dart';
import '../base/shi_pin_choice_cell.dart';
import '../base/shi_pin_sort_tab_bar.dart';
import '../base/shi_pin_utils.dart';
import 'shi_pin_tab_base_widget.dart';
import 'shi_pin_tab_videos_controller.dart';

class ShiPinTabVideosWidget extends ShiPinTabBaseWidget {
  const ShiPinTabVideosWidget({super.key, required super.controllerTag});

  Widget _buildSliverChoices(ShiPinTabVideosController _) {
    return Obx(
      () => HeightedGridView.sliver(
        crossAxisCount: 4,
        itemCount: _.choices.length,
        itemBuilder: (ctx, i) => ShiPinChoiceCell(_.choices[i]),
        rowMainAxisAlignment: MainAxisAlignment.start,
        columnSpacing: 8.w,
        rowSepratorBuilder: (context, index) {
          return SizedBox(height: 8.w);
        },
        noData: false,
      ),
    );
  }

  Widget _buildSliverVideos(ShiPinTabVideosController _) {
    return Obx(() {
      final models = _.getCurrentData<VideoBaseModel>();
      final dataInited = _.currentDataInited;
      return ShiPinUtils.buildSilverLayoutVideos(
        models,
        layout: _.layout.value,
        dataInited: dataInited,
      );
    });
  }

  Widget _buildBody(ShiPinTabVideosController _) {
    return BaseRefreshShareTabWidget(
      _,
      child: CustomScrollView(
        slivers: [
          const AdBanner.index().baseMarginHorizontal.sliver,
          14.verticalSpaceFromWidth.sliver,
          _buildSliverChoices(_).sliverPaddingHorizontal(14.w),
          14.verticalSpaceFromWidth.sliver,
          ShiPinSortTabBar(controller: _, tabController: _.tabContorller)
              .sliver,
          14.verticalSpaceFromWidth.sliver,
          _buildSliverVideos(_).sliverPaddingHorizontal(14.w),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _ = Get.find<ShiPinTabVideosController>(tag: controllerTag);
    return _buildBody(_);
  }
}
