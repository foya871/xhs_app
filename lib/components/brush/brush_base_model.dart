import 'dart:async';

import 'package:dio/dio.dart';

typedef BrushDetailFetcher<D> = Future<D?> Function();

final class BrushBaseModel<E, D> {
  final int index;
  final E base;
  final Future<D?> Function()? _detailFetcher;
  D? _detail;
  Completer<D?>? _detailCompleter;
  CancelToken? _cancelToken;

  D? get detail => _detail;

  BrushBaseModel(
    this.base, {
    required this.index,
    required BrushDetailFetcher<D> detailFetcher,
    D? detail,
  })  : _detailFetcher = detailFetcher,
        _detail = detail;

  bool isFetchingDetail() {
    if (_detailCompleter == null) {
      fetchDetail();
    }
    return _detailCompleter!.isCompleted;
  }

  Future<D?> fetchDetail({bool forceRetry = false}) async {
    if (forceRetry) {
      _detail = null;
      _cancelToken?.cancel();
    } else {
      // 为空可能是接口失败
      if (_detail != null) return _detail;
      if (_detailCompleter != null) return _detailCompleter!.future;
    }

    // 发出请求
    _cancelToken = CancelToken();
    _detailCompleter = Completer();
    _detailFetcher!().then((v) {
      _detail = v;
      _detailCompleter!.complete(v);
    });
    return _detailCompleter!.future;
  }
}
