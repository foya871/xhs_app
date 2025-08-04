import 'package:get/get.dart';
import 'package:tuple/tuple.dart';

import '../../../components/base_refresh/base_refresh_data_keeper.dart';
import '../../../components/base_refresh/base_refresh_tab_controller.dart';
import '../../../components/base_refresh/base_refresh_tab_key.dart';
import '../../../http/api/api.dart';
import '../../../model/community/community_base_model.dart';
import '../../../utils/utils.dart';

const _pageSize = 60;
bool _userObs = true;
const _sortTypeHot = 1;
const _sortTypeLatest = 2;

class _DataKeeper
    extends BaseRefreshDataKeeperWithERController<CommunityBaseModel> {
  String topic;
  int sortType;
  _DataKeeper({required this.topic, required this.sortType});

  @override
  bool get useObs => _userObs;

  @override
  bool noMoreChecker(List resp) => resp.length < _pageSize;

  @override
  Future<List<CommunityBaseModel>?> dataFetcher(int page,
          {required bool isRefresh}) =>
      Api.getTopicInfo(
        name: topic,
        page: page,
        pageSize: _pageSize,
        sortType: sortType,
      );
}

class CommunityTopicPageController extends BaseRefreshDefaultTabController {
  static const tabs = [
    Tuple2('最热', _sortTypeHot),
    Tuple2('最新', _sortTypeLatest),
  ];

  late final String topic;

  @override
  bool get useObs => _userObs;

  @override
  BaseRefreshDataKeeperWithERController initDataKeeper(
      BaseRefreshTabKey tabKey) {
    final key = tabKey as BaseRefreshTabIndexKey;
    return _DataKeeper(topic: topic, sortType: tabs[key.index].item2);
  }

  @override
  void onInit() {
    topic = Utils.asType<String>(Get.arguments?['topic'])!;
    super.onInit();
  }
}
