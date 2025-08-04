
import 'package:json2dart_safe/json2dart.dart';
import 'package:xhs_app/model/video/resource_download_model.dart';

class ResourceInfoModel{
  ResourceInfo? data;
  String? domain;

  ResourceInfoModel({this.data,this.domain,});

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('data',this.data?.toJson())
      ..put('domain',this.domain);
  }

  ResourceInfoModel.fromJson(Map<String, dynamic> json) {
    this.data=json.asBean('data',(v)=>ResourceInfo.fromJson(v as Map<String, dynamic>));
    this.domain=json.asString('domain');
  }

  static ResourceInfoModel toBean(Map<String, dynamic> json) => ResourceInfoModel.fromJson(json);
}


