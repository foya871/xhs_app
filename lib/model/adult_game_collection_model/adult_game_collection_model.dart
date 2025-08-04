import 'package:json2dart_safe/json2dart.dart';

class AdultGameCollectionModel {
  int? gameCollectionId;
  String? gameCollectionName;

  AdultGameCollectionModel({
    this.gameCollectionId,
    this.gameCollectionName,
  });

  factory AdultGameCollectionModel.fromJson(Map<String, dynamic> json) {
    return AdultGameCollectionModel(
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
