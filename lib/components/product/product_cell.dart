import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xhs_app/assets/colorx.dart';
import 'package:xhs_app/components/ad_banner/insert_ad.dart';

import '../../model/axis_cover.dart';
import '../../model/video/product_detail_model.dart';
import '../image_view.dart';

///商品组件
class ProductCell extends StatelessWidget {
  final ProductDetailModel item;
  final Function()? onTap;
  const ProductCell({super.key, required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    if (item.isAd) {
      return InsertAd(
        adress: item.ad!,
        height: 200.w,
        showMark: false,
        showName: true,
      );
    }
    return GestureDetector(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageView(
              src: item.coverImg ?? "",
              width: double.infinity,
              height: 200.w,
              fit: BoxFit.cover,
              // borderRadius: Styles.borderRaidus.m,
              axis: CoverImgAxis.horizontal,
            ),
            SizedBox(
              height: 3.h,
            ),
            Text(
              item.title ?? "",
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
                    style:
                        TextStyle(fontSize: 10.w, color: ColorX.color_fb2d45)),
                TextSpan(
                    text: "${item.price ?? 0}",
                    style: TextStyle(
                        fontSize: 15.w,
                        color: ColorX.color_fb2d45,
                        fontWeight: FontWeight.w500)),
                TextSpan(
                    text: " ${item.buyNum ?? 0}人已买",
                    style:
                        TextStyle(fontSize: 10.w, color: ColorX.color_666666)),
              ]),
            ),
            const Spacer(),
          ],
        ));
  }
}
