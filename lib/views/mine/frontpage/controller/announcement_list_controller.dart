import 'package:easy_refresh/easy_refresh.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_controller.dart';
import 'package:xhs_app/components/base_refresh/base_refresh_page_counter.dart';
import 'package:xhs_app/http/service/api_service.dart';
import 'package:xhs_app/model/mine/ann_news_model.dart';
import 'package:get/get.dart';

const _pageSize = 10;

class AnnouncementListController extends BaseRefreshController
    with BaseRefreshPageCounter {
  final annnews = <AnnNewsRespModel>[].obs;

  AnnouncementListController();

  @override
  Future<IndicatorResult> onRefresh() async {
    resetPage();
    final reqPage = page;
    final annnewsFuture = getAnnList(page: reqPage, pageSize: _pageSize);
    final annnews = await annnewsFuture;
    if (annnews == null) {
      return IndicatorResult.fail;
    }
    _setAnnews(annnews);
    return IndicatorResult.success;
  }

  @override
  Future<IndicatorResult> onLoad() async {
    final reqPage = page;
    final resp = await getAnnList(page: reqPage, pageSize: _pageSize);
    if (resp == null) {
      return IndicatorResult.fail;
    }
    _addAnnews(resp);
    if (resp.length < _pageSize) {
      return IndicatorResult.noMore;
    }
    incPage();
    return IndicatorResult.success;
  }

  @override
  void onInit() {
    super.onInit();
  }

  Future<List<AnnNewsRespModel>?> getAnnList(
      {required int page, required int pageSize}) async {
    try {
      final resp = await httpInstance.get(
          url: "news/ann/list",
          queryMap: {
            "page": page,
            "pageSize": pageSize,
          },
          complete: AnnNewsRespModel.fromJson);
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  void _setAnnews(List<AnnNewsRespModel>? annews) {
    this.annnews.clear();
    _addAnnews(annews);
  }

  void _addAnnews(List<AnnNewsRespModel>? annews) {
    if (annews != null && annews.isNotEmpty) {
      this.annnews.addAll(annews);
    }
  }
}
