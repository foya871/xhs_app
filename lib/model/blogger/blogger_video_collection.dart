import 'package:json2dart_safe/json2dart.dart';

class BloggerVideoCollectionModel {
  final int collectionId;
  final String collectionName;
  final String coverImg;
  final String createdAt;
  final String logo;
  final String nickName;
  final int sortNum;
  final String updatedAt;
  final int userId;
  final int videoNum;

  BloggerVideoCollectionModel.empty() : this.fromJson({});

  BloggerVideoCollectionModel.fromJson(Map<String, dynamic> json)
      : collectionId = json.asInt('collectionId'),
        collectionName = json.asString('collectionName'),
        coverImg = json.asString('coverImg'),
        createdAt = json.asString('createdAt'),
        logo = json.asString('logo'),
        nickName = json.asString('nickName'),
        sortNum = json.asInt('sortNum'),
        updatedAt = json.asString('updatedAt'),
        userId = json.asInt('userId'),
        videoNum = json.asInt('videoNum');

  static dynamic toBean(dynamic json) =>
      BloggerVideoCollectionModel.fromJson(json);
}

class CollectionDetailModel {
  final int collectionId;
  final String collectionName;
  final String coverImg;
  bool favorite;
  final String logo;
  final String nickName;
  final int userId;
  final int videoNum;

  bool get isEmpty => collectionId == 0;

  CollectionDetailModel.empty() : this.fromJson({});

  CollectionDetailModel.fromJson(Map<String, dynamic> json)
      : collectionId = json.asInt('collectionId'),
        collectionName = json.asString('collectionName'),
        coverImg = json.asString('coverImg'),
        favorite = json.asBool('favorite'),
        logo = json.asString('logo'),
        nickName = json.asString('nickName'),
        userId = json.asInt('userId'),
        videoNum = json.asInt('videoNum');

  static dynamic toBean(dynamic json) => CollectionDetailModel.fromJson(json);
}
