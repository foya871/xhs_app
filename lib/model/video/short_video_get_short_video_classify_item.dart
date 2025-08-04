class ShortVideoGetShortVideoClassify {
  String? id;
  int? classifyId;
  String? classifyTitle;
  String? type;
  int? sortNum;
  bool? appShow;
  int? mark;
  bool? defaultSelected;
  String? createdAt;
  String? updatedAt;

  ShortVideoGetShortVideoClassify(
      {this.id,
        this.classifyId,
        this.classifyTitle,
        this.type,
        this.sortNum,
        this.appShow,
        this.mark,
        this.defaultSelected,
        this.createdAt,
        this.updatedAt});

  ShortVideoGetShortVideoClassify.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    classifyId = json['classifyId'];
    classifyTitle = json['classifyTitle'];
    type = json['type'];
    sortNum = json['sortNum'];
    appShow = json['appShow'];
    mark = json['mark'];
    defaultSelected = json['defaultSelected'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['classifyId'] = this.classifyId;
    data['classifyTitle'] = this.classifyTitle;
    data['type'] = this.type;
    data['sortNum'] = this.sortNum;
    data['appShow'] = this.appShow;
    data['mark'] = this.mark;
    data['defaultSelected'] = this.defaultSelected;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
