import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xhs_app/components/ad/ad_enum.dart';
import 'package:xhs_app/components/ad/ad_info_model.dart';
import 'package:xhs_app/components/ad/ad_utils.dart';
import 'assets/styles.dart';
import 'components/easy_button.dart';
import 'components/easy_toast.dart';
import 'components/image_view.dart';
import 'components/safe_state.dart';
import 'env/environment_service.dart';
import 'generate/app_image_path.dart';
import 'routes/routes.dart';
import 'services/app_service.dart';
import 'services/storage_service.dart';
import 'utils/ad_jump.dart';
import 'utils/extension.dart';

class LuanchAdWidget extends StatefulWidget {
  const LuanchAdWidget({super.key});

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends SafeState<LuanchAdWidget> {
  late Timer _timer;
  int _currentTimer = 5;
  List<AdInfoModel> ads = [];

  @override
  void initState() {
    initService();
    super.initState();
  }

  void initService() async {
    final items = adHelper.getAdLoadInOrder(AdApiType.START);
    if (items.isNotEmpty) {
      // 创建一个新的列表，避免直接修改原始数据
      if (items.length > 3) {
        // 使用 Set 去重，确保不添加重复的 adId
        final uniqueAdIds = <String>{};
        var addedCount = 0;

        // 遍历 items，直到添加3个唯一广告或遍历完
        for (var item in items) {
          if (addedCount >= 3) break; // 已添加3个，退出循环
          final ad = adHelper.getAdInfo(AdApiType.START);
          if (ad != null && !uniqueAdIds.contains(ad.adId)) {
            ads.add(ad);
            uniqueAdIds.add(ad.adId);
            addedCount++;
          }
        }

        // 如果添加的广告不足3个，继续从 items 中补充唯一广告
        if (addedCount < 3) {
          for (var item in items) {
            if (addedCount >= 3) break;
            final ad = adHelper.getAdInfo(AdApiType.START);
            if (ad != null && !uniqueAdIds.contains(ad.adId)) {
              ads.add(ad);
              uniqueAdIds.add(ad.adId);
              addedCount++;
            }
          }
        }
      } else {
        ads = items;
      }
    }
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (_currentTimer == 0) return;
        setState(() {
          if (_currentTimer > 0) {
            _currentTimer -= 1;
          }
        });
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Widget _buildAds() {
    if (ads.isEmpty) {
      return Positioned.fill(
        child: Image.asset(
          AppImagePath.icon_bg_splash,
          width: Get.width,
          height: Get.height,
          fit: BoxFit.fill,
        ),
      );
    }
    var itemH = Get.height;
    final adLength = ads.length;
    if (adLength > 1) itemH = (Get.height - 5.w * (adLength - 1)) / adLength;
    final placeHolder = adLength == 1
        ? AppImagePath.icon_bg_splash
        : AppImagePath.icon_placeholder;
    return Positioned.fill(
        child: Column(
      children: ads
          .mapIndexed(
            (index, e) => ImageView(
              width: Get.width,
              height: itemH,
              src: ads[index].adImage ?? '',
              fit: BoxFit.fill,
              defaultPlace: placeHolder,
            )
                .onTap(() => kAdjump(ads[index]))
                .marginBottom(index == adLength - 1 ? 0 : 5.w),
          )
          .toList(),
    ));
  }

  void _tapJumpAction() async {
    if (_currentTimer == 0) {
      final app = Get.find<AppService>();

      final networkInitCompleter = app.networkInitCompleter;
      if (networkInitCompleter.isCompleted) {
        final err = await networkInitCompleter.future;
        if (err != null) {
          EasyToast.show("初始化失败,请退出重试!");
          return;
        }
      } else {
        // 如果请求还未结束，转个圈圈?
        EasyToast.show("初始化中，请稍候.");
        return;
      }

      final hasToken = Get.find<StorageService>().token?.isNotEmpty;
      if (GetPlatform.isWeb) {
        if (hasToken == false) {
          EasyToast.show("初始化失败,请退出重试!");
          return;
        }
      } else {
        if (hasToken == false || Environment.androidiOSAPI.isEmpty) {
          EasyToast.show("初始化失败,请退出重试!");
          return;
        }
      }
      if (app.showChooseClassifys) {
        Get.offNamed(Routes.launchChooseClassify);
        return;
      }
      Get.offHome();
    }
  }

  Widget _buildBtn() {
    final fail = !GetPlatform.isWeb && Environment.androidiOSAPI.isEmpty;
    if (fail) return const SizedBox.shrink();
    final txt = _currentTimer > 0 ? '$_currentTimer' : '跳过';
    return Positioned(
      right: 15.w,
      top: kIsWeb ? 25.w : 60.w,
      child: EasyButton(
        txt,
        textStyle: kTextStyle(
          Colors.white,
          fontsize: 16.w,
          weight: FontWeight.bold,
        ),
        width: 90.w,
        height: 35.w,
        borderRadius: BorderRadius.circular(17.5.w),
        backgroundColor: const Color.fromRGBO(0, 0, 0, 0.7),
        onTap: _tapJumpAction,
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SizedBox.expand(
          child: Stack(
            children: [
              _buildAds(),
              _buildBtn(),
            ],
          ),
        ),
      );
}
