import 'package:json2dart_safe/json2dart.dart';

class SearchVideoModel{
  List<VideoList>? videoList;
  List<DynamicList>? dynamicList;
  List<ComicsListRes>? comicsListRes;
  List<FictionListList>? fictionListList;
  List<PictureList>? pictureList;
  List<BloggerList>? bloggerList;
  List<ConnotationList>? connotationList;
  String? resourcesList;
  String? domain;

  SearchVideoModel({this.videoList,this.dynamicList,this.comicsListRes,this.fictionListList,this.pictureList,this.bloggerList,this.connotationList,this.resourcesList,this.domain,});

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('videoList',this.videoList?.map((v)=>v.toJson()).toList())
      ..put('dynamicList', this.dynamicList?.map((v)=>v.toJson()).toList())
      ..put('comicsListRes',this.comicsListRes?.map((v)=>v.toJson()).toList())
      ..put('fictionListList',this.fictionListList?.map((v)=>v.toJson()).toList())
      ..put('pictureList',this.pictureList?.map((v)=>v.toJson()).toList())
      ..put('bloggerList',this.bloggerList?.map((v)=>v.toJson()).toList())
      ..put('connotationList',this.connotationList?.map((v)=>v.toJson()).toList())
      ..put('resourcesList',this.resourcesList)
      ..put('domain',this.domain);
  }

  SearchVideoModel.fromJson(Map<String, dynamic> json) {
    this.videoList=json.asList<VideoList>('videoList',(v)=>VideoList.fromJson(v as Map<String, dynamic>));
    this.dynamicList=json.asList<DynamicList>('dynamicList',(v)=>DynamicList.fromJson(v as Map<String, dynamic>));
    this.comicsListRes=json.asList<ComicsListRes>('comicsListRes',(v)=>ComicsListRes.fromJson(v as Map<String, dynamic>));
    this.fictionListList=json.asList<FictionListList>('fictionListList',(v)=>FictionListList.fromJson(v as Map<String, dynamic>));
    this.pictureList=json.asList<PictureList>('pictureList',(v)=>PictureList.fromJson(v as Map<String, dynamic>));
    this.bloggerList=json.asList<BloggerList>('bloggerList',(v)=>BloggerList.fromJson(v as Map<String, dynamic>));
    this.connotationList=json.asList<ConnotationList>('connotationList',(v)=>ConnotationList.fromJson(v as Map<String, dynamic>));
    this.resourcesList=json.asString('resourcesList');
    this.domain=json.asString('domain');
  }

  static SearchVideoModel toBean(Map<String, dynamic> json) => SearchVideoModel.fromJson(json);
}

class DynamicList{
  int? dynamicId;
  int? dynamicType;
  int? userId;
  String? title;
  String? contentText;
  List<String>? images;
  Video? video;
  int? imgNum;
  String? playTime;
  bool? isLike;
  bool? isFavorite;
  int? fakeLikes;
  int? fakeFavorites;
  int? fakeWatchTimes;
  int? commentNum;
  String? nickName;
  String? logo;
  int? gender;
  int? vipType;
  bool? blogger;
  bool? topDynamic;
  bool? featured;
  int? status;
  String? notPass;
  bool? isAttention;
  int? bu;
  String? jumpType;
  String? jumpUrl;
  String? checkAt;
  int? dynamicMark;
  int? price;
  String? classifyTitle;
  List<String>? topic;
  String? collectionName;
  bool? exclusiveToFans;

