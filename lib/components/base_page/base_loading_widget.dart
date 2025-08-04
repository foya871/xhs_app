/*
 * @Author: wangdazhuang
 * @Date: 2025-03-05 16:36:42
 * @LastEditTime: 2025-03-05 17:01:36
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /xhs_app/lib/components/base_page/base_loading_widget.dart
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/components/image_view.dart';
import 'package:xhs_app/generate/app_image_path.dart';

import '../../assets/styles.dart';
import '../../utils/color.dart';
import '../../utils/extension.dart';

///
/// 加载中
///

const _unestimateProgress = -1.0;

// !! 这里不使用依赖注入，直接传递
class BaseLoadingProgressController extends GetxController {
  BaseLoadingProgressController();

  final _progress = 0.0.obs;

  double get progress => _progress.value;

  void updateProgress(int current, int total) {
    if (total <= 0 || current < 0) {
      _progress.value = _unestimateProgress;
      return;
    }
    double newProgress = current / total;
    if (newProgress > 1) newProgress = 1.0;
    _progress.value = newProgress;
  }
}

class BaseLoadingWidget extends StatelessWidget {
  final Color? indicatorColor;
  final String? tips;
  final TextStyle? tipsStyle;
  final BaseLoadingProgressController? progressController;

  const BaseLoadingWidget({
    super.key,
    this.tips,
    this.tipsStyle,
    this.indicatorColor,
    this.progressController,
  });

  Widget _buildIndicator() {
    const bgColor = COLOR.black;
    if (progressController == null) {
      return const SizedBox(
        child: ImageView(
          src: AppImagePath.player_loading,
          width: 60,
          height: 60,
        ),
      );
    }
    return Obx(
      () => CircularProgressIndicator(
        backgroundColor: bgColor,
        color: COLOR.loading,
        value: progressController!.progress >= 0
            ? progressController!.progress
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildIndicator(),
          if (tips != null)
            Text(
              tips!,
              style: tipsStyle ??
                  TextStyle(
                    color: COLOR.loading,
                    fontSize: Styles.fontSize.s,
                  ),
            ).marginTop(5.h),
        ],
      ),
    );
  }
}
