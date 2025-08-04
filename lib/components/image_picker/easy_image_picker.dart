import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:cross_file/cross_file.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

import 'easy_image_picker_file.dart';

final _defaultWebAllowedImageExtentsions = [
  'jpg',
  'png',
  'jpeg',
  'gif',
];
final _defaultVideoExtensions = ["mov", 'mp4'];

enum _EasyPickeType { common, image, video }

abstract class EasyImagePicker {
  // maxAssets 并不能限制用户具体选多少个，只能限制选一个或者选多个
  // 在返回的时候，把多余的去掉
  static Future<List<EasyImagePickerFile>> _pickAssets({
    required int maxAssets,
    required _EasyPickeType type,
    List<String>? webAllowedExtentsions,
  }) async {
    if (maxAssets <= 0) return [];
    var fileType = FileType.custom;
    List<String>? allowedExtensions;
    if (!kIsWeb) {
      if (type == _EasyPickeType.image) {
        fileType = FileType.image;
      } else if (type == _EasyPickeType.video) {
        fileType = FileType.video;
      } else if (type == _EasyPickeType.common) {
        fileType = FileType.custom;
      }
    }
    if (fileType == FileType.custom) {
      // allowedExtensions 只支持 FileType.custom
      if (type == _EasyPickeType.video) {
        allowedExtensions = _defaultVideoExtensions;
      } else if (type == _EasyPickeType.image) {
        allowedExtensions = _defaultWebAllowedImageExtentsions;
      }
    }

    FilePickerResult? pickerResult = await FilePicker.platform.pickFiles(
      type: fileType,
      allowMultiple: maxAssets > 1,
      allowedExtensions: allowedExtensions,
    );
    if (pickerResult == null) return [];
    final result = <EasyImagePickerFile>[];
    for (int i = 0; i < pickerResult.files.length; i++) {
      final f = pickerResult.files[i];
      XFile? xfile;
      File? file;
      String path;
      if (kIsWeb) {
        xfile = f.xFile;
        path = f.xFile.path;
      } else {
        final p = f.path;
        if (p == null) continue;
        path = p;
        file = File(p);
      }
      result.add(EasyImagePickerFile(
        name: f.name,
        path: path,
        xfile: xfile,
        file: file,
      ));
      if (result.length == maxAssets) break;
    }
    return result;
  }

  static Future<EasyImagePickerFile?> _pickSingleVideoFromGallery({
    List<String>? webAllowedExtentsions,
  }) async {
    final assets = await _pickAssets(
      maxAssets: 1,
      type: _EasyPickeType.video,
      webAllowedExtentsions: webAllowedExtentsions,
    );
    return assets.firstOrNull;
  }

  static Future<EasyImagePickerFile?> _pickSingleImage({
    List<String>? webAllowedExtentsions,
  }) async {
    final assets = await _pickAssets(
      maxAssets: 1,
      type: _EasyPickeType.image,
      webAllowedExtentsions: webAllowedExtentsions,
    );
    return assets.firstOrNull;
  }

  static Future<List<EasyImagePickerFile>> _pickImages({
    required int maxAssets,
    List<String>? webAllowedExtentsions,
  }) async {
    final assets = await _pickAssets(
      maxAssets: maxAssets,
      type: _EasyPickeType.image,
      webAllowedExtentsions: webAllowedExtentsions,
    );
    return assets;
  }

  ///拍照
  static Future<EasyImagePickerFile?> pickSingleImageGrantCamera({
    List<String>? webAllowedExtentsions,
  }) async {
    if (kIsWeb) return null;
    await Permission.camera.request();
    var status = await Permission.camera.status;
    if (status.isGranted) {
      return pickSingleImageGrant(webAllowedExtentsions: webAllowedExtentsions);
    }
    return null;
  }

  static Future<EasyImagePickerFile?> pickSingleImageGrant({
    List<String>? webAllowedExtentsions,
  }) async {
    if (!kIsWeb) {
      var status = await Permission.photos.request();
      if (!status.isGranted) {
        status = await Permission.storage.request();
      }
      if (!status.isGranted) return null;
    }

    return _pickSingleImage(webAllowedExtentsions: webAllowedExtentsions);
  }

  static Future<List<EasyImagePickerFile>> pickImagesGrant({
    required int maxAssets,
    List<String>? webAllowedExtentsions,
  }) async {
    if (!kIsWeb) {
      var status = await Permission.photos.request();
      if (!status.isGranted) {
        status = await Permission.storage.request();
      }
      if (!status.isGranted) return [];
    }
    return _pickImages(
      maxAssets: maxAssets,
      webAllowedExtentsions: webAllowedExtentsions,
    );
  }

  ///选取视频
  static Future<EasyImagePickerFile?> pickSingleVideoGrant({
    List<String>? webAllowedExtentsions,
  }) async {
    if (!kIsWeb) {
      var status = await Permission.videos.request();
      if (!status.isGranted) {
        status = await Permission.storage.request();
      }
      if (!status.isGranted) return null;
    }
    return _pickSingleVideoFromGallery(
      webAllowedExtentsions: webAllowedExtentsions,
    );
  }
}
