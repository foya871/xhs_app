import 'package:json2dart_safe/json2dart.dart';

class ClassifyModel {
  String? name;
  int? type; //类型 1-资讯，2-视频，3-帖子，4-抖阴

  ClassifyModel.setData(String this.name, int this.type);

  ClassifyModel({this.name, this.type});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('name', name)
      ..put('type', type);
  }

  ClassifyModel.fromJson(Map<String, dynamic> json) {
    name = json.asString('name');
    type = json.asInt('type');
  }

  static ClassifyModel toBean(dynamic json) => ClassifyModel.fromJson(json);
}
