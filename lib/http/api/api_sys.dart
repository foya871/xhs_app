/*
 * @Author: wangdazhuang
 * @Date: 2024-09-23 14:09:31
 * @LastEditTime: 2024-10-16 22:51:20
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /xhs_app/lib/src/http/api/api_sys.dart
 */
part of 'api.dart';

// ignore: library_private_types_in_public_api
extension ApiSys on _Api {
  /// 系统消息
  Future<List<SystemNoticeModel>?> fetchSystemNotice(
      {required int page, required int pageSize}) async {
    try {
      final resp = await httpInstance.get<SystemNoticeModel>(
        url: 'information/sys/notice',
        queryMap: {
          'page': page,
          'pageSize': pageSize,
        },
        complete: SystemNoticeModel.fromJson,
      );
      return resp ?? [];
    } catch (e) {
      return null;
    }
  }

  Future<String> getNewCustomerService(String domain, String deviceId) async {
    try {
      final response = await httpInstance.get(
        url: '${domain}news/customer/sign/tourists',
        queryMap: {
          'deviceId': deviceId,
        },
        complete: ServiceModel.fromJson,
      );
      if (response != null) {
        ServiceModel serviceModel = response;
        return serviceModel.signUrl ?? "";
      }
      return "";
    } catch (e) {
      return "";
    }
  }

  ///获取AI链接
  Future<String?> fetchAILink({CancelToken? cancelToken}) async {
    try {
      final resp = await httpInstance.get(
        url: "aiboxNew/getJumpLink",
        token: cancelToken,
      );
      if (resp case {'data': String url}) {
        final localStore = Get.find<StorageService>();
        await localStore.updateAiLink(url);
        return url;
      }
      return null;
    } catch (_) {
      return null;
    }
  }
}
