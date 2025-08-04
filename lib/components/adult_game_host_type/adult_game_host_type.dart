import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdultGameHostTypeView extends StatelessWidget {
  AdultGameHostTypeView({super.key, required this.hostTypes});

  final List<int> hostTypes;

  final Map<int, String> _hostTypeNames = {
    0: 'Android/PC',
    1: 'Android',
    2: 'PC',
    3: 'iOS',
    4: "Android/iOS",
    5: "PC/iOS",
    6: "Android/iOS/PC"
  };

  String get allType =>
      hostTypes.map((type) => _hostTypeNames[type] ?? '').toList().join("/");

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 2.w),
      color: const Color(0xff9500f5),
      child: Text(
        allType,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          letterSpacing: 0.67,
        ),
      ),
    );
  }
}
