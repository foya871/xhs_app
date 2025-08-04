import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoMore extends StatelessWidget {
  const NoMore({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        width: 340.w,
        padding: EdgeInsets.symmetric(vertical: 10.w),
        child: Text(
          '没有更多了',
          style: TextStyle(color: Colors.white, fontSize: 14.w),
        ));
  }
}
