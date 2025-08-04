/*
 * @Author: ziqi jhzq12345678
 * @Date: 2024-08-29 09:36:58
 * @LastEditors: ziqi jhzq12345678
 * @LastEditTime: 2024-08-29 09:37:33
 * @FilePath: /xhs_app/lib/src/model/race/race.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:json2dart_safe/json2dart.dart';

class RaceModel {
  int? competitionId;
  String? createdAt;
  String? endTime;
  String? id;
  List<String>? imgs;
  String? info;
  String? startTime;
  int? status;
  String? title;
  String? updatedAt;
  int? videoNum;

  RaceModel({
    this.competitionId,
    this.createdAt,
    this.endTime,
    this.id,
    this.imgs,
    this.info,
    this.startTime,
    this.status,
    this.title,
    this.updatedAt,
    this.videoNum,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('competitionId', this.competitionId)
      ..put('createdAt', this.createdAt)
      ..put('endTime', this.endTime)
      ..put('id', this.id)
      ..put('imgs', this.imgs)
      ..put('info', this.info)
      ..put('startTime', this.startTime)
      ..put('status', this.status)
      ..put('title', this.title)
      ..put('updatedAt', this.updatedAt)
      ..put('videoNum', this.videoNum);
  }

  RaceModel.fromJson(Map<String, dynamic> json) {
    this.competitionId = json.asInt('competitionId');
    this.createdAt = json.asString('createdAt');
    this.endTime = json.asString('endTime');
    this.id = json.asString('id');
    this.imgs = json.asList<String>('imgs', null);
    this.info = json.asString('info');
    this.startTime = json.asString('startTime');
    this.status = json.asInt('status');
    this.title = json.asString('title');
    this.updatedAt = json.asString('updatedAt');
    this.videoNum = json.asInt('videoNum');
  }

  static RaceModel toBean(Map<String, dynamic> json) =>
      RaceModel.fromJson(json);
}
