import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xhs_app/utils/color.dart';

import '../../assets/styles.dart';

class NoNetWorkPage extends StatelessWidget {
  const NoNetWorkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.wifi_off,
              color: Colors.grey,
              size: 40.w,
            ),
            SizedBox(height: 10.w),
            const Text(
              '断网了!!!\n'
              '请确认您的网络是否正常',
              textAlign: TextAlign.center,
              style: TextStyle(color: COLOR.color_9B9B9B),
            ),
          ],
        ),
      ),
    );
  }
}
