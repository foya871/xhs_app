import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:universal_html/html.dart' as html;

import '../../components/diolog/dialog.dart';
import '../../components/safe_state.dart';
import '../../http/api/login.dart';
import '../../routes/routes.dart';
import '../../services/storage_service.dart';
import '../../utils/ad_jump.dart';
import '../../utils/logger.dart';

// ignore: unused_element
// class _IFrame extends StatelessWidget {
//   final String url;
//   const _IFrame({required this.url});

//   @override
//   Widget build(BuildContext context) {
//     return HtmlElementView.fromTagName(
//       tagName: 'iframe',
//       onElementCreated: (element) {
//         element as html.IFrameElement;
//         element.src = url;
//         element.style.border = 'none';
//         element.style.width = '100%';
//         element.style.height = '100%';
//       },
//     );
//   }
// }

class AppWebViewPage extends StatefulWidget {
  final String url;
  final bool showScrollBar;
  const AppWebViewPage({
    super.key,
    required this.url,
    this.showScrollBar = false,
  });

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends SafeState<AppWebViewPage> {
  final gestureRecognizers = <Factory<DragGestureRecognizer>>{}
    ..add(Factory<VerticalDragGestureRecognizer>(
      () => VerticalDragGestureRecognizer(),
    ))
    ..add(Factory<HorizontalDragGestureRecognizer>(
      () => HorizontalDragGestureRecognizer(),
    ));

  @override
  void initState() {
    super.initState();
    html.window.addEventListener('message', _messageListener);
  }

  @override
  void dispose() {
    html.window.removeEventListener('message', _messageListener);
    super.dispose();
  }

  void _messageListener(html.Event event) {
    if (event is html.MessageEvent && event.data is String) {
      _handleEvent(event.data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(children: [
          Expanded(
            child: InAppWebView(
              gestureRecognizers: gestureRecognizers,
              initialSettings: InAppWebViewSettings(
                verticalScrollBarEnabled: widget.showScrollBar,
                horizontalScrollBarEnabled: widget.showScrollBar,
              ),
              initialUrlRequest: URLRequest(url: WebUri(widget.url)),
              onWebViewCreated: (controller) {
                // _webViewController = controller;
                // _addListeners(controller);
              },
              onConsoleMessage: (controller, consoleMessage) async {
                if (kIsWeb) return;
                final event = consoleMessage.message;
                _handleEvent(event);
              },
            ),
          ),
        ]),
      ),
    );
  }
}

void _handleEvent(String event) => switch (event) {
      'undefined' || 'wallet' || 'startWallet' => Get.toVip(tabInitIndex: 1),
      'back' => Get.back(),
      'auth' => _handleAuth(),
      _ => logger.d('unhandled event $event'),
    };

void _handleAuth() {
  showAlertDialog(
    Get.context!,
    title: '温馨提示',
    message: 'token过期，请点击确定重新初始化',
    isSingleButton: true,
    onRightButton: () async {
      Get.back();
      await login(Get.find<StorageService>().deviceId ?? '');
      jump2Ai();
    },
  );
}
