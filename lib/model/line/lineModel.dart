/*
 * @Author: wangdazhuang
 * @Date: 2024-08-26 11:31:45
 * @LastEditTime: 2024-09-02 11:59:55
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /xhs_app/lib/src/model/line/lineModel.dart
 */
import 'package:json2dart_safe/json2dart.dart';

class LineModel {
  List<ImgCdnList>? imgCdnList;
  List<VideoCdnList>? videoCdnList;

  LineModel({
    this.imgCdnList,
    this.videoCdnList,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('imgCdnList', this.imgCdnList?.map((v) => v.toJson()).toList())
      ..put('videoCdnList', this.videoCdnList?.map((v) => v.toJson()).toList());
  }

  LineModel.fromJson(Map<String, dynamic> json) {
    this.imgCdnList = json.asList<ImgCdnList>(
        'imgCdnList', (v) => ImgCdnList.fromJson(Map<String, dynamic>.from(v)));
    this.videoCdnList = json.asList<VideoCdnList>('videoCdnList',
        (v) => VideoCdnList.fromJson(Map<String, dynamic>.from(v)));
  }

  static LineModel toBean(Map<String, dynamic> json) =>
      LineModel.fromJson(json);
}

class ImgCdnList {
  String? domain;
  String? id;
  String? url;

  ImgCdnList({
    this.domain,
    this.id,
    this.url,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('domain', this.domain)
      ..put('id', this.id)
      ..put('url', this.url);
  }

  ImgCdnList.fromJson(Map<String, dynamic> json) {
    this.domain = json.asString('domain');
    this.id = json.asString('id');
    this.url = json.asString('url');
  }
}

class VideoCdnList {
  String? domain;
  String? id;
  String? url;

  VideoCdnList({
    this.domain,
    this.id,
    this.url,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('domain', this.domain)
      ..put('id', this.id)
      ..put('url', this.url);
  }

  VideoCdnList.fromJson(Map<String, dynamic> json) {
    this.domain = json.asString('domain');
    this.id = json.asString('id');
    this.url = json.asString('url');
  }
}
