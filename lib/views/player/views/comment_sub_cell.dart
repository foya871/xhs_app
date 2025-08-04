/*
 * @Author: wangdazhuang
 * @Date: 2024-08-29 09:05:46
 * @LastEditTime: 2024-10-12 09:12:57
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /xhs_app/lib/src/views/player/views/comment_sub_cell.dart
 */
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xhs_app/assets/styles.dart';
import 'package:xhs_app/components/circle_image.dart';
import 'package:xhs_app/generate/app_image_path.dart';
import 'package:xhs_app/model/comment/comment_model.dart';
import 'package:xhs_app/utils/color.dart';
import 'package:xhs_app/utils/extension.dart';
import 'package:xhs_app/utils/utils.dart';
import 'package:flutter/material.dart';

class CommentSubCell extends StatefulWidget {
  final CommentModel model;
  final void Function(CommentModel) tap;
  final void Function(CommentModel) likeTap;

  const CommentSubCell(
      {super.key,
      required this.model,
      required this.tap,
      required this.likeTap});

  @override
  State<StatefulWidget> createState() {
    return CommentSubCellState();
  }
}

class CommentSubCellState extends State<CommentSubCell> {
  _buildLogo() {
    return CircleImage.network(
      widget.model.logo,
      size: 25.w,
    );
  }

  _buildLikeAndReply() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          widget.model.isLike
              ? AppImagePath.player_like_y
              : AppImagePath.player_like,
          width: 18.w,
          height: 18.w,
        ).onOpaqueTap(() {
          widget.likeTap(widget.model);
        }),
        SizedBox(width: 8.w),
        Text(Utils.numFmt(widget.model.fakeLikes),
            style: kTextStyle(COLOR.hexColor("#999"), fontsize: 12.w)),
        Text('回复', style: kTextStyle(COLOR.hexColor("#999"), fontsize: 12.w))
            .marginLeft(20.w)
            .onOpaqueTap(() {
          widget.tap(widget.model);
        }),
      ],
    ).marginTop(15.w);
  }

  _buildRight() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                    text: widget.model.nickName,
                    style: kTextStyle(COLOR.hexColor("#999"), fontsize: 12.w)),
                WidgetSpan(child: SizedBox(width: 5.w)),
                TextSpan(
                  text:
                      Utils.dateFmt(widget.model.createdAt, ['mm', '-', 'dd']),
                  style: kTextStyle(COLOR.hexColor("#999"), fontsize: 11.w),
                ),
              ],
            ),
          ),
          Text(widget.model.content,
                  style: kTextStyle(COLOR.hexColor("#333"), fontsize: 12.w))
              .marginTop(5.w),
          _buildLikeAndReply(),
        ],
      ).marginLeft(10.w),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLogo(),
        _buildRight(),
      ],
    ).onTap(() {
      widget.tap(widget.model);
    }).marginBottom(13.w);
  }
}
