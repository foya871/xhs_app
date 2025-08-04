import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../assets/styles.dart';
import '../../../../components/image_view.dart';
import '../../../../components/popup/dialog/future_loading_dialog.dart';
import '../../../../components/popups/buy_fail_dialog.dart';
import '../../../../components/popups/confirm_buy_bottom_sheet.dart';
import '../../../../http/api/api.dart';
import '../../../../model/community/community_push_message_model.dart';
import '../../../../model/video/product_detail_model.dart';
import '../../../../repositories/adult_game.dart';
import '../../../../routes/routes.dart';
import '../../../../services/user_service.dart';
import '../../../../utils/color.dart';
import '../../../../utils/dialog_utils.dart';
import '../../../../utils/logger.dart';
import '../../../../utils/utils.dart';
import '../../../adult_game/detail/controller.dart';
import '../../../selection/resource_detail/resource_detail_logic.dart';
import 'community_topic_cell.dart';

abstract class CommunityUtils {
  static Widget buildTitle(String title) => Text(
        title,
        style: TextStyle(fontSize: 13.w, fontWeight: FontWeight.w500),
      );

  static Widget buildContentText(String contentText) => Text(
        contentText,
        style: TextStyle(fontSize: 14.w),
      );

  static Widget buildTopic(List<String> topic) => Wrap(
        spacing: 9.w,
        runSpacing: 10.w,
        children: topic.map((e) => CommunityTopicCell(e)).toList(),
      );

  static Widget buildCheckAt(String checkAt) => Text(
        Utils.dateFmt(checkAt, ['mm', '-', 'dd']),
        style: TextStyle(color: COLOR.color_999999, fontSize: 11.w),
      );

  static Future<bool> goldBuy(int dynamicId) async {
    final future = Api.buyCommunity(dynamicId);
    return await FutureLoadingDialog(future, tips: '购买中..').showUnsafe();
  }

  static Future<void> goldBuyResource(int resourcesId,
      {bool refreshDetailPage = true}) async {
    final future = Api.buyResourceUnlock(resourcesId);
    final ok = await FutureLoadingDialog(future, tips: '购买中..').showUnsafe();
    if (!ok) return;

    // 刷新详情页
    if (refreshDetailPage &&
        Get.isRegistered<ResourceDetailLogic>(tag: "$resourcesId")) {
      Get.find<ResourceDetailLogic>(tag: "$resourcesId").loadData();
    }
  }

  ///成人游戏购买
  static Future<void> goldBuyAdultGame(int gameId,
      {bool refreshDetailPage = true}) async {
    final future = AdultGamesRepositoryImpl().fetchAdultGameBuy(gameId);
    final ok = await FutureLoadingDialog(future, tips: '购买中..').showUnsafe();
    if (ok == null) return;

    // 刷新详情页
    if (refreshDetailPage && Get.isRegistered<AdultGameDetailController>()) {
      Get.find<AdultGameDetailController>().initGame();
    }
  }

  static Future<void> tryGoldBuy(int dynamicId,
      {required double price, VoidCallback? onBuySuccess}) async {
    if (Get.find<UserService>().checkGold(price)) {
      ConfirmBuyBottomSheet(
        price,
        onTapConfirm: () async {
          final ok = await goldBuy(dynamicId);
          if (ok) onBuySuccess?.call();
        },
      ).show();
    } else {
      BuyFailDialog().show();
    }
  }

  static Future<void> tryGoldBuyResource(int dynamicId,
      {bool refreshDetailPage = true, required double price}) async {
    if (Get.find<UserService>().checkGold(price)) {
      ConfirmBuyBottomSheet(
        price,
        onTapConfirm: () => goldBuyResource(dynamicId),
      ).show();
    } else {
      BuyFailDialog().show();
    }
  }

  static Future<void> tryGoldBuyAdultGame(int gameId,
      {bool refreshDetailPage = true, required double price}) async {
    if (Get.find<UserService>().checkGold(price)) {
      ConfirmBuyBottomSheet(
        price,
        onTapConfirm: () => goldBuyAdultGame(gameId),
      ).show();
    } else {
      BuyFailDialog().show();
    }
  }

  static Future<void> tryGoldBuyNakedChat(ProductDetailModel model) async {
    if (Get.find<UserService>().checkGold(model.price ?? 0)) {
      var result = await DialogUtils.showProductPaySheet(Get.context!, model);
    } else {
      BuyFailDialog().show();
    }
  }

  static showPushSnackbar(CommunityPushMessageModel model) => Get.snackbar(
        "",
        "",
        padding: EdgeInsets.symmetric(vertical: 5.w, horizontal: 14.w),
        duration: const Duration(seconds: 5),
        titleText: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                model.title,
                maxLines: 2,
                style: TextStyle(color: COLOR.color_333333, fontSize: 13.w),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            23.horizontalSpace,
            ImageView(
              src: model.cover,
              width: 48.w,
              height: 48.w,
              borderRadius: Styles.borderRadius.all(4.w),
            ),
          ],
        ),
        messageText: const SizedBox.shrink(),
        onTap: (snack) => Get.toCommunityDetailById(model.dynamicId),
      );
}
