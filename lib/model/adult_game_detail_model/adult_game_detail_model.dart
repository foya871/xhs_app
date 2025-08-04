import 'package:json2dart_safe/json2dart.dart';

class AdultGameDetailModel {
  int? buyNum;
  String? cheatNum;
  int? cheatNumPrice;
  String? coverPicture;
  String? downUrl;
  List<int>? gameCollectionIds;
  int? gameId;
  String? gameIntroduction;
  String? gameVersion;
  double? gameLastVersion;
  String? gameName;
  int? hostType;
  bool? isFavorite;
  bool? isLock;
  bool? isLockCheatNum;
  String? pcDownUrl;
  int? priceGold;
  List<String>? publicityList;
  String? tag;
  bool? hasCheatNum;

  AdultGameDetailModel({
    this.buyNum,
    this.cheatNum,
    this.cheatNumPrice,
    this.coverPicture,
    this.downUrl,
    this.gameCollectionIds,
    this.gameId,
    this.gameIntroduction,
    this.gameVersion,
    this.gameLastVersion,
    this.gameName,
    this.hostType,
    this.isFavorite,
    this.isLock,
    this.isLockCheatNum,
    this.pcDownUrl,
    this.priceGold,
    this.publicityList,
    this.tag,
    this.hasCheatNum,
  });

  factory AdultGameDetailModel.fromJson(Map<String, dynamic> json) {
    return AdultGameDetailModel(
      buyNum: json.asInt('buyNum'),
      cheatNum: json.asString('cheatNum'),
      cheatNumPrice: json.asInt('cheatNumPrice'),
      coverPicture: json.asString('coverPicture'),
      downUrl: json.asString('downUrl'),
      gameCollectionIds: json.asList<int>('gameCollectionIds',
          (v) => v is int ? v : int.tryParse(v.toString()) ?? 0),
      gameId: json.asInt('gameId'),
      gameIntroduction: json.asString('gameIntroduction'),
      gameVersion: json.asString('gameVersion'),
      gameLastVersion: (json['gameLastVersion'] as num?)?.toDouble(),
      gameName: json.asString('gameName'),
      hostType: json.asInt('hostType'),
      isFavorite: json.asBool('isFavorite'),
      isLock: json.asBool('isLock'),
      isLockCheatNum: json.asBool('isLockCheatNum'),
      pcDownUrl: json.asString('pcDownUrl'),
      priceGold: json.asInt('priceGold'),
      publicityList: json.asList<String>('publicityList', (v) => v.toString()),
      tag: json.asString('tag'),
      hasCheatNum: json.asBool('hasCheatNum'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'buyNum': buyNum,
      'cheatNum': cheatNum,
      'cheatNumPrice': cheatNumPrice,
      'coverPicture': coverPicture,
      'downUrl': downUrl,
      'gameCollectionIds': gameCollectionIds,
      'gameId': gameId,
      'gameIntroduction': gameIntroduction,
      'gameVersion': gameVersion,
      'gameLastVersion': gameLastVersion,
      'gameName': gameName,
      'hostType': hostType,
      'isFavorite': isFavorite,
      'isLock': isLock,
      'isLockCheatNum': isLockCheatNum,
      'pcDownUrl': pcDownUrl,
      'priceGold': priceGold,
      'publicityList': publicityList,
      'tag': tag,
      'hasCheatNum': hasCheatNum,
    };
  }
}

extension AdultGameDetailModelExtension on AdultGameDetailModel {
  String get hostTypeStr {
    switch (hostType) {
      case 0:
        return 'Android_Pc';
      case 1:
        return 'Android';
      case 2:
        return 'pc';
      default:
        return '';
    }
  }
}
