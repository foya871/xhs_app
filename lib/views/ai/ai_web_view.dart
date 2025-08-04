import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/base_page/base_error_widget.dart';
import '../../components/base_page/base_loading_widget.dart';
import '../../components/safe_state.dart';
import '../../http/api/api.dart';
import '../../services/storage_service.dart';
import '../webview/webview_page.dart';

class AiWebView extends StatefulWidget {
  const AiWebView({super.key});

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends SafeState {
  late Future<String?> _future;
  CancelToken? _cancelToken;
  @override
  void initState() {
    super.initState();
    _initFuture();
  }

  @override
  void dispose() {
    _cancel();
    super.dispose();
  }

  void _cancel() {
    _cancelToken?.cancel();
    _cancelToken = null;
  }

  void _initFuture() {
    _cancel();
    var link = Get.find<StorageService>().aiLink ?? '';
    if (link.isNotEmpty) {
      _future = Future.value(link);
    } else {
      _cancelToken = CancelToken();
      _future = Api.fetchAILink(cancelToken: _cancelToken);
    }
  }

  String _buildUrl(String aiLink) {
    final token = Get.find<StorageService>().token ?? '';
    return '$aiLink?token=$token&isHome=true&app=xhs';
  }

  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: _future,
        builder: (context, snapshot) => switch (snapshot.connectionState) {
          ConnectionState.done => snapshot.data != null
              ? AppWebViewPage(url: _buildUrl(snapshot.data!))
              : BaseErrorWidget(onTap: () => setState(_initFuture)),
          _ => const BaseLoadingWidget(),
        },
      );
}