  DynamicList({this.dynamicId,this.dynamicType,this.userId,this.title,this.contentText,this.images,this.video,this.imgNum,this.playTime,this.isLike,this.isFavorite,this.fakeLikes,this.fakeFavorites,this.fakeWatchTimes,this.commentNum,this.nickName,this.logo,this.gender,this.vipType,this.blogger,this.topDynamic,this.featured,this.status,this.notPass,this.isAttention,this.bu,this.jumpType,this.jumpUrl,this.checkAt,this.dynamicMark,this.price,this.classifyTitle,this.topic,this.collectionName,this.exclusiveToFans,});

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('dynamicId',this.dynamicId)
      ..put('dynamicType',this.dynamicType)
      ..put('userId',this.userId)
      ..put('title',this.title)
      ..put('contentText',this.contentText)
      ..put('images',this.images)
      ..put('video',this.video?.toJson())
      ..put('imgNum',this.imgNum)
      ..put('playTime',this.playTime)
      ..put('isLike',this.isLike)
      ..put('isFavorite',this.isFavorite)
      ..put('fakeLikes',this.fakeLikes)
      ..put('fakeFavorites',this.fakeFavorites)
      ..put('fakeWatchTimes',this.fakeWatchTimes)
      ..put('commentNum',this.commentNum)
      ..put('nickName',this.nickName)
      ..put('logo',this.logo)
      ..put('gender',this.gender)
      ..put('vipType',this.vipType)
      ..put('blogger',this.blogger)
      ..put('topDynamic',this.topDynamic)
      ..put('featured',this.featured)
      ..put('status',this.status)
      ..put('notPass',this.notPass)
      ..put('isAttention',this.isAttention)
      ..put('bu',this.bu)
      ..put('jumpType',this.jumpType)
      ..put('jumpUrl',this.jumpUrl)
      ..put('checkAt',this.checkAt)
      ..put('dynamicMark',this.dynamicMark)
      ..put('price',this.price)
      ..put('classifyTitle',this.classifyTitle)
      ..put('topic',this.topic)
      ..put('collectionName',this.collectionName)
      ..put('exclusiveToFans',this.exclusiveToFans);
  }

  DynamicList.fromJson(Map<String, dynamic> json) {
    this.dynamicId=json.asInt('dynamicId');
    this.dynamicType=json.asInt('dynamicType');
    this.userId=json.asInt('userId');
    this.title=json.asString('title');
    this.contentText=json.asString('contentText');
    this.images=json.asList<String>('images',null);
    this.video=json.asBean('video',(v)=>Video.fromJson(v as Map<String, dynamic>));
    this.imgNum=json.asInt('imgNum');
    this.playTime=json.asString('playTime');
    this.isLike=json.asBool('isLike');
    this.isFavorite=json.asBool('isFavorite');
    this.fakeLikes=json.asInt('fakeLikes');
    this.fakeFavorites=json.asInt('fakeFavorites');
    this.fakeWatchTimes=json.asInt('fakeWatchTimes');
    this.commentNum=json.asInt('commentNum');
    this.nickName=json.asString('nickName');
    this.logo=json.asString('logo');
    this.gender=json.asInt('gender');
    this.vipType=json.asInt('vipType');
    this.blogger=json.asBool('blogger');
    this.topDynamic=json.asBool('topDynamic');
    this.featured=json.asBool('featured');
    this.status=json.asInt('status');
    this.notPass=json.asString('notPass');
    this.isAttention=json.asBool('isAttention');
    this.bu=json.asInt('bu');
    this.jumpType=json.asString('jumpType');
    this.jumpUrl=json.asString('jumpUrl');
    this.checkAt=json.asString('checkAt');
    this.dynamicMark=json.asInt('dynamicMark');
    this.price=json.asInt('price');
    this.classifyTitle=json.asString('classifyTitle');
    this.topic=json.asList<String>('topic',null);
    this.collectionName=json.asString('collectionName');
    this.exclusiveToFans=json.asBool('exclusiveToFans');
  }

  static DynamicList toBean(Map<String, dynamic> json) => DynamicList.fromJson(json);
}

class Video{
  String? id;
  String? title;
  String? resourceTitle;
  String? videoUrl;
  String? coverImg;
  int? playTime;
  int? height;
  int? width;
  int? videoMark;
  String? authKey;

  Video({this.id,this.title,this.resourceTitle,this.videoUrl,this.coverImg,this.playTime,this.height,this.width,this.videoMark,this.authKey,});

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('id',this.id)
      ..put('title',this.title)
      ..put('resourceTitle',this.resourceTitle)
      ..put('videoUrl',this.videoUrl)
      ..put('coverImg',this.coverImg)
      ..put('playTime',this.playTime)
      ..put('height',this.height)
      ..put('width',this.width)
      ..put('videoMark',this.videoMark)
      ..put('authKey',this.authKey);
  }

  Video.fromJson(Map<String, dynamic> json) {
    this.id=json.asString('id');
    this.title=json.asString('title');
    this.resourceTitle=json.asString('resourceTitle');
    this.videoUrl=json.asString('videoUrl');
    this.coverImg=json.asString('coverImg');
    this.playTime=json.asInt('playTime');
    this.height=json.asInt('height');
    this.width=json.asInt('width');
    this.videoMark=json.asInt('videoMark');
    this.authKey=json.asString('authKey');
  }
}

