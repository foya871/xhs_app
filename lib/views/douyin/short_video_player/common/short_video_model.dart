import 'dart:async';

import 'package:dio/dio.dart';

import '../../../../http/api/api.dart';
import '../../../../model/play/video_detail_model.dart';
import '../../../../model/video_base_model.dart';
import '../../../../utils/logger.dart';

class ShortVideoModel {
  final int index;
  final VideoBaseModel base;
  VideoDetail? detail;
  Completer<VideoDetail?>? _detailCompleter;
  CancelToken? _cancelToken;

  ShortVideoModel(this.base, {required this.index});

  bool isFetchingDetail() {
    if (_detailCompleter == null) {
      fetchDetail();
    }
    return _detailCompleter!.isCompleted;
  }

  Future<VideoDetail?> fetchDetail({bool forceRetry = false}) {
    if (_detailCompleter == null) {
      detail = null;
      _cancelToken = CancelToken();
      _detailCompleter = Completer();
      Api.fetchShortVideoDetail(
        videoId: base.videoId ?? 0,
        token: _cancelToken,
      ).then((v) {
        detail = v;
        _detailCompleter!.complete(v);
      });
      logger.d('开始加载视频详情  ${base.videoId}, ${base.title}');
      return _detailCompleter!.future;
    } else {
      // 强制重试
      if (forceRetry) {
        _cancelToken?.cancel();
        _detailCompleter = null;
        return fetchDetail();
      }
    }
    return _detailCompleter!.future;
  }
}
