import '../../../../http/api/api.dart';
import '../../../../model/content_model.dart';
import '../../../../utils/consts.dart';
import 'shi_pin_tab_base_controller.dart';

const _useObs = true;
const _pageSize = 60;

class ShiPinTabWhController extends ShiPinTabBaseController<ContentBaseModel> {
  ShiPinTabWhController(super.classify);
  @override
  bool get useObs => _useObs;

  List<PornographyModel> pornographyList = <PornographyModel>[];

  @override
  Future<List<ContentBaseModel>?> dataFetcher(int page,
      {required bool isRefresh}) async {
    final resp = await Api.fetchPornography(page: page, pageSize: _pageSize);
    if (resp == null) return null;
    if (page == Consts.pageFirst && resp.contentList.isNotEmpty) {
      pornographyList = resp.contentList;
    }
    return resp.contentVideoList;
  }

  @override
  bool noMoreChecker(List resp) => resp.length < _pageSize;
}
