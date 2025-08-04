/*
 * @Author: ziqi jhzq12345678
 * @Date: 2025-01-24 15:44:54
 * @LastEditors: ziqi jhzq12345678
 * @LastEditTime: 2025-01-25 14:58:11
 * @FilePath: /xhs_app/lib/views/portray_play/controller.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:xhs_app/model/picture_detail_model/picture_detail_model.dart';
import 'package:xhs_app/repositories/picture.dart';
import 'package:xhs_app/routes/routes.dart';

class PicturePlayController extends GetxController {
  int portrayPicId = 0;
  var detail = PictureDetailModel();

  Future<void> initDetail() async {
    portrayPicId = int.tryParse(Get.parameters['portrayPicId'] ?? '') ?? 0;

    final result =
        await PictureRepositoryImpl().fetchPictureDetailById(portrayPicId);
    detail = result;
    update();
  }

  void pay() async {
    try {
      SmartDialog.showLoading();

      await PictureRepositoryImpl().pay(portrayPicId);
      SmartDialog.dismiss();
      initDetail();
    } catch (e) {
      SmartDialog.dismiss();

      if (e is Map && e['code'] == 1019) {
        Get.toVip(tabInitIndex: 1);
      }
    } finally {
      SmartDialog.dismiss();
    }
  }
}
