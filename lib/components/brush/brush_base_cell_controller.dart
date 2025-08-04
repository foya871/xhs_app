import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import 'brush_base_model.dart';

abstract class BrushBaseCellController<E, D> extends GetxController
    with StateMixin {
  final inited = Completer<bool>(); // 是否初始化
  late final BrushBaseModel<E, D> model;

  @mustCallSuper
  void init(BrushBaseModel<E, D> model) {
    if (inited.isCompleted) return;
    this.model = model;
    inited.complete(true);
  }

  void onPageVisibleChanged(bool pageVisible);
  void onPageIndexChanged(int pageIndex);
  void waitLoadingDetail({bool forceRetry = false}) async {
    change(null, status: RxStatus.loading());
    await inited.future;
    await model.fetchDetail(forceRetry: forceRetry);
    if (isClosed) return;
    if (model.detail == null) {
      change(null, status: RxStatus.error());
    } else {
      change(null, status: RxStatus.success());
    }
  }

  @override
  void onInit() {
    waitLoadingDetail();
    super.onInit();
  }
}
