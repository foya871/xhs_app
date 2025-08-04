/*
 * @Author: ziqi z3ba1233@gmail.com
 * @Date: 2024-08-15 09:43:31
 * @LastEditors: ziqi jhzq12345678
 * @LastEditTime: 2024-12-31 15:21:04
 * @FilePath: /test_drive/lib/views/webView/web.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:xhs_app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

// ignore: avoid_web_libraries_in_flutter
import 'package:universal_html/html.dart' as html;

class H5WebViewPage extends StatefulWidget {
  final String url;
  const H5WebViewPage({
    super.key,
    required this.url,
  });
  @override
  State<H5WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<H5WebViewPage> {
  late WebViewXController _controller;
  String _title = '';
  void initWebMessage(v) {
    String message = v.data;
    if (message == 'vip') {
      Get.toVip();
    }
    if (message == 'wallet') {
      Get.toVip(tabInitIndex: 1);
    }
  }

  @override
  void initState() {
    super.initState();
    html.window.addEventListener('message', initWebMessage);
  }

  @override
  void dispose() {
    _controller.dispose();
    html.window.removeEventListener('message', initWebMessage);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: Text(_title)),
      body: WebViewX(
        initialSourceType: SourceType.url,
        width: screenWidth,
        height: screenHeight,
        initialContent: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (controller) async {
          _controller = controller;
          _title = await controller.getTitle() ?? '';
          if (mounted) {
            setState(() {});
          }
        },
      ),
    );
  }
}
