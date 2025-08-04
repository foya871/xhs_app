/*
 * @Author: ziqi jhzq12345678
 * @Date: 2024-10-08 20:42:51
 * @LastEditors: ziqi jhzq12345678
 * @LastEditTime: 2024-10-08 20:43:46
 * @FilePath: /xhs_app/lib/src/modules/comics/comics_classify.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:json2dart_safe/json2dart.dart';

class ComicsClassify {
  int? classId;
  String? createdAt;
  String? id;
  String? logo;
  int? sortNum;
  int? status;
  String? title;
  int? type;
  String? updatedAt;

  ComicsClassify({
    this.classId,
    this.createdAt,
    this.id,
    this.logo,
    this.sortNum,
    this.status,
    this.title,
    this.type,
    this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('classId', this.classId)
      ..put('createdAt', this.createdAt)
      ..put('id', this.id)
      ..put('logo', this.logo)
      ..put('sortNum', this.sortNum)
      ..put('status', this.status)
      ..put('title', this.title)
      ..put('type', this.type)
      ..put('updatedAt', this.updatedAt);
  }

  ComicsClassify.fromJson(Map<String, dynamic> json) {
    this.classId = json.asInt('classId');
    this.createdAt = json.asString('createdAt');
    this.id = json.asString('id');
    this.logo = json.asString('logo');
    this.sortNum = json.asInt('sortNum');
    this.status = json.asInt('status');
    this.title = json.asString('title');
    this.type = json.asInt('type');
    this.updatedAt = json.asString('updatedAt');
  }

  static ComicsClassify toBean(Map<String, dynamic> json) =>
      ComicsClassify.fromJson(json);
}
