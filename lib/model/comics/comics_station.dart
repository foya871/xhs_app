import 'package:json2dart_safe/json2dart.dart';
import 'package:xhs_app/model/comics/comics_base.dart';

class ComicsStationModel {
  List<ComicsBaseModel>? comicsBaseList;
  String? createdAt;
  List<GameResList>? gameResList;
  String? id;
  String? info;
  int? sortNum;
  int? stationId;
  String? stationName;
  bool? status;
  int? type;
  String? updatedAt;
  int? workNum;

  ComicsStationModel({
    this.comicsBaseList,
    this.createdAt,
    this.gameResList,
    this.id,
    this.info,
    this.sortNum,
    this.stationId,
    this.stationName,
    this.status,
    this.type,
    this.updatedAt,
    this.workNum,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('comicsBaseList', comicsBaseList?.map((v) => v.toJson()).toList())
      ..put('createdAt', createdAt)
      ..put('gameResList', gameResList?.map((v) => v.toJson()).toList())
      ..put('id', id)
      ..put('info', info)
      ..put('sortNum', sortNum)
      ..put('stationId', stationId)
      ..put('stationName', stationName)
      ..put('status', status)
      ..put('type', type)
      ..put('updatedAt', updatedAt)
      ..put('workNum', workNum);
  }

  ComicsStationModel.fromJson(Map<String, dynamic> json) {
    comicsBaseList = json.asList<ComicsBaseModel>('comicsBaseList',
        (v) => ComicsBaseModel.fromJson(Map<String, dynamic>.from(v)));
    createdAt = json.asString('createdAt');
    gameResList = json.asList<GameResList>('gameResList',
        (v) => GameResList.fromJson(Map<String, dynamic>.from(v)));
    id = json.asString('id');
    info = json.asString('info');
    sortNum = json.asInt('sortNum');
    stationId = json.asInt('stationId');
    stationName = json.asString('stationName');
    status = json.asBool('status');
    type = json.asInt('type');
    updatedAt = json.asString('updatedAt');
    workNum = json.asInt('workNum');
  }

  static ComicsStationModel toBean(Map<String, dynamic> json) =>
      ComicsStationModel.fromJson(json);
}

class ClassList {
  int? classId;
  String? title;

  ClassList({
    this.classId,
    this.title,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('classId', classId)
      ..put('title', title);
  }

  ClassList.fromJson(Map<String, dynamic> json) {
    classId = json.asInt('classId');
    title = json.asString('title');
  }
}

class StationList {
  int? stationId;
  String? stationName;

  StationList({
    this.stationId,
    this.stationName,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('stationId', stationId)
      ..put('stationName', stationName);
  }

  StationList.fromJson(Map<String, dynamic> json) {
    stationId = json.asInt('stationId');
    stationName = json.asString('stationName');
  }
}

class TagList {
  int? tagId;
  String? title;

  TagList({
    this.tagId,
    this.title,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('tagId', tagId)
      ..put('title', title);
  }

  TagList.fromJson(Map<String, dynamic> json) {
    tagId = json.asInt('tagId');
    title = json.asString('title');
  }
}

class ComicsBaseList {
  String? authorName;
  String? backImg;
  int? chapterNewNum;
  List<ClassList>? classList;
  int? comicsId;
  String? comicsTitle;
  String? coverImg;
  String? createdAt;
  int? fakeLikes;
  int? fakeWatchTimes;
  String? id;
  String? info;
  bool? isEnd;
  String? logo;
  String? nickName;
  int? realLikes;
  int? realWatchTimes;
  bool? recommend;
  List<StationList>? stationList;
  int? stationSort;
  int? status;
  List<TagList>? tagList;
  String? updatedAt;
  int? userId;

