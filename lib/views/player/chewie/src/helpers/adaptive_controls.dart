/*
 * @Author: wangdazhuang
 * @Date: 2024-12-02 11:37:28
 * @LastEditTime: 2024-12-02 11:38:28
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /xhs_app/lib/src/chewie/src/helpers/adaptive_controls.dart
 */
import 'package:flutter/material.dart';

import '../../chewie.dart';

class AdaptiveControls extends StatelessWidget {
  const AdaptiveControls({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    switch (Theme.of(context).platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        return const MaterialControls();

      case TargetPlatform.macOS:
      case TargetPlatform.windows:
      case TargetPlatform.linux:
        return const MaterialDesktopControls();

      case TargetPlatform.iOS:
        return const CupertinoControls(
          backgroundColor: Color.fromRGBO(41, 41, 41, 0.7),
          iconColor: Color.fromARGB(255, 200, 200, 200),
        );
      default:
        return const MaterialControls();
    }
  }
}
