import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:xhs_app/components/common_permission_alert.dart';
import 'package:xhs_app/model/adult_game_detail_model/adult_game_detail_model.dart';
import 'package:xhs_app/repositories/adult_game.dart';
import 'package:xhs_app/routes/routes.dart';
import 'package:xhs_app/services/user_service.dart';
import 'package:xhs_app/utils/logger.dart';

class AdultGameDetailController extends GetxController {
  int? _gameId;

  var game = AdultGameDetailModel().obs;

  void initGame() async {
    if (_gameId == null) {
      return;
    }
    AdultGamesRepositoryImpl().fetchAdultGameDetail(_gameId!).then((resp){
      game.value = resp;
    });
  }

  bool _favIng = false;

  void fav() async {
    if (_favIng || game.value.gameId == null) {
      return;
    }

    _favIng = true;
    String msg = game.value.isFavorite == true ? '取消收藏游戏' : '收藏游戏';
    SmartDialog.showLoading(
      msg: '$msg...',
      clickMaskDismiss: false,
      usePenetrate: false,
      displayTime: null,
    );

    await AdultGamesRepositoryImpl()
        .fetchAdultGameFavorite(game.value.gameId!, game.value.isFavorite! ? 0 : 1);
    SmartDialog.dismiss();
    _favIng = false;
    initGame();
  }

  bool _buyGameIng = false;

  void buyGame() async {
    // try {
    //   await Get.find<UserService>().updateAPIAssetsInfo();
    // } catch (e) {
    //   return;
    // }

    if (_buyGameIng || game.value.gameId == null) {
      return;
    }

    final userAssetsGold = Get.find<UserService>().assets.gold ?? 0;
    final adultGameFreeNum = Get.find<UserService>().user.adultGameFreeNum ?? 0;

    if (adultGameFreeNum <= 0 || userAssetsGold < game.value.priceGold!) {
      permission_alert(Get.context!, desc: "余额不足,请前往充值", oktitle: "去充值",
          okAction: () {
        Get.toNamed(Routes.recharge);
      });
      return;
    }

    _buyGameIng = true;

    SmartDialog.showLoading(
      msg: '购买游戏...',
      clickMaskDismiss: false,
      usePenetrate: false,
      displayTime: null,
    );

    try {
      await AdultGamesRepositoryImpl().fetchAdultGameBuy(game.value.gameId!);
      // Get.find<UserService>().updateAPIAssetsInfo();
      initGame();
      SmartDialog.dismiss();
      SmartDialog.showToast('购买成功点击下方按钮下载', alignment: Alignment.center);
      _buyGameIng = false;
      Get.find<UserService>().updateAll();
    } catch (e) {
      SmartDialog.dismiss();
      SmartDialog.showToast('购买失败', alignment: Alignment.center);
      _buyGameIng = false;
    }
  }

  bool _buyGameCodeIng = false;

  void buyGameCode() async {
    if (_buyGameCodeIng || game.value.gameId == null) {
      return;
    }

    // final userAssetsGold = Get.find<UserService>().assets.gold ?? 0;

    // if (userAssetsGold < game.cheatNumPrice!) {
    //   permission_alert(Get.context!, desc: "余额不足,请前往充值", oktitle: "去充值",
    //       okAction: () {
    //     Get.toNamed(Routes.recharge);
    //   });

    //   return;
    // }

    _buyGameCodeIng = true;

    SmartDialog.showLoading(
      msg: '购买作弊码...',
      clickMaskDismiss: false,
      usePenetrate: false,
      displayTime: null,
    );

    try {
      await AdultGamesRepositoryImpl().fetchAdultGameCheatNumBuy(game.value.gameId!);
      Get.find<UserService>().updateAPIAssetsInfo();
      initGame();
      SmartDialog.dismiss();
      SmartDialog.showToast('购买成功点击下方按钮复制', alignment: Alignment.center);
      _buyGameCodeIng = false;
    } catch (e) {
      SmartDialog.dismiss();
      SmartDialog.showToast('购买失败', alignment: Alignment.center);
      _buyGameCodeIng = false;
    }
  }

  @override
  void onInit() {
    _gameId = int.tryParse(Get.parameters['id'] ?? '');
    initGame();
    super.onInit();
  }
}
