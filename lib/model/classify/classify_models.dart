import 'package:json2dart_safe/json2dart.dart';

import '../../utils/enum.dart';

/// tab分类
class ClassifyModel {
  final int classifyId;
  final String classifyTitle;
  final String createdAt;
  final ShiPinClassifyType type;
  final String updatedAt;

  ClassifyModel.attention()
      : classifyId = ShiPinClassifyTypeEnum.attention,
        classifyTitle = '关注',
        createdAt = '',
        type = ShiPinClassifyTypeEnum.attention,
        updatedAt = '';

  ClassifyModel.fromJson(Map<String, dynamic> json)
      : classifyId = json.asInt('classifyId'),
        classifyTitle = json.asString('classifyTitle'),
        createdAt = json.asString('createdAt'),
        type = json.asInt('type', ShiPinClassifyTypeEnum.none),
        updatedAt = json.asString('updatedAt');
}
