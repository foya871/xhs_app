import 'package:xhs_app/http/api/api.dart';
import 'package:xhs_app/model/community/community_base_model.dart';
import 'package:xhs_app/views/community/common/classify_tabs/community_tab_base_controller.dart';

const _useObs = true;
const _pageSize = 60;

class VideoTabTuiJianController
    extends CommunityTabBaseController<CommunityBaseModel> {
  VideoTabTuiJianController(super.classify);

  @override
  bool get useObs => _useObs;

  @override
  Future<List<CommunityBaseModel>?> dataFetcher(int page,
      {required bool isRefresh}) {
    return Api.getCommunityListByClassify(
      classifyTitle: classify.classifyTitle,
      page: page,
      pageSize: _pageSize,
    );
  }

  @override
  bool noMoreChecker(List resp) => resp.isEmpty; //  这里用空判断不用length
}
