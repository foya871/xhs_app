import 'package:get/get.dart';

import '../../../components/brush/brush_base_model.dart';
import '../../../components/brush/brush_base_page_controller.dart';
import '../../../http/api/api.dart';
import '../../../model/community/community_model.dart';
import '../../../utils/consts.dart';
import '../../../utils/enum.dart';
import '../../../utils/logger.dart';
import '../../../utils/utils.dart';
import '../common/base/community_detail/community_detail_brush_cell_controller.dart';

const _pageSize = 60;
const _preLoadDetailCount = 3;

// 本应该使用CommunityBaseModel
// 但不是所有情况都有，这里构建一个通用的model
class CommunityBrushBaseInfo {
  final int dynamicId;
  final CommunityType dynamicType;

  CommunityBrushBaseInfo(this.dynamicId, this.dynamicType);
}

typedef CommunityBrushModel
    = BrushBaseModel<CommunityBrushBaseInfo, CommunityModel>;

class CommunityDetailPageController
    extends BrushBasePageController<CommunityBrushModel> with StateMixin {
  late final int dynamicId;
  late CommunityType? dynamicType;
  CommunityModel? detail; // 刷片不一定有值，其他一定有值
  bool pageVisible = false;
  int pageIndex = -1;

  final cellControllers = <int, CommunityBrushDetailCellController>{};

  CommunityBrushDetailCellController findBrushCellController(
          int index, CommunityBrushModel model) =>
      cellControllers.putIfAbsent(
        index,
        () => Get.find<CommunityBrushDetailCellController>()
          ..init(model)
          ..initCheckPlayable(() => pageVisible && model.index == pageIndex),
      );

  void _preLoadDetail(int index) {
    final itemList = pagingController.itemList;
    if (itemList == null) return;
    final length = itemList.length;
    final end = index + _preLoadDetailCount;
    for (int i = index; (i < length && i < end); i++) {
      itemList[i].fetchDetail();
    }
  }

  @override
  void onPageIndexChanged(int pageIndex) {
    this.pageIndex = pageIndex;
    _deleteCellControllers(exceptIndex: pageIndex);
    _preLoadDetail(pageIndex);
    cellControllers.forEach((_, v) => v.onPageIndexChanged(pageIndex));
  }

  @override
  void onVisibleChanged(bool visible) {
    pageVisible = visible;
    cellControllers.forEach((_, v) => v.onPageVisibleChanged(visible));
  }

  void _deleteCellControllers({int? exceptIndex}) {
    final needDeleted = <int>[];
    cellControllers.forEach((i, v) {
      if (i == exceptIndex) return;
      needDeleted.add(i);
    });
    for (var index in needDeleted) {
      final c = cellControllers.remove(index);
      if (c == null) continue;
      Get.asap(() {
        c.onDelete();
        Get.log('"ShortVPCellController index:$index" onClose() called');
        Get.log('"ShortVPCellController index:$index" deleted from memory');
      });
    }
  }

  BrushDetailFetcher<CommunityModel?> _makeDetailFetcher(
          int dynamicId, CommunityType type) =>
      () => Api.getDynamicDetail(dynamicId, type: dynamicType);

  Future<void> _fetchBrushList(int page) async {
    int index = pagingController.itemList?.length ?? 0;
    // 第一页，用初始的这个
    if (page == Consts.pageFirst) {
      pagingController.appendPage(
        [
          CommunityBrushModel(
            CommunityBrushBaseInfo(dynamicId, dynamicType!),
            index: index++,
            detail: detail, // 可能有，可能没有
            detailFetcher: _makeDetailFetcher(dynamicId, dynamicType!),
          )
        ],
        page + 1,
      );
      onPageIndexChanged(0);
      return;
    }
    final resp = await Api.getCommunityBrushList(
      dynamicId: dynamicId,
      page: page - 1,
      pageSize: _pageSize,
    );
    if (isClosed) return;

    if (resp == null) {
      pagingController.error = '';
      return;
    }

    final list = resp
        .map(
          (e) => CommunityBrushModel(
            CommunityBrushBaseInfo(e.dynamicId, e.dynamicType),
            index: index++,
            detailFetcher: _makeDetailFetcher(e.dynamicId, e.dynamicType),
          ),
        )
        .toList();
    if (resp.length < _pageSize) {
      pagingController.appendLastPage(list);
    } else {
      pagingController.appendPage(list, page + 1);
    }
  }

  void _initByType() {
    if (isBrushMode) {
      pagingController.addPageRequestListener(_fetchBrushList);
    }
  }

  void _changeToSuccess() {
    _initByType();
    change(null, status: RxStatus.success());
  }

  bool get isBrushMode => dynamicType == CommunityTypeEnum.video;

  Future<bool> _getDynamicDetail() async {
    final resp = await Api.getDynamicDetail(dynamicId);
    if (resp == null) return false;
    dynamicType = resp.dynamicType;
    detail = resp;
    return true;
  }

  Future<void> fetchInitDynamic({bool force = false}) async {
    change(null, status: RxStatus.loading());
    if (dynamicType == null || force) {
      // 没有type，先获取type
      final ok = await _getDynamicDetail();
      if (!ok) {
        change(null, status: RxStatus.error());
        return;
      }
    }
    if (isBrushMode) {
      // 刷片，如果detail为空，可以不用获取，cell中会获取
    } else {
      // 图文
      if (detail == null) {
        final ok = await _getDynamicDetail();
        if (!ok) {
          change(null, status: RxStatus.error());
          return;
        }
      }
    }
    _changeToSuccess();
  }

  @override
  void onInit() {
    logger.d('community detail page controll onInit $hashCode');
    dynamicId = Utils.asType<int>(Get.arguments?['dynamicId'])!;
    dynamicType = Utils.asType<CommunityType>(Get.arguments?['dynamicType']);
    fetchInitDynamic();
    super.onInit();
  }

  @override
  void onClose() {
    logger.d('community detail page controll close $hashCode');
    _deleteCellControllers();
    super.onClose();
  }
}
