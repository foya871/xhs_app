/*
 * @Author: ziqi jhzq12345678
 * @Date: 2025-01-17 14:46:54
 * @LastEditors: ziqi jhzq12345678
 * @LastEditTime: 2025-01-24 19:53:54
 * @FilePath: /xhs_app/lib/views/shi_pin/common/shi_pin_tab/shi_pin_tab_stations_widget.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/components/ad/ad_enum.dart';
import 'package:xhs_app/components/ad/ad_utils.dart';

import '../../../../components/ad_banner/ad_banner.dart';
import '../../../../components/base_refresh/base_refresh_simple_widget.dart';
import '../../../../components/no_more/no_data_sliver_list.dart';
import '../../../../components/short_widget/station_base_cell/station_base_or_ad_cell.dart';
import '../../../../utils/extension.dart';
import 'shi_pin_tab_base_widget.dart';
import 'shi_pin_tab_stations_controller.dart';

class ShiPinTabStationsWidget extends ShiPinTabBaseWidget {
  const ShiPinTabStationsWidget({super.key, required super.controllerTag});

  Widget _buildSilverStations(ShiPinTabStationsController _) {
    return Obx(() {
      const place = AdApiTypeCompat.INSERT_COMMON;
      final interval = adHelper.getInsertWeight(place);
      final models = _.data;
      return NoDataSliverList.separated(
        itemCount: adHelper.withAdLength(models.length, interval: interval),
        itemBuilder: (ctx, i) => StationOrInsertAdCell(
          adHelper.modelByBuildIndex(
            i,
            models: models,
            interval: interval,
            place: place,
          ),
        ),
        separatorBuilder: (ctx, i) => 20.verticalSpaceFromWidth,
        noData: _.dataInited,
      );
    });
  }

  Widget _buildBody(ShiPinTabStationsController _) => CustomScrollView(
        slivers: [
          AdBanner.index(
            margin: EdgeInsets.only(bottom: 14.w),
          ).sliver,
          _buildSilverStations(_),
        ],
      ).baseMarginHorizontal;

  @override
  Widget build(BuildContext context) {
    final _ = Get.find<ShiPinTabStationsController>(tag: controllerTag);
    return BaseRefreshSimpleWidget(_, child: _buildBody(_));
  }
}
