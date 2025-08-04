/*
 * @Author: ziqi jhzq12345678
 * @Date: 2024-08-22 15:30:38
 * @LastEditors: ziqi jhzq12345678
 * @LastEditTime: 2024-08-30 14:28:32
 * @FilePath: /xhs_app/lib/src/components/star_cell/star_cell.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:xhs_app/components/image_view.dart';
import 'package:xhs_app/components/star_cell/attention.dart';
import 'package:xhs_app/model/blogger/blogger_models.dart';
import 'package:xhs_app/routes/routes.dart';
import 'package:xhs_app/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class StarCell extends StatelessWidget {
  final BloggerModel blogger;
  const StarCell({super.key, required this.blogger});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (blogger.userId == 0) {
          return;
        }
        Get.toBloggerDetail(userId: blogger.userId);
      },
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 54.w,
            height: 54.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28.w), color: Colors.white),
            clipBehavior: Clip.hardEdge,
            margin: EdgeInsets.only(right: 8.w),
            child: ImageView(src: blogger.logo),
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                blogger.nickName,
                style: TextStyle(color: Colors.white, fontSize: 13.w),
              ),
              Offstage(
                offstage: blogger.area.isEmpty,
                child: Text(
                  blogger.area,
                  style: TextStyle(
                    fontSize: 11.w,
                    color: COLOR.hexColor('#999'),
                  ),
                ),
              ),
              Text(
                '粉丝: ${blogger.bu}  视频: ${blogger.workNum}  播放: ${blogger.playNum}',
                style: TextStyle(color: COLOR.hexColor('#999'), fontSize: 11.w),
              )
            ],
          )),
          Attention(
            userId: blogger.userId,
            isAttention: blogger.isAttention,
          )
        ],
      ),
    );
  }
}
