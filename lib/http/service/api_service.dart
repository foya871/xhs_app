/*
 * @Author: wangdazhuang
 * @Date: 2024-07-18 19:14:37
 * @LastEditTime: 2025-06-12 14:49:42
 * @LastEditors: wdz
 * @Description: 
 * @FilePath: /pornhub_app/lib/http/service/api_service.dart
 */
import 'package:dio/dio.dart';

import 'package:flutter/foundation.dart';

// ignore: implementation_imports
import 'package:dio/src/multipart_file.dart' as ddd;

// ignore: implementation_imports
import 'package:dio/src/form_data.dart' as ddd;
import '../../components/easy_toast.dart';
import '../../env/environment_service.dart';
import '../../model/image_upload_resp_model.dart';
import '../../utils/logger.dart';
import 'api_code.dart';
import 'api_const.dart';
import 'api_error_interceptor.dart';
import 'api_exception_handler.dart';
import 'api_request_interceptor.dart';
import 'api_response_interceptor.dart';
import 'api_response_transformer.dart';
import 'base_repsponse_model.dart';

typedef JSON2ModelComplete<T> = T Function(Map<String, dynamic> json);

class ApiService {
  static late Dio _dio;
  static final ApiService _singleton = ApiService._internal();

  factory ApiService() => _singleton;

