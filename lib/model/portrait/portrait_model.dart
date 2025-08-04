/// classifyId : 0
/// createdAt : "2025-02-25T12:56:32.180Z"
/// id : "string"
/// sortNum : 0
/// status : 0
/// title : "string"
/// updatedAt : "2025-02-25T12:56:32.180Z"

class PortraitModel {
  PortraitModel({
      num? classifyId, 
      String? createdAt, 
      String? id, 
      num? sortNum, 
      num? status, 
      String? title, 
      String? updatedAt,}){
    _classifyId = classifyId;
    _createdAt = createdAt;
    _id = id;
    _sortNum = sortNum;
    _status = status;
    _title = title;
    _updatedAt = updatedAt;
}

  PortraitModel.fromJson(dynamic json) {
    _classifyId = json['classifyId'];
    _createdAt = json['createdAt'];
    _id = json['id'];
    _sortNum = json['sortNum'];
    _status = json['status'];
    _title = json['title'];
    _updatedAt = json['updatedAt'];
  }
  num? _classifyId;
  String? _createdAt;
  String? _id;
  num? _sortNum;
  num? _status;
  String? _title;
  String? _updatedAt;
PortraitModel copyWith({  num? classifyId,
  String? createdAt,
  String? id,
  num? sortNum,
  num? status,
  String? title,
  String? updatedAt,
}) => PortraitModel(  classifyId: classifyId ?? _classifyId,
  createdAt: createdAt ?? _createdAt,
  id: id ?? _id,
  sortNum: sortNum ?? _sortNum,
  status: status ?? _status,
  title: title ?? _title,
  updatedAt: updatedAt ?? _updatedAt,
);
  num? get classifyId => _classifyId;
  String? get createdAt => _createdAt;
  String? get id => _id;
  num? get sortNum => _sortNum;
  num? get status => _status;
  String? get title => _title;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['classifyId'] = _classifyId;
    map['createdAt'] = _createdAt;
    map['id'] = _id;
    map['sortNum'] = _sortNum;
    map['status'] = _status;
    map['title'] = _title;
    map['updatedAt'] = _updatedAt;
    return map;
  }

}