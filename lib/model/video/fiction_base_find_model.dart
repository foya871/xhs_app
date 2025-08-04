class FictionBaseFindModel {
  int? fictionId;
  String? fictionTitle;
  String? coverImg;
  int? fictionType;
  String? fictionSpace;
  String? tagList;
  String? info;
  int? fakeLikes;
  int? fakeWatchTimes;
  int? chapterNewNum;
  bool? end;
  bool? watched;
  String? updatedAt;

  FictionBaseFindModel(
      {this.fictionId,
        this.fictionTitle,
        this.coverImg,
        this.fictionType,
        this.fictionSpace,
        this.tagList,
        this.info,
        this.fakeLikes,
        this.fakeWatchTimes,
        this.chapterNewNum,
        this.end,
        this.watched,
        this.updatedAt});

  FictionBaseFindModel.fromJson(Map<String, dynamic> json) {
    fictionId = json['fictionId'];
    fictionTitle = json['fictionTitle'];
    coverImg = json['coverImg'];
    fictionType = json['fictionType'];
    fictionSpace = json['fictionSpace'];
    tagList = json['tagList'];
    info = json['info'];
    fakeLikes = json['fakeLikes'];
    fakeWatchTimes = json['fakeWatchTimes'];
    chapterNewNum = json['chapterNewNum'];
    end = json['end'];
    watched = json['watched'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fictionId'] = this.fictionId;
    data['fictionTitle'] = this.fictionTitle;
    data['coverImg'] = this.coverImg;
    data['fictionType'] = this.fictionType;
    data['fictionSpace'] = this.fictionSpace;
    data['tagList'] = this.tagList;
    data['info'] = this.info;
    data['fakeLikes'] = this.fakeLikes;
    data['fakeWatchTimes'] = this.fakeWatchTimes;
    data['chapterNewNum'] = this.chapterNewNum;
    data['end'] = this.end;
    data['watched'] = this.watched;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
