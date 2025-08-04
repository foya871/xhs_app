import 'package:collection/collection.dart';
import 'package:get/get.dart';

import '../../../components/base_refresh/base_refresh_simple_controller.dart';
import '../../../http/api/api.dart';
import '../../../model/community/community_base_model.dart';
import '../../../model/user/recommend_user_model.dart';
import '../../main/controllers/main_controller.dart';

const _useObs = true;
// 每一块推荐关注，显示多少个用户
const _userCountPerRow = 10;
// 每隔多少动态插入一个推荐关注
const _insertUserDynInterval = 12;
// 拉取动态的数量
const _dynPageSize = _insertUserDynInterval * 5;
// 每次拉取推荐用户的数量
const _userPageSize =
    (_dynPageSize ~/ _insertUserDynInterval) * _userCountPerRow;

// 两种模式(有关注和无关注)，三种数据
// CommunityBaseModel | List<RecommendUserModel> | CommunityNotConcernedModel
typedef CommuntiyAttentionPageModel = dynamic;

List<CommuntiyAttentionPageModel> _mergeUserToDyns(
  List<CommunityBaseModel> dyns,
  List<RecommendUserModel>? users,
) {
  if (users == null) return dyns;

  final dynSlices = dyns.slices(_insertUserDynInterval).toList();
  final userSlices = users.slices(_userCountPerRow).toList();
  final result = <CommuntiyAttentionPageModel>[];

  for (int i = 0; i < dynSlices.length; i++) {
    result.addAll(dynSlices[i]);
    if (i < userSlices.length) {
      result.add(userSlices[i]);
    }
  }
  return result;
}

class CommuntiyAttentionPageController
    extends BaseRefreshSimpleController<CommuntiyAttentionPageModel> {
  @override
  bool get useObs => _useObs;
  final attentionMode = false.obs;
  // 即使推荐用户的页数比动态的多，也不忽略，判断翻页结束只根据动态的翻页结束
  bool _dynNoMore = false;
  bool _userNoMore = false;

  @override
  Future<List<CommuntiyAttentionPageModel>?> dataFetcher(int page,
      {required bool isRefresh}) async {
    if (isRefresh) {
      final dynResp = await Api.getCommunityAttentionList(
        page: page,
        pageSize: _dynPageSize,
      );
      if (dynResp == null) return null;

      _dynNoMore = dynResp.data.length < _dynPageSize;

      attentionMode.value = dynResp.data.isNotEmpty;
      if (attentionMode.value) {
        final userResp = await Api.getUserRecommendList(
          page: page,
          pageSize: _userPageSize,
        );

        if (userResp != null) {
          _userNoMore = userResp.length < _userPageSize;
        }
        Get.find<MainController>().clearCommunityPushedMessageCount();
        return _mergeUserToDyns(dynResp.data, userResp);
      }
    }
    if (attentionMode.value) {
      final dynRespFuture = Api.getCommunityAttentionList(
        page: page,
        pageSize: _dynPageSize,
      );
      List<RecommendUserModel>? userResp;
      if (!_userNoMore) {
        final userRespFuture = Api.getUserRecommendList(
          page: page,
          pageSize: _userPageSize,
        );
        userResp = await userRespFuture;
      }

      final dynResp = await dynRespFuture;
      if (dynResp == null) return null;
      _dynNoMore = dynResp.data.length < _dynPageSize;
      if (userResp != null) {
        _userNoMore = userResp.length < _userPageSize;
      }
      return _mergeUserToDyns(dynResp.data, userResp);
    } else {
      return Api.getCommunityNotConcernedList(
        page: page,
        pageSize: _dynPageSize,
      );
    }
  }

  @override
  bool noMoreChecker(List resp) => _dynNoMore;
}
