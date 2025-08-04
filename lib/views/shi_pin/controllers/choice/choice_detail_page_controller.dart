import 'package:get/get.dart';

import '../../../../http/api/api.dart';
import '../../../../model/choice/choice_models.dart';
import '../../../../model/video_base_model.dart';
import '../../../../utils/enum.dart';
import '../../../../utils/utils.dart';
import '../station_choice_detail_base_page_controller.dart';

class ChoiceDetailPageController extends StationChoiceDetailBasePageController {
  late final VideoChoiceModel choice;

  @override
  String get title => choice.choiceName;
  @override
  String get info => choice.info;
  @override
  String get coverImg => choice.coverImg;
  @override
  Future<List<VideoBaseModel>?> Function(int page, int pageSize) dataFetcherApi(
      VideoSortType sortType) {
    return (int page, int pageSize) => Api.fetchVideosByChoiceId(
          choiceId: choice.choiceId,
          page: page,
          pageSize: pageSize,
          sortType: sortType,
        );
  }

  @override
  bool get isVerticalLayout => false;

  @override
  void onInit() {
    choice = Utils.asType<VideoChoiceModel>(Get.arguments?['choice'])!;
    super.onInit();
  }
}