class BloggerList{
  int? userId;
  String? nickName;
  String? logo;
  int? workNum;
  int? bu;
  bool? attention;

  BloggerList({this.userId,this.nickName,this.logo,this.workNum,this.bu,this.attention,});

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('userId',this.userId)
      ..put('nickName',this.nickName)
      ..put('logo',this.logo)
      ..put('workNum',this.workNum)
      ..put('bu',this.bu)
      ..put('attention',this.attention);
  }

  BloggerList.fromJson(Map<String, dynamic> json) {
    this.userId=json.asInt('userId');
    this.nickName=json.asString('nickName');
    this.logo=json.asString('logo');
    this.workNum=json.asInt('workNum');
    this.bu=json.asInt('bu');
    this.attention=json.asBool('attention');
  }

  static BloggerList toBean(Map<String, dynamic> json) => BloggerList.fromJson(json);
}

class ComicsListRes{
  int? comicsId;
  String? comicsTitle;
  String? info;
  String? coverImg;
  int? chapterNewNum;
  bool? isEnd;
  bool? watched;
  int? fakeLikes;
  int? fakeWatchTimes;
  String? createdAt;

  ComicsListRes({this.comicsId,this.comicsTitle,this.info,this.coverImg,this.chapterNewNum,this.isEnd,this.watched,this.fakeLikes,this.fakeWatchTimes,this.createdAt,});

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('comicsId',this.comicsId)
      ..put('comicsTitle',this.comicsTitle)
      ..put('info',this.info)
      ..put('coverImg',this.coverImg)
      ..put('chapterNewNum',this.chapterNewNum)
      ..put('isEnd',this.isEnd)
      ..put('watched',this.watched)
      ..put('fakeLikes',this.fakeLikes)
      ..put('fakeWatchTimes',this.fakeWatchTimes)
      ..put('createdAt',this.createdAt);
  }

  ComicsListRes.fromJson(Map<String, dynamic> json) {
    this.comicsId=json.asInt('comicsId');
    this.comicsTitle=json.asString('comicsTitle');
    this.info=json.asString('info');
    this.coverImg=json.asString('coverImg');
    this.chapterNewNum=json.asInt('chapterNewNum');
    this.isEnd=json.asBool('isEnd');
    this.watched=json.asBool('watched');
    this.fakeLikes=json.asInt('fakeLikes');
    this.fakeWatchTimes=json.asInt('fakeWatchTimes');
    this.createdAt=json.asString('createdAt');
  }

  static ComicsListRes toBean(Map<String, dynamic> json) => ComicsListRes.fromJson(json);
}

class FictionListList{
  int? fictionId;
  String? fictionTitle;
  String? coverImg;
  int? fictionType;
  int? fictionSpace;
  List<TagList>? tagList;
  String? info;
  int? fakeLikes;
  int? fakeWatchTimes;
  int? chapterNewNum;
  bool? end;
  bool? watched;
  String? updatedAt;

