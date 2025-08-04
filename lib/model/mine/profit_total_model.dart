/*
 * @Author: wangdazhuang
 * @Date: 2024-10-17 21:40:55
 * @LastEditTime: 2024-10-17 21:42:49
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /xhs_app/lib/src/model/mine/profit_total_model.dart
 */
import 'package:json2dart_safe/json2dart.dart';

class ProfitTotalModel {
  double? grade;
  double? promRatio;
  double? proxyRatio;
  double? todayIncome;
  double? totalIncome;

  ProfitTotalModel(
      {this.grade,
      this.promRatio,
      this.proxyRatio,
      this.todayIncome,
      this.totalIncome});

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('grade', this.grade)
      ..put('promRatio', this.promRatio)
      ..put('proxyRatio', this.proxyRatio)
      ..put('todayIncome', this.todayIncome)
      ..put('totalIncome', this.totalIncome);
  }

  ProfitTotalModel.fromJson(Map<String, dynamic> json) {
    this.grade = json.asDouble('grade');
    this.promRatio = json.asDouble('promRatio');
    this.proxyRatio = json.asDouble('proxyRatio');
    this.todayIncome = json.asDouble('todayIncome');
    this.totalIncome = json.asDouble('totalIncome');
  }

  static ProfitTotalModel toBean(Map<String, dynamic> json) =>
      ProfitTotalModel.fromJson(json);
}
