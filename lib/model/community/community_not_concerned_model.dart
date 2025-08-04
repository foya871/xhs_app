import 'package:json2dart_safe/json2dart.dart';

import '../../utils/enum.dart';

class CommunityNotConcernedDynamicInfo {
  final String coverImg;
  final int dynamicId;
  final CommunityType dynamicType;

  CommunityNotConcernedDynamicInfo.fromJson(Map<String, dynamic> json)
      : coverImg = json.asString('coverImg'),
        dynamicId = json.asInt('dynamicId'),
        dynamicType = json.asInt('dynamicType', CommunityTypeEnum.none);

  static dynamic toBean(dynamic json) =>
      CommunityNotConcernedDynamicInfo.fromJson(json);
}

class CommunityNotConcernedModel {
  final List<CommunityNotConcernedDynamicInfo> dynList;
  bool isAttention;
  final String lastDynDate;
  final String logo;
  final String nickName;
  final int userId;

  void onToggleAttentionSuccess() => isAttention = !isAttention;

  CommunityNotConcernedModel.fromJson(Map<String, dynamic> json)
      : dynList =
            json.asList('dynList', CommunityNotConcernedDynamicInfo.toBean) ??
                [],
        isAttention = json.asBool('isAttention'),
        lastDynDate = json.asString('lastDynDate'),
        logo = json.asString('logo'),
        nickName = json.asString('nickName'),
        userId = json.asInt('userId');
}
