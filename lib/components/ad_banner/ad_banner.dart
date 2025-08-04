/*
 * @Author: ziqi jhzq12345678
 * @Date: 2024-08-16 19:18:58
 * @LastEditors: ziqi jhzq12345678
 * @LastEditTime: 2025-01-24 19:53:06
 * @FilePath: /xhs_app/lib/src/components/ad_banner.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:carousel_slider/carousel_slider.dart';
import 'package:xhs_app/components/ad/ad_enum.dart';
import 'package:xhs_app/components/ad/ad_utils.dart';
import 'package:xhs_app/components/image_view.dart';
import 'package:xhs_app/utils/ad_jump.dart';
import 'package:xhs_app/utils/color.dart';
import 'package:xhs_app/utils/enum.dart';
import 'package:xhs_app/utils/initAdvertisementInfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../assets/styles.dart';

class AdBanner extends StatelessWidget {
  final AdApiType adress;
  final double? height;
  final EdgeInsets? margin;
  const AdBanner(
      {super.key, required this.adress, this.height = 186, this.margin});

  const AdBanner.index({super.key, this.height = 186, this.margin})
      : adress = AdApiType.TOP_BANNER;

  @override
  Widget build(BuildContext context) {
    final ads = adHelper.getAdLoadInOrder(adress);
    ValueNotifier<int> idx = ValueNotifier(0);
    return ads.isNotEmpty
        ? Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                decoration: BoxDecoration(borderRadius: Styles.borderRadius.m),
                margin: margin,
                clipBehavior: Clip.hardEdge,
                child: CarouselSlider.builder(
                  itemCount: ads.length,
                  itemBuilder: (context, index, pageViewIndex) {
                    return SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: GestureDetector(
                        onTap: () {
                          kAdjump(ads[index]);
                        },
                        child: ImageView(
                          src: ads[index].adImage ?? '',
                          fit: BoxFit.fill,
                        ),
                      ),
                    );
                  },
                  options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    viewportFraction: 1,
                    aspectRatio: (372 / (height ?? 186)),
                    onPageChanged: (index, reason) {
                      idx.value = index;
                    },
                  ),
                ),
              ),
              Positioned(
                bottom: margin != null ? 24.w : 10.w,
                right: 8.w,
                child: ValueListenableBuilder<int>(
                    valueListenable: idx,
                    builder: (context, value, child) {
                      return Container(
                          alignment: Alignment.center,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                  ads.length,
                                  (index) => Container(
                                        margin: EdgeInsets.only(right: 4.w),
                                        decoration: BoxDecoration(
                                          color: idx.value == index
                                              ? COLOR.hexColor('#9C78F2')
                                              : const Color.fromRGBO(
                                                  255, 255, 255, 0.2),
                                        ),
                                        width: 20.w,
                                        height: 2.w,
                                      ))));
                    }),
              )
            ],
          )
        : const SizedBox.shrink();
  }
}
