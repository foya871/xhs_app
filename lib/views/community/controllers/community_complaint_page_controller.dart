import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../components/easy_toast.dart';
import '../../../components/image_picker/easy_image_picker.dart';
import '../../../components/popup/dialog/future_loading_dialog.dart';
import '../../../http/api/api.dart';
import '../../../http/service/api_service.dart';
import '../../../model/community/community_base_model.dart';
import '../../../utils/pair.dart';
import '../../../utils/utils.dart';

class CommunityComplaintModel {
  final String text;
  final int id;

  CommunityComplaintModel(this.text, this.id);
}

class CommunityComplaintPageController extends GetxController {
  late final CommunityBaseModel model;
  final selectedId = 0.obs;
  final editingController = TextEditingController();
  final pickedImages = <Pair<Uint8List, String>>[].obs; // <bytes, 上传结果>

  static final models = [
    CommunityComplaintModel('政治敏感', 1),
    CommunityComplaintModel('虚假不实', 2),
    CommunityComplaintModel('涉及未成年', 3),
    CommunityComplaintModel('搬运抄袭', 4),
    CommunityComplaintModel('广告宣传', 5),
    CommunityComplaintModel('其他', 6),
  ];

  final int maxImage = 3;

  void onTapSelect(int id) => selectedId.value = id;

  void onTapPickImage() async {
    final files = await EasyImagePicker.pickImagesGrant(
      maxAssets: maxImage - pickedImages.length,
    );
    final images = <Pair<Uint8List, String>>[];
    for (final f in files) {
      final bytes = await f.bytes;
      if (bytes != null) {
        images.add(Pair(bytes, ""));
      }
    }

    pickedImages.addAll(images);
  }

  void onSubmit() async {
    if (selectedId.value == 0) {
      EasyToast.show('请选择投诉原因');
      return;
    }
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
            image.item2 = fileName!;
          }
          return true;
        },
        tips: '正在上传图片..',
      ).show();
    }
    if (uploadImageOk != true) return;
    final future = Api.complaintCommunity(
      dynamicId: model.dynamicId,
      reason: selectedId.value,
      remark: editingController.text.trim(),
      imgs: pickedImages.map((e) => e.item2).toList(),
    );
    await FutureLoadingDialog(future, tips: '正在提交..').show();
    Get.back(); // 退出本页
  }

  @override
  void onInit() {
    model = Utils.asType<CommunityBaseModel>(Get.arguments)!;
    super.onInit();
  }

  @override
  void onClose() {
    editingController.dispose();
    super.onClose();
  }
}
