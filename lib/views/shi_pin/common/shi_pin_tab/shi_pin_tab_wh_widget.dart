/*
 * @Author: ziqi jhzq12345678
 * @Date: 2025-01-17 14:12:59
 * @LastEditors: ziqi jhzq12345678
 * @LastEditTime: 2025-01-24 19:55:38
 * @FilePath: /xhs_app/lib/views/shi_pin/common/shi_pin_tab/shi_pin_tab_wh_widget.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../components/ad_banner/ad_banner.dart';
import '../../../../components/base_refresh/base_refresh_simple_widget.dart';
import '../../../../components/no_more/no_data_sliver_list.dart';
import '../../../../components/short_widget/content/content_station_base_cell.dart';
import '../../../../model/content_model.dart';
import '../../../../utils/extension.dart';
import 'shi_pin_tab_base_widget.dart';
import 'shi_pin_tab_wh_controller.dart';

class ShiPinTabWhWidget extends ShiPinTabBaseWidget {
  const ShiPinTabWhWidget({super.key, required super.controllerTag});

  Widget _buildSliverStations(ShiPinTabWhController _) {
    return Obx(() {
      final stations = _.data
          .map(
            (e) => ContentActressStationModel(
              ContentActressStationType.video,
              content: e,
            ),
          )
          .toList();
      if (_.pornographyList.isNotEmpty) {
        stations.insertOrAdd(
          3,
          ContentActressStationModel(
            ContentActressStationType.portraitBlock,
            portraitBlock: ContentActressPortraitBlockModel(
              title: '热门网黄',
              portraitList: _.pornographyList,
            ),
          ),
        );
      }
      return NoDataSliverList.separated(
        itemCount: stations.length,
        itemBuilder: (ctx, i) {
          return ContentStationBaseCell(stations[i]);
        },
        separatorBuilder: (ctx, i) => 20.verticalSpaceFromWidth,
        noData: _.dataInited,
      );
    });
  }

  Widget _buildBody(ShiPinTabWhController _, ScrollPhysics physics) {
    return CustomScrollView(
      physics: physics,
      slivers: [
        AdBanner.index(
          margin: EdgeInsets.only(bottom: 14.w),
        ).baseMarginR.sliver,
        _buildSliverStations(_),
      ],
    ).baseMarginLt;
  }

  @override
  Widget build(BuildContext context) {
    final _ = Get.find<ShiPinTabWhController>(tag: controllerTag);
    return BaseRefreshSimpleWidget.builder(
      _,
      childBuilder: (context, physics) => _buildBody(_, physics),
    );
  }
}
