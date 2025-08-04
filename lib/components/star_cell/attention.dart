/*
 * @Author: ziqi jhzq12345678
 * @Date: 2024-08-21 21:44:54
 * @LastEditors: ziqi jhzq12345678
 * @LastEditTime: 2024-08-26 21:43:59
 * @FilePath: /xhs_app/lib/src/components/producer_cell/subscribe.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:xhs_app/http/api/api.dart';
import 'package:xhs_app/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Attention extends StatefulWidget {
  final int userId;
  final bool isAttention;
  const Attention({super.key, required this.isAttention, required this.userId});

  @override
  State<StatefulWidget> createState() => _Attention();
}

class _Attention extends State<Attention> {
  late bool atten;
  @override
  void initState() {
    atten = widget.isAttention;
    super.initState();
  }

  Future userAtten() async {
    final ok = await Api.toggleAttentionUser(widget.userId, attention: atten);
    if (!ok) return;
    if (!mounted) return;
    setState(() {
      atten = !atten;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize: Size(60.w, 28.w),
            padding: const EdgeInsets.symmetric(horizontal: 0),
            backgroundColor: COLOR.hexColor(atten ? '#ffffff' : '#eb29c6')),
        onPressed: () {
          userAtten();
        },
        child: Text(
          atten ? '已关注' : '关注',
          style: TextStyle(color: Colors.white, fontSize: 13.w),
        ));
  }
}