  ComicsBaseList({
    this.authorName,
    this.backImg,
    this.chapterNewNum,
    this.classList,
    this.comicsId,
    this.comicsTitle,
    this.coverImg,
    this.createdAt,
    this.fakeLikes,
    this.fakeWatchTimes,
    this.id,
    this.info,
    this.isEnd,
    this.logo,
    this.nickName,
    this.realLikes,
    this.realWatchTimes,
    this.recommend,
    this.stationList,
    this.stationSort,
    this.status,
    this.tagList,
    this.updatedAt,
    this.userId,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('authorName', authorName)
      ..put('backImg', backImg)
      ..put('chapterNewNum', chapterNewNum)
      ..put('classList', classList?.map((v) => v.toJson()).toList())
      ..put('comicsId', comicsId)
      ..put('comicsTitle', comicsTitle)
      ..put('coverImg', coverImg)
      ..put('createdAt', createdAt)
      ..put('fakeLikes', fakeLikes)
      ..put('fakeWatchTimes', fakeWatchTimes)
      ..put('id', id)
      ..put('info', info)
      ..put('isEnd', isEnd)
      ..put('logo', logo)
      ..put('nickName', nickName)
      ..put('realLikes', realLikes)
      ..put('realWatchTimes', realWatchTimes)
      ..put('recommend', recommend)
      ..put('stationList', stationList?.map((v) => v.toJson()).toList())
      ..put('stationSort', stationSort)
      ..put('status', status)
      ..put('tagList', tagList?.map((v) => v.toJson()).toList())
      ..put('updatedAt', updatedAt)
      ..put('userId', userId);
  }

  ComicsBaseList.fromJson(Map<String, dynamic> json) {
    authorName = json.asString('authorName');
    backImg = json.asString('backImg');
    chapterNewNum = json.asInt('chapterNewNum');
    classList = json.asList<ClassList>(
        'classList', (v) => ClassList.fromJson(Map<String, dynamic>.from(v)));
    comicsId = json.asInt('comicsId');
    comicsTitle = json.asString('comicsTitle');
    coverImg = json.asString('coverImg');
    createdAt = json.asString('createdAt');
    fakeLikes = json.asInt('fakeLikes');
    fakeWatchTimes = json.asInt('fakeWatchTimes');
    id = json.asString('id');
    info = json.asString('info');
    isEnd = json.asBool('isEnd');
    logo = json.asString('logo');
    nickName = json.asString('nickName');
    realLikes = json.asInt('realLikes');
    realWatchTimes = json.asInt('realWatchTimes');
    recommend = json.asBool('recommend');
    stationList = json.asList<StationList>('stationList',
        (v) => StationList.fromJson(Map<String, dynamic>.from(v)));
    stationSort = json.asInt('stationSort');
    status = json.asInt('status');
    tagList = json.asList<TagList>(
        'tagList', (v) => TagList.fromJson(Map<String, dynamic>.from(v)));
    updatedAt = json.asString('updatedAt');
    userId = json.asInt('userId');
  }
}

class HostType {
  Map<String, dynamic> toJson() {
    return <String, dynamic>{};
  }

  HostType.fromJson(Map<String, dynamic> json);
}

class GameResList {
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
  List<int>? hostType;
  bool? isFavorite;
  bool? isLock;
  bool? isLockCheatNum;
  String? pcDownUrl;
  int? priceGold;
  List<String>? publicityList;
  String? tag;

  GameResList({
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

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('buyNum', buyNum)
      ..put('cheatNum', cheatNum)
      ..put('cheatNumPrice', cheatNumPrice)
      ..put('coverPicture', coverPicture)
      ..put('downUrl', downUrl)
      ..put('gameCollectionIds', gameCollectionIds)
      ..put('gameId', gameId)
      ..put('gameIntroduction', gameIntroduction)
      ..put('gameVersion', gameVersion)
      ..put('gameName', gameName)
      ..put('hostType', hostType?.map((v) => v).toList())
      ..put('isFavorite', isFavorite)
      ..put('isLock', isLock)
      ..put('isLockCheatNum', isLockCheatNum)
      ..put('pcDownUrl', pcDownUrl)
      ..put('priceGold', priceGold)
      ..put('publicityList', publicityList)
      ..put('tag', tag);
  }

  GameResList.fromJson(Map<String, dynamic> json) {
    buyNum = json.asInt('buyNum');
    cheatNum = json.asString('cheatNum');
    cheatNumPrice = json.asInt('cheatNumPrice');
    coverPicture = json.asString('coverPicture');
    downUrl = json.asString('downUrl');
    gameCollectionIds = json.asList<int>('gameCollectionIds', null);
    gameId = json.asInt('gameId');
    gameIntroduction = json.asString('gameIntroduction');
    gameVersion = json.asString('gameVersion');
    gameName = json.asString('gameName');
    hostType = json.asList<int>('hostType', null);
    isFavorite = json.asBool('isFavorite');
    isLock = json.asBool('isLock');
    isLockCheatNum = json.asBool('isLockCheatNum');
    pcDownUrl = json.asString('pcDownUrl');
    priceGold = json.asInt('priceGold');
    publicityList = json.asList<String>('publicityList', null);
    tag = json.asString('tag');
  }
}
