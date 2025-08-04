import 'package:json2dart_safe/json2dart.dart';
import 'package:xhs_app/utils/enum.dart';

class CommunityClassifyModel {
  final int classifyId;
  final String classifyImg;
  final String classifyTitle;
  final int sortNum;
  final CommunityClassifyType type; //类型 1-推荐 2-固定 3-可选， (只有一个样式，不指样式)

  CommunityClassifyModel.fromJson(Map<String, dynamic> json)
      : classifyId = json.asInt('classifyId'),
        classifyImg = json.asString('classifyImg'),
        classifyTitle = json.asString('classifyTitle'),
        sortNum = json.asInt('sortNum'),
        type = json.asInt('type', CommunityClassifyTypeEnum.none);

  static dynamic toBean(dynamic json) => CommunityClassifyModel.fromJson(json);
}
