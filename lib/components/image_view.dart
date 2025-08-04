/*
 * @Author: wangdazhuang
 * @Date: 2024-08-08 20:57:43
 * @LastEditTime: 2025-03-10 09:06:19
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /xhs_app/lib/components/image_view.dart
 */

import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
// ignore: depend_on_referenced_packages
import 'package:cached_network_image_platform_interface/cached_network_image_platform_interface.dart';
import 'package:dio/dio.dart';
import 'package:xhs_app/components/image_format_utils.dart';
import 'package:xhs_app/generate/app_image_path.dart';
import 'package:xhs_app/model/axis_cover.dart';
import 'package:xhs_app/services/storage_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

const _key = 'customCacheKey';

final kkkkkk = utf8.encode('2020-zq3-888');

class EncryptHttpFileService extends FileService {
  final encryptedLen = 100;
  final _dio = Dio(BaseOptions(
      responseType: ResponseType.stream,
      connectTimeout: const Duration(seconds: 10)));

  void _decrypt(
      Stream<Uint8List> stream, StreamController<List<int>> controller) {
    List<int>? header;
    bool headerSent = false;
    stream.listen(
      (event) {
        if (!headerSent) {
          header ??= [];
          if (header!.length < encryptedLen) {
            header!.addAll(event);
          }
          if (header!.length >= encryptedLen) {
            if (ImageFormatUtils.imageFormatForImageUnit8List(header!) ==
                ImageFormat.UNDEFINED) {
              for (int i = 0; i < encryptedLen; i++) {
                header![i] ^= kkkkkk[i % kkkkkk.length];
              }
            }
            controller.add(header!);
            headerSent = true;
          }
        } else {
          controller.add(event);
        }
      },
      onDone: () => controller.close(),
      onError: (e) => controller.addError(e),
      cancelOnError: true,
    );
  }

  @override
  Future<FileServiceResponse> get(String url,
      {Map<String, String>? headers}) async {
    final controller = StreamController<List<int>>();
    Stream<Uint8List>? stream;
    int? statusCode;
    String? statusCodeMsg;
    Headers? respHeaders;
    bool isRedirect = false;
    try {
      final resp = await _dio.get<ResponseBody>(
        url,
        options: Options(headers: headers),
      );
      stream = resp.data?.stream;
      statusCode = resp.statusCode;
      statusCodeMsg = resp.statusMessage;
      respHeaders = resp.headers;
      isRedirect = resp.isRedirect;
    } catch (e) {
      controller.addError(e);
    }
    if (stream == null || statusCode == null) {
      controller.close();
    } else {
      _decrypt(stream, controller);
    }
    final contentLength =
        int.tryParse(respHeaders?.value(Headers.contentLengthHeader) ?? '-');
    Map<String, String> transfromedHeaders = {};
    respHeaders?.map
        .forEach((key, value) => transfromedHeaders[key] = value.join(','));

    return HttpGetResponse(
      http.StreamedResponse(
        controller.stream,
        statusCode ?? 500,
        contentLength: contentLength,
        request: null,
        headers: transfromedHeaders,
        isRedirect: isRedirect,
        reasonPhrase: statusCodeMsg,
      ),
    );
  }
}

final _defaultCustomCacheManager = CacheManager(
  Config(
    _key,
    stalePeriod: const Duration(days: 30),
    maxNrOfCacheObjects: 100,
    repo: GetPlatform.isWeb
        ? NonStoringObjectProvider()
        : JsonCacheInfoRepository(databaseName: _key),
    // fileSystem: GetPlatform.isWeb ? MemoryCacheSystem() : IOFileSystem(_key),
    fileService: EncryptHttpFileService(),
  ),
);

// void _defaultErrorListener(String url, Object err) =>
//     logger.d('Image Load fail,url:$url,err:$err');
final localStore = Get.find<StorageService>();
var domain = localStore.imgDomain ?? '';

