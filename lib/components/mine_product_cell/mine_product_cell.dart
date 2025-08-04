/*
 * @Author: david wumingshi555888@gmail.com
 * @Date: 2025-02-27 20:57:37
 * @LastEditors: david wumingshi555888@gmail.com
 * @LastEditTime: 2025-03-01 13:49:40
 * @FilePath: /xhs_app/lib/components/mine_product_cell/mine_product_cell.dart
 * @Description: 
 * Copyright (c) 2025 by ${git_name} email: ${git_email}, All Rights Reserved.
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/assets/colorx.dart';
import 'package:xhs_app/model/product/product_model.dart';
import 'package:xhs_app/routes/routes.dart';
import 'package:xhs_app/utils/extension.dart';
import '../image_view.dart';

///商品组件
class MineProductCell extends StatelessWidget {
  final ProductModel item;
  const MineProductCell({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ImageView(
            src: item.coverImg ?? "",
            width: 173.w,
            height: 230.w,
            fit: BoxFit.cover,
            borderRadius: BorderRadius.circular(2)),
        SizedBox(
          height: 4.w,
        ),
        Text(
          item.productTitle ?? "",
          style: TextStyle(
              fontSize: 13.w,
              color: ColorX.color_333333,
              fontWeight: FontWeight.w500),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        Text.rich(
          TextSpan(children: [
            TextSpan(
                text: "金币 ",
                style: TextStyle(fontSize: 10.w, color: ColorX.color_fb2d45)),
            TextSpan(
                text: "${item.price ?? 0}",
                style: TextStyle(
                    fontSize: 15.w,
                    color: ColorX.color_fb2d45,
                    fontWeight: FontWeight.w500)),
            TextSpan(
                text: " ${item.buyNum ?? 0}人已买",
                style: TextStyle(fontSize: 10.w, color: ColorX.color_666666)),
          ]),
        ),
        Spacer(),
      ],
    ).onOpaqueTap(() {
      Get.toNakedChatDetail(id: item.productId ?? 0);
    });
  }
}
