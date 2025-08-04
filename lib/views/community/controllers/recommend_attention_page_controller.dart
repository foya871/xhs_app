import '../../../components/base_refresh/base_refresh_simple_controller.dart';
import '../../../http/api/api.dart';
import '../../../model/user/recommend_user_model.dart';

const _useObs = true;
const _pageSize = 60;

class RecommendAttentionPageController
    extends BaseRefreshSimpleController<RecommendUserModel> {
  @override
  bool get useObs => _useObs;

  @override
  Future<List<RecommendUserModel>?> dataFetcher(int page,
          {required bool isRefresh}) =>
      Api.getUserRecommendList(
        page: page,
        pageSize: _pageSize,
      );

  @override
  bool noMoreChecker(List resp) => resp.length < _pageSize;
}
