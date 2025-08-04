import 'package:json2dart_safe/json2dart.dart';
import 'package:xhs_app/components/ad/ad_enum.dart';

class AdultGameModel {
  int? buyNum;
  String? cheatNum;
  int? cheatNumPrice;
  String? coverPicture;
  String? downUrl;
  List<int>? gameCollectionIds;
  int? gameId;
  String? gameIntroduction;
  String? gameVersion;
  String? gameName;
  int? hostType;
  bool? isFavorite;
  bool? isLock;
  bool? isLockCheatNum;
  String? pcDownUrl;
  int? priceGold;
  List<String>? publicityList;
  String? tag;

  // 前端
  AdApiType? ad;

  bool get isAd => ad != null;
  AdultGameModel.fromAd(this.ad) : gameId = -987654321;

  AdultGameModel({
    this.buyNum,
    this.cheatNum,
    this.cheatNumPrice,
    this.coverPicture,
    this.downUrl,
    this.gameCollectionIds,
    this.gameId,
    this.gameIntroduction,
    this.gameVersion,
    this.gameName,
    this.hostType,
    this.isFavorite,
    this.isLock,
    this.isLockCheatNum,
    this.pcDownUrl,
    this.priceGold,
    this.publicityList,
    this.tag,
  });

  factory AdultGameModel.fromJson(Map<String, dynamic> json) {
    return AdultGameModel(
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
      gameName: json.asString('gameName'),
      hostType: json.asInt('hostType'),
      isFavorite: json.asBool('isFavorite'),
      isLock: json.asBool('isLock'),
      isLockCheatNum: json.asBool('isLockCheatNum'),
      pcDownUrl: json.asString('pcDownUrl'),
      priceGold: json.asInt('priceGold'),
      publicityList: json.asList<String>('publicityList', (v) => v.toString()),
      tag: json.asString('tag'),
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
      'gameName': gameName,
      'hostType': hostType,
      'isFavorite': isFavorite,
      'isLock': isLock,
      'isLockCheatNum': isLockCheatNum,
      'pcDownUrl': pcDownUrl,
      'priceGold': priceGold,
      'publicityList': publicityList,
      'tag': tag,
    };
  }
}
