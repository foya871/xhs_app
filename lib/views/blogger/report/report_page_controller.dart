import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tuple/tuple.dart';
import 'package:xhs_app/components/easy_toast.dart';
import 'package:xhs_app/components/image_picker/easy_image_picker.dart';
import 'package:xhs_app/components/popup/dialog/future_loading_dialog.dart';
import 'package:xhs_app/http/api/api.dart';
import 'package:xhs_app/http/service/api_service.dart';
import 'package:xhs_app/utils/pair.dart';

class ReportPageController extends GetxController {
  int userId = 0;
  List<Tuple2<String, int>> reportList = [
    const Tuple2('政治敏感', 1),
    const Tuple2('虚假不时', 2),
    const Tuple2('搬运抄袭', 4),
    const Tuple2('广告宣传', 5),
    const Tuple2('其他', 6),
  ];
  var checkedIndex = 0.obs;

  TextEditingController editingController = TextEditingController();

  var pickedImages = <Tuple2<Uint8List, String>>[].obs; // <bytes, 上传结果>
  final int maxImage = 3;

  @override
  void onInit() {
    userId = Get.arguments['userId'];
    super.onInit();
  }

  void onTapPickImage() async {
    final files = await EasyImagePicker.pickImagesGrant(
      maxAssets: maxImage - pickedImages.length,
    );
    final images = <Tuple2<Uint8List, String>>[];
    for (final file in files) {
      final bytes = await file.bytes;
      if (bytes != null && bytes.isNotEmpty) {
        images.add(Tuple2(bytes, ""));
      }
    }

    pickedImages.addAll(images);
  }

  void onSubmit() async {
    // 上传图片
    bool? uploadImageOk = true;
    if (pickedImages.isNotEmpty) {
      uploadImageOk = await FutureLoadingDialog<bool>.lazy(
        () async {
          for (int i = 0; i < pickedImages.length; i++) {
            final image = pickedImages[i];
            if (image.item2.isNotEmpty) {
              continue;
            }
            final resp = await httpInstance.uploadImageSafe(
              pickedImages[i].item1,
            );
            final fileName = resp?.fileName;
            if (fileName?.isNotEmpty != true) {
              EasyToast.show('上传图片识别, 请重试...');
              return false;
            }
            pickedImages[i] = Tuple2(image.item1, fileName!);
          }
          return true;
        },
        tips: '正在上传图片..',
      ).show();
    }
    if (uploadImageOk != true) return;
    final future = Api.complaintUser(
      userId: userId,
      reason: reportList[checkedIndex.value].hashCode,
      remark: editingController.text.trim(),
      imgs: pickedImages.map((e) => e.item2).toList(),
    );
    await FutureLoadingDialog(future, tips: '正在提交..').show();
    Get.back();
  }

  @override
  void onClose() {
    editingController.dispose();
    super.onClose();
  }
}
