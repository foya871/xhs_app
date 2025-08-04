class ComicDetailModel {
  String? domain;
  int? comicsId;
  String? comicsTitle;
  String? coverImg;
  String? backImg;
  List<String>? stationList;
  List<TagList>? tagList;
  List<String>? classList;
  String? authorName;
  String? info;
  int? chapterNewNum;
  bool? isEnd;
  int? fakeLikes;
  int? fakeWatchTimes;
  int? userId;
  int? payType;
  String? nickName;
  String? logo;
  bool? isLike;
  List<ChapterList>? chapterList;
  String? purRecord;
  int? lastReadChapterId;
  String? createdAt;
  String? updatedAt;

  ComicDetailModel(
      {this.domain,
        this.comicsId,
        this.comicsTitle,
        this.coverImg,
        this.backImg,
        this.stationList,
        this.tagList,
        this.classList,
        this.authorName,
        this.info,
        this.chapterNewNum,
        this.isEnd,
        this.fakeLikes,
        this.fakeWatchTimes,
        this.userId,
        this.payType,
        this.nickName,
        this.logo,
        this.isLike,
        this.chapterList,
        this.purRecord,
        this.lastReadChapterId,
        this.createdAt,
        this.updatedAt});

  ComicDetailModel.fromJson(Map<String, dynamic> json) {
    domain = json['domain'];
    comicsId = json['comicsId'];
    comicsTitle = json['comicsTitle'];
    coverImg = json['coverImg'];
    backImg = json['backImg'];


    if (json['stationList'] != null) {
      stationList = <String>[];
      json['stationList'].forEach((v) {
        stationList!.add("$v");
      });
    }


    if (json['tagList'] != null) {
      tagList = <TagList>[];
      json['tagList'].forEach((v) {
        tagList!.add(new TagList.fromJson(v));
      });
    }
    if (json['classList'] != null) {
      classList = <String>[];
      json['classList'].forEach((v) {
        classList!.add("$v");
      });
    }



    authorName = json['authorName'];
    info = json['info'];
    chapterNewNum = json['chapterNewNum'];
    isEnd = json['isEnd'];
    fakeLikes = json['fakeLikes'];
    fakeWatchTimes = json['fakeWatchTimes'];
    userId = json['userId'];
    payType = json['payType'];
    nickName = json['nickName'];
    logo = json['logo'];
    isLike = json['isLike'];
    if (json['chapterList'] != null) {
      chapterList = <ChapterList>[];
      json['chapterList'].forEach((v) {
        chapterList!.add(new ChapterList.fromJson(v));
      });
    }
    purRecord = json['purRecord'];
    lastReadChapterId = json['lastReadChapterId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['domain'] = this.domain;
    data['comicsId'] = this.comicsId;
    data['comicsTitle'] = this.comicsTitle;
    data['coverImg'] = this.coverImg;
    data['backImg'] = this.backImg;
    data['stationList'] = this.stationList;
    if (this.tagList != null) {
      data['tagList'] = this.tagList!.map((v) => v.toJson()).toList();
    }
    data['classList'] = this.classList;
    data['authorName'] = this.authorName;
    data['info'] = this.info;
    data['chapterNewNum'] = this.chapterNewNum;
    data['isEnd'] = this.isEnd;
    data['fakeLikes'] = this.fakeLikes;
    data['fakeWatchTimes'] = this.fakeWatchTimes;
    data['userId'] = this.userId;
    data['payType'] = this.payType;
    data['nickName'] = this.nickName;
    data['logo'] = this.logo;
    data['isLike'] = this.isLike;
    if (this.chapterList != null) {
      data['chapterList'] = this.chapterList!.map((v) => v.toJson()).toList();
    }
    data['purRecord'] = this.purRecord;
    data['lastReadChapterId'] = this.lastReadChapterId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class TagList {
  int? tagId;
  String? title;

  TagList({this.tagId, this.title});

  TagList.fromJson(Map<String, dynamic> json) {
    tagId = json['tagId'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tagId'] = this.tagId;
    data['title'] = this.title;
    return data;
  }
}

class ChapterList {
  int? chapterId;
  String? chapterTitle;
  String? coverImg;
  int? chapterNum;
  int? comicsId;
  int? fakeWatchTimes;
  String? createdAt;

  ChapterList(
      {this.chapterId,
        this.chapterTitle,
        this.coverImg,
        this.chapterNum,
        this.comicsId,
        this.fakeWatchTimes,
        this.createdAt});

  ChapterList.fromJson(Map<String, dynamic> json) {
    chapterId = json['chapterId'];
    chapterTitle = json['chapterTitle'];
    coverImg = json['coverImg'];
    chapterNum = json['chapterNum'];
    comicsId = json['comicsId'];
    fakeWatchTimes = json['fakeWatchTimes'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chapterId'] = this.chapterId;
    data['chapterTitle'] = this.chapterTitle;
    data['coverImg'] = this.coverImg;
    data['chapterNum'] = this.chapterNum;
    data['comicsId'] = this.comicsId;
    data['fakeWatchTimes'] = this.fakeWatchTimes;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
