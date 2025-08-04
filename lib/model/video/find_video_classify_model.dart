class FindVideoClassifyModel {
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

  FindVideoClassifyModel(
      {this.comicsId,
        this.comicsTitle,
        this.info,
        this.coverImg,
        this.chapterNewNum,
        this.isEnd,
        this.watched,
        this.fakeLikes,
        this.fakeWatchTimes,
        this.createdAt});

  FindVideoClassifyModel.fromJson(Map<String, dynamic> json) {
    comicsId = json['comicsId'];
    comicsTitle = json['comicsTitle'];
    info = json['info'];
    coverImg = json['coverImg'];
    chapterNewNum = json['chapterNewNum'];
    isEnd = json['isEnd'];
    watched = json['watched'];
    fakeLikes = json['fakeLikes'];
    fakeWatchTimes = json['fakeWatchTimes'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['comicsId'] = this.comicsId;
    data['comicsTitle'] = this.comicsTitle;
    data['info'] = this.info;
    data['coverImg'] = this.coverImg;
    data['chapterNewNum'] = this.chapterNewNum;
    data['isEnd'] = this.isEnd;
    data['watched'] = this.watched;
    data['fakeLikes'] = this.fakeLikes;
    data['fakeWatchTimes'] = this.fakeWatchTimes;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
