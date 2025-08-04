class OtherClassListOtherTagListItem {
  String? id;
  int? classId;
  String? title;
  String? logo;
  int? sortNum;
  int? status;
  List<String>? tagList;
  String? type;
  String? createdAt;
  String? updatedAt;

  OtherClassListOtherTagListItem(
      {this.id,
        this.classId,
        this.title,
        this.logo,
        this.sortNum,
        this.status,
        this.tagList,
        this.type,
        this.createdAt,
        this.updatedAt});

  OtherClassListOtherTagListItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    classId = json['classId'];
    title = json['title'];
    logo = json['logo'];
    sortNum = json['sortNum'];
    status = json['status'];
    if(json['tagList']!=null) {
      tagList = (json['tagList'] as List).map((e)=>"$e").toList();
    }

    type = json['type'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['classId'] = this.classId;
    data['title'] = this.title;
    data['logo'] = this.logo;
    data['sortNum'] = this.sortNum;
    data['status'] = this.status;
    data['tagList'] = this.tagList;
    data['type'] = this.type;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