  FictionListList({this.fictionId,this.fictionTitle,this.coverImg,this.fictionType,this.fictionSpace,this.tagList,this.info,this.fakeLikes,this.fakeWatchTimes,this.chapterNewNum,this.end,this.watched,this.updatedAt,});

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('fictionId',this.fictionId)
      ..put('fictionTitle',this.fictionTitle)
      ..put('coverImg',this.coverImg)
      ..put('fictionType',this.fictionType)
      ..put('fictionSpace',this.fictionSpace)
      ..put('tagList', this.tagList?.map((v)=>v.toJson()).toList())
      ..put('info',this.info)
      ..put('fakeLikes',this.fakeLikes)
      ..put('fakeWatchTimes',this.fakeWatchTimes)
      ..put('chapterNewNum',this.chapterNewNum)
      ..put('end',this.end)
      ..put('watched',this.watched)
      ..put('updatedAt',this.updatedAt);
  }

  FictionListList.fromJson(Map<String, dynamic> json) {
    this.fictionId=json.asInt('fictionId');
    this.fictionTitle=json.asString('fictionTitle');
    this.coverImg=json.asString('coverImg');
    this.fictionType=json.asInt('fictionType');
    this.fictionSpace=json.asInt('fictionSpace');
    this.tagList=json.asList<TagList>('tagList',(v)=>TagList.fromJson(v as Map<String, dynamic>));
    this.info=json.asString('info');
    this.fakeLikes=json.asInt('fakeLikes');
    this.fakeWatchTimes=json.asInt('fakeWatchTimes');
    this.chapterNewNum=json.asInt('chapterNewNum');
    this.end=json.asBool('end');
    this.watched=json.asBool('watched');
    this.updatedAt=json.asString('updatedAt');
  }

  static FictionListList toBean(Map<String, dynamic> json) => FictionListList.fromJson(json);
}

class TagList{
  int? tagId;
  String? title;

  TagList({this.tagId,this.title,});

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('tagId',this.tagId)
      ..put('title',this.title);
  }

  TagList.fromJson(Map<String, dynamic> json) {
    this.tagId=json.asInt('tagId');
    this.title=json.asString('title');
  }
}

class PictureList{
  String? coverImg;
  int? fakeFavoritesNum;
  bool? favorite;
  int? favoritesNum;
  List<String>? imgList;
  int? imgNum;
  int? portrayPicId;
  String? title;

  PictureList({this.coverImg,this.fakeFavoritesNum,this.favorite,this.favoritesNum,this.imgList,this.imgNum,this.portrayPicId,this.title,});

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('coverImg',this.coverImg)
      ..put('fakeFavoritesNum',this.fakeFavoritesNum)
      ..put('favorite',this.favorite)
      ..put('favoritesNum',this.favoritesNum)
      ..put('imgList',this.imgList)
      ..put('imgNum',this.imgNum)
      ..put('portrayPicId',this.portrayPicId)
      ..put('title',this.title);
  }

  PictureList.fromJson(Map<String, dynamic> json) {
    this.coverImg=json.asString('coverImg');
    this.fakeFavoritesNum=json.asInt('fakeFavoritesNum');
    this.favorite=json.asBool('favorite');
    this.favoritesNum=json.asInt('favoritesNum');
    this.imgList=json.asList<String>('imgList',null);
    this.imgNum=json.asInt('imgNum');
    this.portrayPicId=json.asInt('portrayPicId');
    this.title=json.asString('title');
  }

  static PictureList toBean(Map<String, dynamic> json) => PictureList.fromJson(json);
}

class ConnotationList{
  int? connotationId;
  String? title;
  String? summary;
  String? coverImg;
  String? checkAt;

  ConnotationList({this.connotationId,this.title,this.summary,this.coverImg,this.checkAt,});

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('connotationId',this.connotationId)
      ..put('title',this.title)
      ..put('summary',this.summary)
      ..put('coverImg',this.coverImg)
      ..put('checkAt',this.checkAt);
  }

  ConnotationList.fromJson(Map<String, dynamic> json) {
    this.connotationId=json.asInt('connotationId');
    this.title=json.asString('title');
    this.summary=json.asString('summary');
    this.coverImg=json.asString('coverImg');
    this.checkAt=json.asString('checkAt');
  }

  static ConnotationList toBean(Map<String, dynamic> json) => ConnotationList.fromJson(json);
}


class VideoList{
  int? videoId;
  String? title;
  String? subtitle;
  String? videoUrl;
  String? previewUrl;
  String? coverImg;
  String? verticalImg;
  int? price;
  String? disPrice;
  List<String>? tagTitles;
  String? like;
  int? playTime;
  int? size;
  int? userId;
  int? videoType;
  int? buyType;
  int? fakeWatchNum;
  int? fakeLikes;
  int? fakeShareNum;
  int? fakeFavorites;
  int? commentNum;
  int? featuredOrFans;
  int? incomeCount;
  String? playPath;
  int? videoMark;
  String? collectionName;
  String? nickName;
  String? logo;
  bool? attention;
  int? serialVideoNum;
  String? reviewDate;
  String? createdAt;
  String? updatedAt;

