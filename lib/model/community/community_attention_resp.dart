import 'package:json2dart_safe/json2dart.dart';
import 'package:xhs_app/model/community/community_base_model.dart';

class CommunityAttentionResp {
  final List<CommunityBaseModel> data;
  // final String domain;
  // final dynamic userList;

  CommunityAttentionResp.fromJson(Map<String, dynamic> json)
      : data = json.asList('data', CommunityBaseModel.toBean) ?? [];
}
