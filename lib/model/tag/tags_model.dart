import 'package:json2dart_safe/json2dart.dart';

const _allTagsTitleName = '全部标签';
const _allTagsTitleId = -98765431;

class TagsModel {
  final int parentId;
  final int tagsId;
  final String tagsTitle;
  final int videoNum;

  bool get isAll => tagsId == _allTagsTitleId;

  TagsModel.all()
      : tagsId = _allTagsTitleId,
        tagsTitle = _allTagsTitleName,
        parentId = 0,
        videoNum = 0;

  TagsModel.fromJson(Map<String, dynamic> json)
      : parentId = json.asInt('parentId', 0),
        tagsId = json.asInt('tagsId', 0),
        tagsTitle = json.asString('tagsTitle', ''),
        videoNum = json.asInt('videoNum', 0);

  static dynamic toBean(dynamic json) => TagsModel.fromJson(json);
}
