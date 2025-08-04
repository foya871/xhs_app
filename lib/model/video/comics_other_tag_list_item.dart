class ComicsOtherTagListItem {
  String? id;
  int? tagId;
  String? title;
  int? sortNum;
  int? status;
  String? createdAt;
  String? updatedAt;
  ComicsOtherTagListItem(
      {this.id,
        this.tagId,
        this.title,
        this.sortNum,
        this.status,
        this.createdAt,
        this.updatedAt});

  ComicsOtherTagListItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tagId = json['tagId'];
    title = json['title'];
    sortNum = json['sortNum'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tagId'] = this.tagId;
    data['title'] = this.title;
    data['sortNum'] = this.sortNum;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
