class TagListOtherTagListItem {
  String? id;
  int? classifyId;
  String? title;
  int? status;
  int? sortNum;
  String? createdAt;
  String? updatedAt;

  TagListOtherTagListItem(
      {this.id,
        this.classifyId,
        this.title,
        this.status,
        this.sortNum,
        this.createdAt,
        this.updatedAt});

  TagListOtherTagListItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    classifyId = json['classifyId'];
    title = json['title'];
    status = json['status'];
    sortNum = json['sortNum'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['classifyId'] = this.classifyId;
    data['title'] = this.title;
    data['status'] = this.status;
    data['sortNum'] = this.sortNum;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
