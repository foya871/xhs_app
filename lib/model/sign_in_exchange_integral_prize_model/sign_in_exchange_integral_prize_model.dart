import 'package:json2dart_safe/json2dart.dart';
import 'prize_list.dart';

class SignInExchangeIntegralPrizeModel {
  int? integral;
  List<PrizeList>? prizeList;

  SignInExchangeIntegralPrizeModel({
    this.integral,
    this.prizeList,
  });

  factory SignInExchangeIntegralPrizeModel.fromJson(Map<String, dynamic> json) {
    return SignInExchangeIntegralPrizeModel(
      integral: json.asInt('integral'),
      prizeList: json.asList<PrizeList>(
          'prizeList', (v) => PrizeList.fromJson(v as Map<String, dynamic>)),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'integral': integral,
      'prizeList': prizeList?.map((e) => e.toJson()).toList(),
    };
  }
}
