import 'package:xhs_app/components/easy_toast.dart';
import 'package:xhs_app/utils/logger.dart';
import 'package:flutter/services.dart';

abstract class CopyPasteView {
  //复制内容
  static Future<void> copy(String? text, {bool allowEmpty = false}) async {
    if (allowEmpty) {
      text ??= '';
    } else {
      if (text == null || text.isEmpty) {
        return;
      }
    }
    try {
      await Clipboard.setData(ClipboardData(text: text));
      EasyToast.show('复制成功');
    } catch (e) {
      logger.d('copy fail $text');
    }
  }

  //获取内容
  static Future<String> paste() async {
    var clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
    return clipboardData?.text ?? '';
  }
}