  ///初始化
  ApiService._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: Environment.kbaseAPI,
        connectTimeout: const Duration(seconds: 60),
        sendTimeout: !kIsWeb ? const Duration(seconds: 30) : null,
        // web不支持
        receiveTimeout: const Duration(seconds: 60),
        contentType: ApiConst.kContentTypeApplicationJSON,
      ),
    );

    //添加请求和相应拦截器
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: ApiRequestInterceptor.onRequest,
        onResponse: ApiResponseInterceptor.onResponse,
        onError: ApiErrorInterceptor.onError,
      ),
    );
  }

  ///get
  /// requestEntireModel针对 {total:123,data:[]} 的这种情况
  Future get<T>({
    required String url,
    Map<String, dynamic>? queryMap,
    JSON2ModelComplete<T>? complete,
    bool? requestEntireModel,
    CancelToken? token,
  }) async {
    return _request(
      method: "GET",
      url: url,
      queryMap: queryMap,
      requestEntireModel: requestEntireModel,
      complete: complete,
      token: token,
    );
  }

  /// post
  /// requestEntireModel针对 {total:123,data:[]} 的这种情况
  Future post<T>(
      {required String url,
      Map<String, dynamic>? body,
      JSON2ModelComplete<T>? complete,
      bool? requestEntireModel,
      bool? isFile}) async {
    return _request(
        method: "POST",
        url: url,
        body: body,
        requestEntireModel: requestEntireModel,
        complete: complete,
        isFile: isFile);
  }

  Future<ImageUploadRspModel?> uploadImageSafe(Uint8List bytes,
      [void Function(int, int)? progress]) async {
    try {
      return uploadImage(bytes, progress);
    } catch (e) {
      return null;
    }
  }

  //图片上传
  Future<ImageUploadRspModel?> uploadImage(
      Uint8List bytes, void Function(int, int)? progress) async {
    final fromFile = ddd.MultipartFile.fromBytes(bytes,
        filename: '#${DateTime.now().millisecondsSinceEpoch}.png');
    final formData = ddd.FormData.fromMap({'file': fromFile});

    _dio.options.headers.update(
        Headers.contentTypeHeader, (v) => ApiConst.kMutiplyPartFileContentType);
    _dio.options.baseUrl = Environment.kbaseAPI.replaceFirst("api", "file");
    try {
      Response r = await _dio.post(
        'upload/multipart/img',
        data: formData,
        onSendProgress: (count, total) {
          progress!(count, total);
        },
      );
      if (r.data is BaseRespModel<dynamic>) {
        BaseRespModel respmodel = r.data;
        logger.d("uploadImage result >>> ${respmodel.data} ");
        final model = ImageUploadRspModel.fromJson(
            Map<String, dynamic>.from(respmodel.data));
        return model;
      }
      return null;
    } on DioException catch (e) {
      logger.d(e.toString());
      rethrow;
    }
  }

  /// 多表单文件和json post上传 一般是单张图片 + post参数
  Future<dynamic> multiPartFormPost({
    required String url,
    required Uint8List file,
    Map<String, dynamic>? body,

    /// 用来取消请求的 ，这边分片上传会出现多个请求，退出页面需要取消全部请求，
    CancelToken? token,

    /// 是否是视频分片上传
    bool? isVideo,

    /// 进度百分比回掉
    void Function(int, int)? progress,
  }) async {
    final isVideossss = isVideo == true;
    final millseconds = DateTime.now().millisecondsSinceEpoch;
    final filename = "$millseconds.${isVideossss ? 'mov' : 'png'}";
    final fromFile = ddd.MultipartFile.fromBytes(file, filename: filename);
    removeNull(body);
    final formData = ddd.FormData.fromMap({'file': fromFile, ...?body});
    _dio.options.headers.update(
        Headers.contentTypeHeader, (v) => ApiConst.kMutiplyFormPostContentType);
    if (isVideossss) {
      _dio.options.baseUrl = Environment.kbaseAPI.replaceFirst("api", "file");
    }
    try {
      Response r = await _dio.post(
        url,
        data: formData,
        cancelToken: token,
        onSendProgress: (count, total) {
          if (progress != null) {
            progress(count, total);
          }
        },
      );
      // 和普通请求保持统一，抛出异常表示错误
      if (r.data == null) {
        throw {"code": 0, "msg": 'dio empty data'};
      }
      BaseRespModel rr = r.data;
      logger.d(
          'multiPartFormPost $url>>$body>>file:${file.length}>>{code:${rr.code},data:${rr.data},msg:${rr.msg}}');
      if (rr.code != ApiCode.ok) {
        if (rr.msg?.isNotEmpty == true) {
          EasyToast.show(rr.msg!);
        }
        throw {"code": rr.code ?? 0, "msg": rr.msg};
      }
      return rr.data;
    } on DioException catch (e) {
      logger.d('multiPartFormPost $url>>$body>>file:${file.length}>>$e');
      rethrow;
    }
  }

  ///筛选空值情况
  Map? removeNull(Map? m) {
    if (m == null) return null;
    final keysToRemove = [];
    m.forEach((k, v) {
      if (v == null) {
        keysToRemove.add(k);
      } else if (v is Map) {
        removeNull(v);
      } else if (v is List) {
        for (final e in v) {
          if (e is Map) {
            removeNull(e);
          }
        }
      }
    });
    for (final k in keysToRemove) {
      m.remove(k);
    }
    return m;
  }

  ////request
  Future _request<T>(
      {required String method,
      required String url,
      Map<String, dynamic>? body,
      Map<String, dynamic>? queryMap,
      JSON2ModelComplete<T>? complete,
      bool? requestEntireModel,
      CancelToken? token,
      bool? isFile}) async {
    if (isFile == true) {
      _dio.options.baseUrl = Environment.kbaseAPI.replaceFirst("api", "file");

      ///替换请求头
      _dio.options.headers.update(Headers.contentTypeHeader,
          (v) => ApiConst.kContentTypeApplicationJSON);
    } else {
      final currentDioHasReplaceHeader =
          _dio.options.baseUrl.endsWith("file/") ||
              _dio.options.headers.values
                  .contains(ApiConst.kMutiplyFormPostContentType);
      if (currentDioHasReplaceHeader) {
        ///替换请求头
        _dio.options.headers.update(Headers.contentTypeHeader,
            (v) => ApiConst.kContentTypeApplicationJSON);
      }
      _dio.options.baseUrl = Environment.kbaseAPI.replaceFirst("file", "api");
    }
    try {
      final resp = await _dio.request(
        url,
        cancelToken: token ?? CancelToken(),
        data: removeNull(body),
        queryParameters: Map<String, dynamic>.from(removeNull(queryMap) ?? {}),
        options: Options(method: method),
      );
      final finalData = await ApiResponseTransformer.transform<T>(
          resp, complete, requestEntireModel,
          url: url, method: method, queryMap: queryMap, body: body);
      return finalData;
    } catch (e) {
      if (e is DioException) {
        final exc = ApiExceptionHandler.transformExc(e);
        throw exc;
      } else {
        logger.d('error >>>> ${e.toString()}');
        rethrow;
      }
    }
  }

  ///图片上传
  Future<ImageUploadRspModel?> uploadImageNew(
      {required Uint8List bytes,
      required String fileSuffix,
      void Function(int, int)? progress,
      CancelToken? token}) async {
    final fromFile = ddd.MultipartFile.fromBytes(bytes,
        filename: '#${DateTime.now().millisecondsSinceEpoch}.$fileSuffix');
    final formData = ddd.FormData.fromMap({'file': fromFile});

    _dio.options.headers.update(
        Headers.contentTypeHeader, (v) => ApiConst.kMutiplyPartFileContentType);
    _dio.options.baseUrl = Environment.kbaseAPI.replaceFirst("api", "file");
    try {
      Response r = await _dio.post(
        'upload/multipart/img',
        data: formData,
        cancelToken: token,
        onSendProgress: (count, total) {
          progress?.call(count, total);
        },
      );
      if (r.data is BaseRespModel<dynamic>) {
        BaseRespModel respmodel = r.data;
        logger.d("uploadImage result >>> ${respmodel.data} ");
        final model = ImageUploadRspModel.fromJson(
            Map<String, dynamic>.from(respmodel.data));
        return model;
      }
      return null;
    } on DioException catch (e) {
      logger.d(e.toString());
      rethrow;
    }
  }
}

ApiService httpInstance = ApiService();
