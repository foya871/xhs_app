/*
 * @Author: wangdazhuang
 * @Date: 2025-02-22 09:14:40
 * @LastEditTime: 2025-03-04 09:09:51
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /xhs_app/lib/views/player/views/av_player_loading.dart
 */
import 'package:flutter/material.dart';
import 'package:xhs_app/generate/app_image_path.dart';

class AvPlayerLoading extends StatelessWidget {
  const AvPlayerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        color: Colors.transparent,
        child: Image.asset(
          AppImagePath.player_loading,
          width: 90,
          height: 90,
        ),
      ),
    );
  }
}
