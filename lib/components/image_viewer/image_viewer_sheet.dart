import 'package:flutter/material.dart';

import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:xhs_app/components/image_view.dart';
import 'package:xhs_app/services/storage_service.dart';
import 'package:xhs_app/utils/extension.dart';
import 'package:photo_view/photo_view.dart';

void imageViewerSheet(String src) {
  String domain = Get.find<StorageService>().imgDomain ?? '';

  SmartDialog.show(
    builder: (context) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: PhotoView(
          basePosition: Alignment.center,
          backgroundDecoration:
              const BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.5)),
          imageProvider: ImageViewProvider(domain + src),
        ),
      ).onOpaqueTap(() {
        SmartDialog.dismiss();
      });
    },
  );
}