///生成图片路径(url, cacheKey)
(String, String) _imageSrc(String src, [int? clipW]) {
  bool hasHeader = src.startsWith("http");
  if (hasHeader) return (src, src);
  if (domain.endsWith("/") == false) {
    domain = '$domain/';
  }
  final isGif = src.contains(".gif") || src.contains('.webp');
  //默认480
  final clip = isGif
      ? ''
      : clipW == null
          ? ''
          : '_$clipW';
  return ('$domain$src$clip', '$src$clip');
}

class ImageView extends StatefulWidget {
  final String src;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final BorderRadius? borderRadius;
  final String? defaultPlace;
  final double? minHeight;
  final bool? vertical;
  final bool shrinkIfSrcEmpty;
  final double? blurSigma;
  final Color? blurColor;

  ///裁剪参数 一般是 320  ｜ 480
  final int? clipWidth;
  const ImageView({
    super.key,
    required this.src,
    this.height,
    this.width,
    this.minHeight,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.clipWidth,
    this.defaultPlace,
    bool? vertical, // //和axis 不同时传入
    CoverImgAxis? axis, // 和vertical 不同时传入
    this.shrinkIfSrcEmpty = false, // 如果src为空,直接返回 Sizebox.shrink()
    this.blurSigma,
    this.blurColor,
  }) : vertical =
            axis != null ? axis == CoverImgAxis.vertical : (vertical ?? false);

  @override
  createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  ///默认图
  Widget placeDefaultImage() {
    return ClipRRect(
      borderRadius: widget.borderRadius ?? BorderRadius.zero,
      child: Image.asset(
        widget.defaultPlace ??
            (widget.vertical == true
                ? AppImagePath.icon_placeholder_v
                : AppImagePath.icon_placeholder),
        width: widget.width,
        height: widget.height,
        fit: widget.fit ?? BoxFit.fill,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.src.isEmpty) {
      if (widget.shrinkIfSrcEmpty) {
        return const SizedBox.shrink();
      }
      return placeDefaultImage();
    }
    //本地图片
    if (widget.src.startsWith("assets")) {
      return ClipRRect(
        borderRadius: widget.borderRadius ?? BorderRadius.zero,
        child: Image.asset(
          widget.src,
          width: widget.width,
          height: widget.height,
          fit: widget.fit,
        ),
      );
    }
    final src = _imageSrc(widget.src, widget.clipWidth);
    final image = CachedNetworkImage(
      fit: widget.fit,
      width: widget.width,
      height: widget.height,
      imageUrl: src.$1,
      cacheKey: src.$2,
      fadeInDuration:
          kIsWeb ? Duration.zero : const Duration(milliseconds: 500),
      fadeOutDuration:
          kIsWeb ? Duration.zero : const Duration(milliseconds: 1000),
      imageRenderMethodForWeb: kIsWeb
          ? ImageRenderMethodForWeb.HttpGet
          : ImageRenderMethodForWeb.HtmlImage,
      cacheManager: _defaultCustomCacheManager,
      placeholder: (context, url) {
        return placeDefaultImage();
      },
      errorWidget: (context, url, error) {
        return placeDefaultImage();
      },
    );

    final imageChild = Container(
      constraints: BoxConstraints(minHeight: widget.minHeight ?? 0),
      child: ClipRRect(
        borderRadius: widget.borderRadius ?? BorderRadius.zero,
        child: image,
      ),
    );
    if (widget.blurSigma == null) {
      return imageChild;
    }
    return Stack(
      children: [
        imageChild,
        ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: widget.blurSigma!,
              sigmaY: widget.blurSigma!,
            ),
            child: Container(color: widget.blurColor),
          ),
        )
      ],
    );
  }
}

class ImageViewProvider extends CachedNetworkImageProvider {
  ImageViewProvider(
    String src, {
    super.maxHeight,
    super.maxWidth,
    super.scale,
  }) : super(
          _imageSrc(src).$1,
          cacheKey: _imageSrc(src).$2,
          cacheManager: _defaultCustomCacheManager,
          imageRenderMethodForWeb: kIsWeb
              ? ImageRenderMethodForWeb.HttpGet
              : ImageRenderMethodForWeb.HtmlImage,
        );
}