  VideoList({this.videoId,this.title,this.subtitle,this.videoUrl,this.previewUrl,this.coverImg,this.verticalImg,this.price,this.disPrice,this.tagTitles,this.like,this.playTime,this.size,this.userId,this.videoType,this.buyType,this.fakeWatchNum,this.fakeLikes,this.fakeShareNum,this.fakeFavorites,this.commentNum,this.featuredOrFans,this.incomeCount,this.playPath,this.videoMark,this.collectionName,this.nickName,this.logo,this.attention,this.serialVideoNum,this.reviewDate,this.createdAt,this.updatedAt,});

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('videoId',this.videoId)
      ..put('title',this.title)
      ..put('subtitle',this.subtitle)
      ..put('videoUrl',this.videoUrl)
      ..put('previewUrl',this.previewUrl)
      ..put('coverImg',this.coverImg)
      ..put('verticalImg',this.verticalImg)
      ..put('price',this.price)
      ..put('disPrice',this.disPrice)
      ..put('tagTitles',this.tagTitles)
      ..put('like',this.like)
      ..put('playTime',this.playTime)
      ..put('size',this.size)
      ..put('userId',this.userId)
      ..put('videoType',this.videoType)
      ..put('buyType',this.buyType)
      ..put('fakeWatchNum',this.fakeWatchNum)
      ..put('fakeLikes',this.fakeLikes)
      ..put('fakeShareNum',this.fakeShareNum)
      ..put('fakeFavorites',this.fakeFavorites)
      ..put('commentNum',this.commentNum)
      ..put('featuredOrFans',this.featuredOrFans)
      ..put('incomeCount',this.incomeCount)
      ..put('playPath',this.playPath)
      ..put('videoMark',this.videoMark)
      ..put('collectionName',this.collectionName)
      ..put('nickName',this.nickName)
      ..put('logo',this.logo)
      ..put('attention',this.attention)
      ..put('serialVideoNum',this.serialVideoNum)
      ..put('reviewDate',this.reviewDate)
      ..put('createdAt',this.createdAt)
      ..put('updatedAt',this.updatedAt);
  }

  VideoList.fromJson(Map<String, dynamic> json) {
    this.videoId=json.asInt('videoId');
    this.title=json.asString('title');
    this.subtitle=json.asString('subtitle');
    this.videoUrl=json.asString('videoUrl');
    this.previewUrl=json.asString('previewUrl');
    this.coverImg=json.asString('coverImg');
    this.verticalImg=json.asString('verticalImg');
    this.price=json.asInt('price');
    this.disPrice=json.asString('disPrice');
    this.tagTitles=json.asList<String>('tagTitles',null);
    this.like=json.asString('like');
    this.playTime=json.asInt('playTime');
    this.size=json.asInt('size');
    this.userId=json.asInt('userId');
    this.videoType=json.asInt('videoType');
    this.buyType=json.asInt('buyType');
    this.fakeWatchNum=json.asInt('fakeWatchNum');
    this.fakeLikes=json.asInt('fakeLikes');
    this.fakeShareNum=json.asInt('fakeShareNum');
    this.fakeFavorites=json.asInt('fakeFavorites');
    this.commentNum=json.asInt('commentNum');
    this.featuredOrFans=json.asInt('featuredOrFans');
    this.incomeCount=json.asInt('incomeCount');
    this.playPath=json.asString('playPath');
    this.videoMark=json.asInt('videoMark');
    this.collectionName=json.asString('collectionName');
    this.nickName=json.asString('nickName');
    this.logo=json.asString('logo');
    this.attention=json.asBool('attention');
    this.serialVideoNum=json.asInt('serialVideoNum');
    this.reviewDate=json.asString('reviewDate');
    this.createdAt=json.asString('createdAt');
    this.updatedAt=json.asString('updatedAt');
  }

  static VideoList toBean(Map<String, dynamic> json) => VideoList.fromJson(json);
}
