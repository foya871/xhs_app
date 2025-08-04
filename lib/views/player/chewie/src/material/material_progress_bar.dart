/*
 * @Author: wangdazhuang
 * @Date: 2024-09-23 19:48:43
 * @LastEditTime: 2024-12-02 11:43:29
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /xhs_app/lib/src/chewie/src/material/material_progress_bar.dart
 */
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../chewie.dart';
import '../progress_bar.dart';

class MaterialVideoProgressBar extends StatelessWidget {
  MaterialVideoProgressBar(
    this.controller, {
    this.height = kToolbarHeight,
    this.barHeight = 10,
    this.handleHeight = 6,
    ChewieProgressColors? colors,
    this.onDragEnd,
    this.onDragStart,
    this.onDragUpdate,
    super.key,
    this.draggableProgressBar = true,
  }) : colors = colors ?? ChewieProgressColors();

  final double height;
  final double barHeight;
  final double handleHeight;
  final VideoPlayerController controller;
  final ChewieProgressColors colors;
  final Function()? onDragStart;
  final Function()? onDragEnd;
  final Function()? onDragUpdate;
  final bool draggableProgressBar;

  @override
  Widget build(BuildContext context) {
    return VideoProgressBar(
      controller,
      barHeight: barHeight,
      handleHeight: handleHeight,
      drawShadow: true,
      colors: colors,
      onDragEnd: onDragEnd,
      onDragStart: onDragStart,
      onDragUpdate: onDragUpdate,
      draggableProgressBar: draggableProgressBar,
    );
  }
}
