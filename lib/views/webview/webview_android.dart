/*
 * @Author: ziqi z3ba1233@gmail.com
 * @Date: 2024-08-14 17:37:58
 * @LastEditors: wangdazhuang
 * @LastEditTime: 2024-09-02 11:33:39
 * @FilePath: /xhs_app/lib/src/views/webview/webview_android.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:xhs_app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AndroidWebViewPage extends StatefulWidget {
  final String url;
  const AndroidWebViewPage({
    super.key,
    required this.url,
  });
  @override
  State<AndroidWebViewPage> createState() => _AndroidWebViewPageState();
}

class _AndroidWebViewPageState extends State<AndroidWebViewPage> {
  String _title = '';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_title)),
      body: Stack(
        children: [
          Positioned.fill(
            child: InAppWebView(
              initialUrlRequest: URLRequest(url: WebUri(widget.url)),
              onTitleChanged: (controller, title) {
                _title = title ?? '';
                setState(() {});
              },
              onConsoleMessage: (controller, consoleMessage) {
                final event = consoleMessage.message;
                if (event == 'vip') {
                  Get.toVip();
                } else if (event == 'wallet') {
                  Get.toVip(tabInitIndex: 1);
                } else if (event == 'startShare') {
                  Get.toShare();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
