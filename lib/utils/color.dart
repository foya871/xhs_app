// ignore_for_file: constant_identifier_names, non_constant_identifier_names

/*
 * @Author: wangdazhuang
 * @Date: 2024-07-16 14:09:53
 * @LastEditTime: 2025-03-03 15:16:33
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /xhs_app/lib/utils/color.dart
 */
import 'dart:math';
// import 'dart:ui';

import 'package:flutter/material.dart';

class COLOR {
  COLOR._();

  /// 4位 COLOR.hexColor("#999")
  /// 7位 COLOR.hexCOlor('#2e233e')
  static Color hexColor(String hexString) {
    final buffer = StringBuffer();
    //#fff
    bool isFour = hexString.length == 4;
    if (hexString.length == 6 || hexString.length == 7 || isFour) {
      buffer.write('ff');
    }
    buffer.write(hexString.replaceFirst('#', ''));
    if (isFour) {
      buffer.write(hexString.substring(1));
    }
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  ///随机颜色
  static Color randomColor() {
    return Color.fromRGBO(Random().nextInt(256), Random().nextInt(256),
        Random().nextInt(256), 1.0);
  }

  static Color themColor = hexColor("#121212");
  static const playerThemeColor = color_FB2D45;
  static const primaryText = color_333333;
  static const backButton = Colors.black;
  static const scaffoldBg = color_FAFAFA;
  static const loading = color_FB2D45;
  static const easyRefresh = color_333333;
  static const videoSeekBar = color_FB2D45;
  static const aiPrimary = color_FB2D45;

  static const white = Colors.white;
  static const black = Colors.black;
  static const transparent = Colors.transparent;
  static const color_D8201D = Color(0xffD8201D);
  static const color_333333 = Color(0xff333333);
  static const color_666666 = Color(0xff666666);
  static const color_999999 = Color(0xff999999);
  static const color_F5F5F5 = Color(0xffF5F5F5);
  static const color_F9F9F9 = Color(0xffF9F9F9);
  static const color_DD001B = Color(0xffDD001B);
  static const color_F0F0F0 = Color(0xffF0F0F0);
  static const color_48382C = Color(0xff48382C);
  static const color_FAF5DF = Color(0xffFAF5DF);
  static const color_F52443 = Color(0xffF52443);
  static const color_D7D8D9 = Color(0xffD7D8D9);
  static const color_FFE5E5 = Color(0xffFFE5E5);
  static const color_FF4340 = Color(0xffFF4340);
  static const color_A4A4B2 = Color(0xffA4A4B2);
  static const color_EFEFEF = Color(0xffEFEFEF);
  static const color_FFDAD9 = Color(0xffFFDAD9);
  static const color_FF0000 = Color(0xffFF0000);
  static const color_FFB5B5 = Color(0xffFFB5B5);
  static const color_D5D5D5 = Color(0xffD5D5D5);
  static const color_DC143C = Color(0xffDC143C);
  static const color_F40302 = Color(0xffF40302);
  static const color_4490F8 = Color(0xff4490F8);
  static const color_F3F4F5 = Color(0xffF3F4F5);
  static const color_1D1D1D = Color(0xff1D1D1D);
  static const color_111 = Color(0xff111111);
  static const color_423765 = Color(0xff423765);

  static const color_898A8E = Color(0xff898A8E);
  static const color_B940FF = Color(0xffB940FF);
  static const color_B93FFF = Color(0xffB93FFF);
  static const color_9B9B9B = Color(0xff9B9B9B);
  static const color_E5E5E5 = Color(0xffE5E5E5);
  static const color_F6C246 = Color(0xffF6C246);
  static const color_B5B5B5 = Color(0xffB5B5B5);
  static const color_FABD95 = Color(0xffFABD95);
  static const color_14151D = Color(0xff14151D);
  static const color_F0D94C = Color(0xffF0D94C);
  static const color_DDDDDD = Color(0xffDDDDDD);
  static const color_8D9198 = Color(0xff8D9198);
  static const color_DB3056 = Color(0xffDB3056);
  static const color_B65E04 = Color(0xffB65E04);
  static const color_BA226E = Color(0xffBA226E);
  static const color_FABC8A = Color(0xffFABC8A);
  static const color_EBEBEB = Color(0xffEBEBEB);
  static const color_8B8B98 = Color(0xff8B8B98);
  static const color_FFF1F2 = Color(0xffFFF1F2);
  static const color_F22F40 = Color(0xffF22F40);
  static const color_FEFEFE = Color(0xffFEFEFE);
  static const color_AFAFAF = Color(0xffAFAFAF);
  static const color_FE0303 = Color(0xffFE0303);
  static const color_AEAFB5 = Color(0xffAEAFB5);
  static const color_151515 = Color(0xff151515);
  static const color_808080 = Color(0xff808080);
  static const color_8F8F8F = Color(0xff8F8F8F);
  static const color_F8F8F8 = Color(0xffF8F8F8);
  static const color_E9EFFC = Color(0xffE9EFFC);
  static const color_E7E7E7 = Color(0xffE7E7E7);
  static const color_2D2D2D = Color(0xff2D2D2D);
  static const color_1F1F1F = Color(0xff1F1F1F);
  static const color_181818 = Color(0xff181818);
  static const color_CFCFCF = Color(0xffCFCFCF);
  static const color_2C2C2C = Color(0xff2C2C2C);
  static const color_FF5C5C = Color(0xffFF5C5C);
  static const color_393939 = Color(0xff393939);
  static const color_292A31 = Color(0xff292A31);
  static const color_2B2B2B = Color(0xff2B2B2B);
  static const color_959595 = Color(0xff959595);
  static const color_1B1B1B = Color(0xff1B1B1B);
  static const color_222222 = Color(0xff222222);
  static const color_9C9AA9 = Color(0xff9C9AA9);
  static const color_1E1E1E = Color(0xff1E1E1E);
  static const color_7FFCCD = Color(0xff7FFCCD);
  static const color_F2BF62 = Color(0xffF2BF62);
  static const color_292929 = Color(0xff292929);
  static const color_CD73FB = Color(0xffCD73FB);
  static const color_60262736 = Color(0x60262736);
  static const color_FEE041 = Color(0xffFEE041);
  static const color_EEEEEE = Color(0xffEEEEEE);
  static const color_FEF100 = Color(0xffFEF100);
  static const color_DBDBDB = Color(0xffDBDBDB);
  static const color_232323 = Color(0xff232323);
  static const color_B0B0B0 = Color(0xffB0B0B0);
  static const color_E77F36 = Color(0xffE77F36);
  static const color_343434 = Color(0xff343434);
  static const color_F43670 = Color(0xffF43670);
  static const color_D2D2D2 = Color(0xffD2D2D2);
  static const color_E9E9E9 = Color(0xffE9E9E9);
  static const color_FB2D45 = Color(0xffFB2D45);
  static const color_5193FB = Color(0xff5193FB);
  static const color_FAFAFA = Color(0xffFAFAFA);
  static const color_979797 = Color(0xff979797);
  static const color_828282 = Color(0xff828282);
  static const color_faa06a = Color(0xfffaa06a);
  static const color_494657 = Color(0xff494657);
  static const color_2b4465 = Color(0xff2b4465);
  static const color_191919 = Color(0xff191919);
  static const color_D73E3D = Color(0xffD73E3D);
  static const color_FFBE20 = Color(0xffFFBE20);
  static const color_BB602A = Color(0xffBB602A);
  static const color_7EA4D7 = Color(0xff7EA4D7);
  static const color_3B3B3B = Color(0xff3B3B3B);
  static const color_FF9000 = Color(0xffFF9000);
  static const color_212121 = Color(0xff212121);
  static const color_E6E6E6 = Color(0xffE6E6E6);
  static const color_0C0935 = Color(0xff0C0935);

  // 不透明度50%
  static const Color translucent_46 = Color(0x75000000);
  static const Color translucent_50 = Color(0x80000000);

  static const Color color_323232 = Color(0xff323232);
}
