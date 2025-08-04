/*
 * @Author: wangdazhuang
 * @Date: 2024-10-16 17:25:14
 * @LastEditTime: 2024-10-16 19:17:57
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /xhs_app/lib/src/components/popup/dialog/video_in_waiting_dialog.dart
 */
import 'package:get/get.dart';
import 'package:xhs_app/components/popup/dialog/base_confirm_dialog.dart';

import '../../../routes/routes.dart';

class VideoInWaitingDialog extends BaseConfirmDialog {
  VideoInWaitingDialog()
      : super(
          titleText: '温馨提示',
          descText: '视频已在下载队列中.',
          cancelText: '取消',
          confirmText: '查看下载',
          autoBackOnCancel: true,
          autoBackOnConfirm: true,
          onConfirm: () {
            Get.toNamed(Routes.download);
          },
        );
}
