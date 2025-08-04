import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xhs_app/components/ad/ad_enum.dart';
import 'package:xhs_app/components/ad/ad_utils.dart';

import '../../../../components/grid_view/heighted_grid_view.dart';
import '../../../../components/short_widget/video_base_or_ad_cell.dart';
import '../../../../model/video_base_model.dart';
import '../../../../utils/enum.dart';

abstract class ShiPinUtils {
  static Widget buildSilverLayoutVideos(
    List<VideoBaseModel> models, {
    required VideoLayout layout, // 布局 大、小
    bool isVerticalLayout = false, // 布局 横、竖
    required bool dataInited,
  }) {
    AdApiType place;
    if (isVerticalLayout) {
      if (layout == VideoLayout.big) {
        place = AdApiTypeCompat.VERTICAL_LIST_INSERT;
      } else {
        place = AdApiTypeCompat.THREE_LIST_VERTICAL;
      }
    } else {
      if (layout == VideoLayout.big) {
        place = AdApiTypeCompat.LIST_STREAM;
      } else {
        place = AdApiTypeCompat.HORIZONTAL_LIST_INSERT;
      }
    }
    final interval = adHelper.getInsertWeight(place);
    final isSmallLayout = layout == VideoLayout.small;
    if (isVerticalLayout) {
      return HeightedGridView.sliver(
        crossAxisCount: isSmallLayout ? 3 : 2,
        itemCount: adHelper.withAdLength(models.length, interval: interval),
        rowMainAxisAlignment: isSmallLayout
            ? MainAxisAlignment.start
            : MainAxisAlignment.spaceBetween,
        columnSpacing: isSmallLayout ? 7.4.w : null,
        itemBuilder: (ctx, i) {
          final model = adHelper.modelByBuildIndex(
            i,
            models: models,
            interval: interval,
            place: place,
          );
          return isSmallLayout
              ? VideoBaseOrAdCell.smallVertical(model)
              : VideoBaseOrAdCell.bigVertical(model);
        },
        noData: dataInited,
        rowSepratorBuilder: (ctx, i) => 10.verticalSpaceFromWidth,
      );
    } else {
      return HeightedGridView.sliver(
        crossAxisCount: isSmallLayout ? 2 : 1,
        itemCount: adHelper.withAdLength(models.length, interval: interval),
        itemBuilder: (ctx, i) {
          final model = adHelper.modelByBuildIndex(
            i,
            models: models,
            interval: interval,
            place: place,
          );
          return isSmallLayout
              ? VideoBaseOrAdCell.small(model)
              : VideoBaseOrAdCell.big(model);
        },
        noData: dataInited,
        rowSepratorBuilder: (ctx, i) => 10.verticalSpaceFromWidth,
      );
    }
  }
}
