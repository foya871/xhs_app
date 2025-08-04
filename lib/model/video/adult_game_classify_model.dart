import 'package:json2dart_safe/json2dart.dart';

class AdultGameClassifyModel {
  int? total;
  List<Data>? data;
  String? domain;

  AdultGameClassifyModel({
    this.total,
    this.data,
    this.domain,
  });

  factory AdultGameClassifyModel.fromJson(Map<String, dynamic> json) {
    return AdultGameClassifyModel(
      total: json.asInt('total'),
      data: json.asList<Data>(
          'data', (v) => Data.fromJson(v as Map<String, dynamic>)),
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

class Data {
  int? gameCollectionId;
  String? gameCollectionName;

  Data({
    this.gameCollectionId,
    this.gameCollectionName,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      gameCollectionId: json.asInt('gameCollectionId'),
      gameCollectionName: json.asString('gameCollectionName'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'gameCollectionId': gameCollectionId,
      'gameCollectionName': gameCollectionName,
    };
  }
}
