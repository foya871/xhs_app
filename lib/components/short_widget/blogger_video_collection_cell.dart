/*
 * @Author: ziqi jhzq12345678
 * @Date: 2024-10-18 09:56:39
 * @LastEditors: ziqi jhzq12345678
 * @LastEditTime: 2024-10-22 09:50:08
 * @FilePath: /xhs_app/lib/src/components/short_widget/blogger_video_collection_cell.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/components/image_view.dart';
import 'package:xhs_app/utils/color.dart';
import 'package:xhs_app/views/video_collect/video_clollect.dart';

import '../../assets/styles.dart';
import '../../model/blogger/blogger_video_collection.dart';
import '../easy_button.dart';
import '../../utils/extension.dart';

enum _Type { tag, station }

class BloggerVideoCollectionCell extends StatelessWidget {
  final BloggerVideoCollectionModel model;
  final _Type _type;

  const BloggerVideoCollectionCell.tag(this.model, {super.key})
      : _type = _Type.tag;
  const BloggerVideoCollectionCell.station(this.model, {super.key})
      : _type = _Type.station;

  void jumpToDetail() {
    Navigator.push(
      Get.context!,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return VideoClollect(
            collectionId: model.collectionId,
            collectionName: model.collectionName,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_type == _Type.tag) {
      return EasyButton(
        model.collectionName,
        backgroundColor: COLOR.black,
        textStyle: TextStyle(
          overflow: TextOverflow.ellipsis,
          color: COLOR.color_666666,
          fontSize: Styles.fontSize.sm,
        ),
        width: 87.w,
        height: 32.w,
        borderRadius: Styles.borderRadius.xs,
        padding: EdgeInsets.symmetric(horizontal: 6.w),
        onTap: jumpToDetail,
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageView(
            src: model.coverImg,
            width: 136.w,
            height: 72.w,
            borderRadius: Styles.borderRadius.m,
          ),
          SizedBox(height: 10.w),
          Text(
            model.collectionName,
            style: TextStyle(fontSize: Styles.fontSize.s),
          )
        ],
      ).onTap(jumpToDetail);
    }
  }
}
