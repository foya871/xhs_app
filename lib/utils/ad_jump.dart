/*
 * @Author: wangdazhuang
 * @Date: 2024-08-23 10:41:49
 * @LastEditTime: 2025-03-13 15:10:22
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /xhs_app/lib/utils/ad_jump.dart
 */
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' as ddd;
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:install_plugin/install_plugin.dart';
import 'package:xhs_app/components/ad/ad_info_model.dart';
import 'package:xhs_app/components/diolog/dialog.dart';
import 'package:xhs_app/http/api/login.dart';
import 'package:xhs_app/http/service/api_service.dart';
import 'package:xhs_app/model/advertisements/ad_resp_model.dart';
import 'package:xhs_app/routes/routes.dart';
import 'package:xhs_app/services/storage_service.dart';
import 'package:xhs_app/services/user_service.dart';
import 'package:xhs_app/utils/enum.dart';
import 'package:xhs_app/utils/file_downloader.dart';
import 'package:xhs_app/utils/logger.dart';
import 'package:xhs_app/views/webview/webview_page.dart';
import 'package:universal_html/html.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../components/diolog/loading/loading_view.dart';
import '../components/easy_toast.dart';
import '../env/environment_service.dart';

// ignore: constant_identifier_names
const INNERHEADER = 'xhs://xhs/';

abstract class JumpProtocolEnum {
  //长视频 "xhs://xhs/video?videoId=123"
  static const video = 'video';

  //活动 "xhs://xhs/activity?url=https://www.baidu.com";
  static const activity = "activity";

  //会员  "xhs://xhs/rech";
  static const rech = 'rech';

  //钱包  "xhs://xhs/wall";
  static const wall = 'wall';

  //分享  "xhs://xhs/share";
  static const share = 'share';

  //加群  "xhs://xhs/group";
  static const group = 'group';

  //博主主页  "xhs://xhs/blogger?bloggerId=123";
  static const blogger = 'blogger';

  //游戏"xhs://xhs/game?gameId=123";
  static const game = 'game';

  //AI"xhs://xhs/ai";
  static const ai = 'ai';
}

//点击上报
_clickAdReport(params, {bool? partener}) async {
  final api =
      partener == true ? 'sys/partner/click/report' : 'sys/click/upload';
  try {
    await httpInstance.post(url: api, body: Map<String, dynamic>.from(params));
  } catch (e) {
    //ignore
  }
}

// 跳转外部链接
void jumpExternalAddress(String url, params, {bool? partener}) async {
  if (params != null) {
    _clickAdReport(params, partener: partener);
  }
  if (GetPlatform.isAndroid && url.contains(".apk")) {
    await _innerDownloadAndInstallApk(url);
    return;
  }
  Uri? path = Uri.tryParse(url);
  if (path == null) {
    logger.d('jumpExternalAddress bad url');
    return;
  }

  if (kIsWeb) {
    window.open(url, '_blank');

    return;
  }
  try {
    if (!await canLaunchUrl(path)) {
      logger.d('jumpExternalAddress can not launch url:$url');
      return;
    }

    if (!await launchUrl(path, mode: LaunchMode.externalApplication)) {
      logger.d('jumpExternalAddress launch fail url:$url');
    }
  } catch (e) {
    logger.d('jumpExternalAddress launch fail url:$url e:$e');
  }
}

//跳转内部
void jumpInternalAddress(String url) {
  if (SmartDialog.checkExist()) SmartDialog.dismiss();
  final adJumpAddress = url.substring(INNERHEADER.length);
  if (adJumpAddress.startsWith(JumpProtocolEnum.video)) {
    final videoId = url.split('=')[1];
    //跳视频播放
    Get.toPlayVideo(videoId: int.parse(videoId));
  }

  if (adJumpAddress.startsWith(JumpProtocolEnum.blogger)) {
    final id = url.split('=')[1];
    //跳博主详情
    Get.toBloggerDetail(userId: int.parse(id));
    return;
  }

  if (adJumpAddress.startsWith(JumpProtocolEnum.game)) {
    final id = url.split('=')[1];
    Get.toGameDetail(int.tryParse(id) ?? 0);
    return;
  }

  if (adJumpAddress.startsWith(JumpProtocolEnum.activity)) {
    //跳活动
    final storageService = Get.find<StorageService>();
    final token = storageService.token;
    final jumpurl = '${url.split('=')[1]}?token=$token';
    ddd.Navigator.push(
      Get.context!,
      MaterialPageRoute(builder: (BuildContext context) {
        return AppWebViewPage(
          url: jumpurl,
        );
      }),
    );
    return;
  }
  if (adJumpAddress.startsWith(JumpProtocolEnum.rech)) {
    //跳会员
    Get.toVip();

    return;
  }

  if (adJumpAddress.startsWith(JumpProtocolEnum.wall)) {
    //跳钱包
    Get.toVip(tabInitIndex: 1);
    return;
  }
  if (adJumpAddress.startsWith(JumpProtocolEnum.share)) {
    //跳分享
    Get.toShare();
    return;
  }
  if (adJumpAddress.startsWith(JumpProtocolEnum.group)) {
    //跳加群
    // Get.toNamed(Routes.share);
    Get.toNamed(Routes.mine_fans_followers, parameters: {'title': "加群聊骚"});
    return;
  }
  if (adJumpAddress.startsWith(JumpProtocolEnum.ai)) {
    //跳AI
    return;
  }
}

void _reportAd({required String adId}) => httpInstance.post(
      url: 'all/ad/click/report',
      body: {
        "id": adId,
      },
    );

