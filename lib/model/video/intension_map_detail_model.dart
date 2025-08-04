class IntensionMapDetailModel {
  int? total;
  List<IntensionMapDetailModelData>? data;
  String? domain;
  bool? isLike;
  int? fakeLikes;
  int? commentNum;

  IntensionMapDetailModel(
      {this.total,
        this.data,
        this.domain,
        this.isLike,
        this.fakeLikes,
        this.commentNum});

  IntensionMapDetailModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['data'] != null) {
      data = <IntensionMapDetailModelData>[];
      (json['data'] as List).forEach((v) {
        data!.add(new IntensionMapDetailModelData.fromJson(v));
      });
    }
    domain = json['domain'];
    isLike = json['isLike'];
    fakeLikes = json['fakeLikes'];
    commentNum = json['commentNum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['domain'] = this.domain;
    data['isLike'] = this.isLike;
    data['fakeLikes'] = this.fakeLikes;
    data['commentNum'] = this.commentNum;
    return data;
  }
}

class IntensionMapDetailModelData {
  int? type;
  String? text;
  List<String>? images;
  List<String>? video;

  IntensionMapDetailModelData({this.type, this.text, this.images, this.video});

  IntensionMapDetailModelData.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    text = json['text'];
    if(json['images']!=null) {
      images = (json['images'] as List).map((e)=>"$e").toList();
    }
    if(json['video']!=null) {
      video = (json['video'] as List).map((e)=>"$e").toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['text'] = this.text;
    data['images'] = this.images;
    data['video'] = this.video;
    return data;
  }
}
