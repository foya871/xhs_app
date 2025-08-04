import 'package:get/get.dart';

import '../../../../components/short_widget/station_base_cell/station_base_cell_controller.dart';
import '../../../../model/classify/classify_models.dart';
import '../../../../utils/enum.dart';
import 'shi_pin_tab_attention_controller.dart';
import 'shi_pin_tab_attention_widget.dart';
import 'shi_pin_tab_base_widget.dart';
import 'shi_pin_tab_empty_widget.dart';
import 'shi_pin_tab_stations_controller.dart';
import 'shi_pin_tab_stations_widget.dart';
import 'shi_pin_tab_videos_controller.dart';
import 'shi_pin_tab_videos_widget.dart';
import 'shi_pin_tab_wh_controller.dart';
import 'shi_pin_tab_wh_widget.dart';

abstract class ShiPinTabFactory {
  static ShiPinTabBaseWidget create(
      int classifyId, ShiPinClassifyType classifyType) {
    final tag = _tagBuilder(classifyId);
    return switch (classifyType) {
      ShiPinClassifyTypeEnum.vidoes =>
        ShiPinTabVideosWidget(controllerTag: tag),
      ShiPinClassifyTypeEnum.stations =>
        ShiPinTabStationsWidget(controllerTag: tag),
      ShiPinClassifyTypeEnum.wh => ShiPinTabWhWidget(controllerTag: tag),
      ShiPinClassifyTypeEnum.attention =>
        ShiPinTabAttentionWidget(controllerTag: tag),
      _ => ShiPinTabEmptyWidget(controllerTag: tag),
    };
  }

  static String _tagBuilder(int classifyId) => '$classifyId';

  static void bind(ClassifyModel classify) {
    final tag = _tagBuilder(classify.classifyId);
    switch (classify.type) {
      case ShiPinClassifyTypeEnum.vidoes:
        Get.lazyPut(
          () => ShiPinTabVideosController(classify),
          tag: tag,
        );
        break;
      case ShiPinClassifyTypeEnum.stations:
        Get.create(() => StationBaseCellController());
        Get.lazyPut(
          () => ShiPinTabStationsController(classify),
          tag: tag,
        );
        break;

      case ShiPinClassifyTypeEnum.wh:
        Get.lazyPut(
          () => ShiPinTabWhController(classify),
          tag: tag,
        );
        break;
      case ShiPinClassifyTypeEnum.attention:
        Get.lazyPut(
          () => ShiPinTabAttentionController(classify),
          tag: tag,
        );
        break;
      default:
        assert(false, 'unknown classifyType ${classify.type}');
    }
  }
}
