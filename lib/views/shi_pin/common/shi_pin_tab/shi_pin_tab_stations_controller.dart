import '../../../../http/api/api.dart';
import '../../../../model/station_model.dart';
import 'shi_pin_tab_base_controller.dart';

const _useObs = true;
const _pageSize = 60;

class ShiPinTabStationsController
    extends ShiPinTabBaseController<StationModel> {
  ShiPinTabStationsController(super.classify);

  @override
  bool get useObs => _useObs;

  @override
  Future<List<StationModel>?> dataFetcher(int page, {required bool isRefresh}) {
    return Api.fetchStationsByClassifyId(
      classifyId: classify.classifyId,
      page: page,
      pageSize: _pageSize,
    );
  }

  @override
  bool noMoreChecker(List resp) => resp.length < _pageSize;
}