// 跳转外部链接
void jumpExternalURL(
  String? url, {
  String? adId,
}) async {
  if (url == null || url.isEmpty) return;
  if (adId != null) _reportAd(adId: adId);
  if (GetPlatform.isAndroid && url.contains(".apk")) {
    ///站内下载apk包
    var percentage = 0.0.obs;
    final res = await LoadingView.singleton.wrapWidget(
      context: Get.context!,
      background: Colors.black.withValues(alpha: 0.5),
      color: Colors.white,
      child: Obx(
        () => ddd.Text(
          '下载中:${percentage.value.toStringAsFixed(2)}%',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      asyncFunction: () async {
        final res = await _androidInnerAppDownloadApk(url, (p) {
          percentage.value = p;
        });
        return res;
      },
    );
    if (res == FileDownloaderResult.fail) {
      EasyToast.show("下载失败，请重试!");
      return;
    }

    if (res == FileDownloaderResult.success) {
      final filePath = await filedownloader.fileSavePathForNative(url);
      final insRes = await InstallPlugin.install(filePath);
      EasyToast.show(insRes['isSuccess'] == true
          ? '安装成功'
          : '安装失败:${insRes['errorMessage'] ?? ''}');
      return;
    }
    return;
  }
  Uri? path = Uri.tryParse(url);
  if (path == null) {
    logger.d('jumpExternalURL bad url');
    return;
  }

  if (kIsWeb) {
    _iosOpenURl(url);
    return;
  }
  try {
    if (!await canLaunchUrl(path)) {
      logger.d('jumpExternalURL can not launch url:$url');
      return;
    }

    if (!await launchUrl(path, mode: LaunchMode.externalApplication)) {
      logger.d('jumpExternalURL launch fail url:$url');
    }
  } catch (e) {
    logger.d('jumpExternalURL launch fail url:$url e:$e');
  }
}

_iosOpenURl(String url) async {
  var newWindow;
  newWindow = window.open(url, '_blank');
  Future.delayed(const Duration(milliseconds: 500), () {
    newWindow.location.href = url;
  });
}

///在线客服
void kOnLineService({String onLineServiceUrl = ""}) async {
  var url = onLineServiceUrl;
  if (url.isEmpty) {
    url = Get.find<StorageService>().onLine ?? '';
    if (url.isEmpty) {
      final resp = await fetchOnLine();
      if (resp != null) {
        url = resp;
      } else {
        EasyToast.show("在线客服地址获取失败!");
      }
    }
    if (url.isEmpty) {
      EasyToast.show("在线客服地址获取失败!");
      return;
    }
    url = (Environment.kbaseAPI + url).replaceFirst("api//", "");
  }
  launchUrlString(
    url,
    mode: LaunchMode.externalApplication,
    webViewConfiguration: const WebViewConfiguration(),
    browserConfiguration: const BrowserConfiguration(showTitle: true),
  );
}

void kAdjump(AdInfoModel? ad) {
  if (ad == null) return;
  if (ad.adJump.startsWith(INNERHEADER)) {
    //跳内部
    jumpInternalAddress(ad.adJump);
  } else {
    jumpExternalURL(
      ad.adJump,
      adId: ad.adId,
    );
  }
}

Future<FileDownloaderResult> _androidInnerAppDownloadApk(
    String apkURL, ValueCallback? percent) async {
  // SmartDialog.showLoading(msg: "下载中:0%", alignment: Alignment.center);
  final res = await filedownloader.downloadMediaFile(apkURL,
      onProgress: (count, total) {
    final percentage = (count / total) * 100.0.toDouble();
    percent?.call(percentage);
  });
  return res;
}

_innerDownloadAndInstallApk(String url) async {
  ///apk内部直接下载安装
  var percentage = 0.0.obs;
  final res = await LoadingView.singleton.wrapWidget(
    context: Get.context!,
    background: Colors.black.withOpacity(0.5),
    color: Colors.white,
    child: Obx(
      () => ddd.Text(
        '下载中:${percentage.value.toStringAsFixed(2)}%',
        style: const TextStyle(color: Colors.white),
      ),
    ),
    asyncFunction: () async {
      final res = await _androidInnerAppDownloadApk(url, (p) {
        percentage.value = p;
      });
      return res;
    },
  );
  if (res == FileDownloaderResult.fail) {
    EasyToast.show("下载失败，请重试!");
    return;
  }

  if (res == FileDownloaderResult.success) {
    final filePath = await filedownloader.fileSavePathForNative(url);
    final insRes = await InstallPlugin.install(filePath);
    EasyToast.show(insRes['isSuccess'] == true
        ? '安装成功'
        : '安装失败:${insRes['errorMessage'] ?? ''}');
    return;
  }
}

void jump2Ai() {
  final localStore = Get.find<StorageService>();

  ///跳转AI
  final token = localStore.token ?? '';
  final aiLink = localStore.aiLink ?? '';
  if (aiLink.isEmpty) {
    showToast('ai链接非法!');
    return;
  }

  if (token.isEmpty) {
    showToast('token非法!');
    return;
  }

  //https://16sui.jhai.work
  final url = '$aiLink?token=$token&app=xhs';
  _jumpInnnerWebView(jumUrl: url);
}

void _jumpInnnerWebView({required String jumUrl}) {
  ddd.Navigator.push(
    Get.context!,
    MaterialPageRoute(builder: (BuildContext context) {
      return AppWebViewPage(
        url: jumUrl,
      );
    }),
  );
}
