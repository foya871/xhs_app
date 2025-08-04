import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:xhs_app/components/ad/ad_enum.dart';
import 'package:xhs_app/components/ad/ad_info_model.dart';
import 'package:xhs_app/components/ad/ad_utils.dart';
import 'package:xhs_app/components/announcement/vertical_group_ads.dart';
import 'package:xhs_app/components/image_view.dart';
import 'package:xhs_app/http/service/api_service.dart';
import 'package:xhs_app/model/activity/activity_model.dart';
import 'package:xhs_app/model/announcement/announcement.dart';
import 'package:xhs_app/model/announcement/home_activity.dart';

import 'package:xhs_app/utils/ad_jump.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:xhs_app/utils/enum.dart';
import 'package:xhs_app/utils/extension.dart';
import 'package:xhs_app/utils/initAdvertisementInfo.dart';
import 'package:xhs_app/utils/logger.dart';
import '../../model/advertisements/app_update.dart';
import '../../services/app_service.dart';
import 'notice_box.dart';
import 'open_screen_ads.dart';
import 'version_update_box.dart';

Future<AppUpdateModel?> checkVersion() async {
  if (!kIsWeb) {
    try {
      final updates = await httpInstance.get<AppUpdateModel>(
          url: 'sys/version/update', complete: AppUpdateModel.fromJson);
      if (updates is AppUpdateModel && updates.hasNewVersion == true) {
        return updates;
      }
      return null;
    } catch (e) {
      return null;
    }
  }
  return null;
}

void showAllEntranceAds() async {
  ValueNotifier<int> acitveIdx = ValueNotifier(0);
  List<Widget> toastList = [];

  ///下一个或者直接消失
  // ignore: no_leading_underscores_for_local_identifiers
  void _dismissOrNextAction() {
    if (acitveIdx.value == toastList.length - 1) {
      SmartDialog.dismiss();
    } else {
      acitveIdx.value += 1;
    }
  }

  // ignore: no_leading_underscores_for_local_identifiers
  Widget _buildActivityAds(List<ActivityModel> actList) {
    return Container(
      width: 330.w,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            constraints: BoxConstraints(
                maxHeight: 460.w, minWidth: 330.w, maxWidth: 330.w),
            child: SingleChildScrollView(
              child: Wrap(
                runSpacing: 5.w,
                children: actList
                    .map((e) => ImageView(
                          src: e.coverPicture ?? '',
                          width: 330.w,
                          height: 150.w,
                          borderRadius: BorderRadius.circular(5.w),
                        ).onTap(() => jumpExternalURL(e.actUrl)))
                    .toList(),
              ),
            ),
          ),
          10.w.verticalSpaceFromWidth,
          Icon(
            size: 40.w,
            Icons.cancel,
            color: Colors.white,
          ).onTap(_dismissOrNextAction),
        ],
      ),
    );
  }

  AppUpdateModel? versionModel;

  ///版本更新
  if (!kIsWeb) {
    versionModel = await checkVersion();
    // versionModel = AppUpdateModel.test();
    logger.d('update:${versionModel != null}');
    final landUrl = Get.find<AppService>().androidLandURL;
    if (versionModel != null && versionModel.hasNewVersion == true) {
      toastList.add(VersionUpdateBox(
        model: versionModel,
        dismiss: _dismissOrNextAction,
        androidApkURL: landUrl,
      ));
    }
  }

  ///公告
  final model = await httpInstance.get<AnnouncementModel>(
      url: 'sys/ann', complete: AnnouncementModel.fromJson);
  // final model = AnnouncementModel.test();
  if (model != null) {
    toastList.add(
      NoticeBox(
        model: model,
        dismiss: _dismissOrNextAction,
      ),
    );
  }

  ///开屏广告
  final models = adHelper.getAdLoadInOrder(AdApiType.INDEX_POP_ICON);
  if (models.isNotEmpty) {
    toastList.add(
      OpenScreenAds(
        models: models,
        dismiss: _dismissOrNextAction,
      ),
    );
  }

  /// 弹窗广告(三个一组)
  final bulletAds = adHelper.getAdLoadInOrder(AdApiType.START_POP_UP);
  if (bulletAds.isNotEmpty) {
    final items = bulletAds.slices(3);
    if (items.isNotEmpty) {
      for (List<AdInfoModel> arr in items) {
        toastList.add(
          VerticalGroupAds(
            models: arr,
            dismiss: _dismissOrNextAction,
          ),
        );
      }
    }
  } else {
    // dismissAction?.call();
  }

  //活动 +弹窗广告
  // final activityRspModel = await httpInstance.get<HomeActivityModel>(
  //     url: 'activity/indexActs', complete: HomeActivityModel.fromJson);
  // if (activityRspModel != null && activityRspModel is HomeActivityModel) {
  //   final List<ActivityModel> actList = activityRspModel.actList ?? [];
  //   if (actList.isNotEmpty) {
  //     // toastList.add(_buildActivityAds(actList));
  //     final items = actList.slices(3);
  //     if (items.isNotEmpty) {
  //       for (List<ActivityModel> arr in items) {
  //         toastList.add(_buildActivityAds(arr));
  //       }
  //     }
  //   }
  // }

  showAllAds({
    bool clickMaskDismiss = false,
    double width = double.infinity,
    double height = double.infinity,
  }) async {
    SmartDialog.show(
        maskColor: const Color.fromRGBO(0, 0, 0, 0.5),
        builder: (_) {
          return ValueListenableBuilder(
              valueListenable: acitveIdx,
              builder: (context, value, child) {
                return toastList[value];
              });
        },
        clickMaskDismiss: clickMaskDismiss,
        onMask: () {
          if (GetPlatform.isAndroid &&
              versionModel != null &&
              versionModel.hasNewVersion == true &&
              versionModel.isForceUpdate == true) {
            return;
          }
          _dismissOrNextAction();
        });
  }

  if (toastList.isEmpty) return;
  await showAllAds();
}
