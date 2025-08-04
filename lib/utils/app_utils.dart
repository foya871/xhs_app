import 'package:flutter/services.dart';
import 'package:xhs_app/components/diolog/dialog.dart';

import '../generate/app_image_path.dart';

abstract class AppUtils {
  ///复制到粘贴板
  static Future<bool> copyToClipboard(String content) async {
    try {
      if (content.isNotEmpty) {
        await Clipboard.setData(ClipboardData(text: content));
        showToast("复制成功");
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  ///获取粘贴板的内容
  static Future<String> paste() async {
    var clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
    return clipboardData?.text ?? '';
  }

  static String getVipTypeToImagePath(int vipType) {
    String imagePath = '';
    if (vipType == 3) {
      imagePath = AppImagePath.mine_mine_vip_week;
    } else if (vipType == 5) {
      imagePath = AppImagePath.mine_mine_vip_month;
    } else if (vipType == 6 || vipType == 8) {
      imagePath = AppImagePath.mine_mine_vip_gold;
    } else if (vipType == 7) {
      imagePath = AppImagePath.mine_mine_vip_year;
    } else if (vipType == 9) {
      imagePath = AppImagePath.mine_mine_vip_perpetual;
    } else if (vipType == 10 || vipType == 11) {
      imagePath = AppImagePath.mine_mine_vip_11;
    } else if (vipType == 12 || vipType == 13) {
      imagePath = AppImagePath.mine_mine_vip_chat;
    }
    return imagePath;
  }

  static String getVipTypeToVipName(int vipType) {
    String vipName = '';
    if (vipType == 3) {
      vipName = "周卡会员";
    } else if (vipType == 5) {
      vipName = "月卡会员";
    } else if (vipType == 6 || vipType == 8) {
      vipName = "金币会员";
    } else if (vipType == 7) {
      vipName = "年卡会员";
    } else if (vipType == 9) {
      vipName = "永久会员";
    } else if (vipType == 10 || vipType == 11) {
      vipName = "禁区会员";
    } else if (vipType == 12 || vipType == 13) {
      vipName = "私聊会员";
    }
    return vipName;
  }
}
