/*
 * @Author: david wumingshi555888@gmail.com
 * @Date: 2025-02-20 23:07:21
 * @LastEditors: david wumingshi555888@gmail.com
 * @LastEditTime: 2025-03-02 16:19:20
 * @FilePath: /xhs_app/lib/components/adult_game_cell/adult_game_cell.dart
 * @Description: 
 * Copyright (c) 2025 by ${git_name} email: ${git_email}, All Rights Reserved.
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/assets/colorx.dart';
import 'package:xhs_app/assets/styles.dart';
import 'package:xhs_app/components/image_view.dart';
import 'package:xhs_app/model/adult_game_model/adult_game_model.dart';
import 'package:xhs_app/model/axis_cover.dart';
import 'package:xhs_app/routes/routes.dart';

class AdultGameCell extends StatelessWidget {
  const AdultGameCell({super.key, required this.game});

  final AdultGameModel game;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (game.gameId != null) {
          Get.toGameDetail(game.gameId!);
        }
      },
      behavior: HitTestBehavior.opaque,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageView(
            src: "${game.coverPicture}",
            width: double.infinity,
            height: 90.w,
            fit: BoxFit.cover,
            borderRadius: Styles.borderRaidus.xs,
            axis: CoverImgAxis.horizontal,
          ),
          SizedBox(
            height: 6.w,
          ),
          Text(
            game.gameName ?? "",
            style: TextStyle(
              fontSize: 13.w,
              color: ColorX.color_333333,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
