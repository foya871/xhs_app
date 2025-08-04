import 'package:json2dart_safe/json2dart.dart';
import '../adult_game_model/adult_game_model.dart';

class AdultGameResp {
  int? total;
  List<AdultGameModel>? data;
  String? domain;

  AdultGameResp({
    this.total,
    this.data,
    this.domain,
  });

  factory AdultGameResp.fromJson(Map<String, dynamic> json) {
    return AdultGameResp(
      total: json.asInt('total'),
      data: json.asList<AdultGameModel>(
          'data', (v) => AdultGameModel.fromJson(v as Map<String, dynamic>)),
      domain: json.asString('domain'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'data': data?.map((e) => e.toJson()).toList(),
      'domain': domain,
    };
  }
}
