class IntensionMapDetailComment {
  String? id;
  int? commentId;
  int? type;
  int? parentId;
  int? connotationId;
  int? userId;
  String? nickName;
  String? logo;
  int? vipType;
  String? content;
  int? commentType;
  String? img;
  String? beUserId;
  String? beUserName;
  int? fakeLikes;
  int? replyNum;
  String? createdAt;
  bool? isLike;
  bool? officialComment;
  bool? jump;
  String? jumpType;
  String? jumpUrl;

  IntensionMapDetailComment(
      {this.id,
        this.commentId,
        this.type,
        this.parentId,
        this.connotationId,
        this.userId,
        this.nickName,
        this.logo,
        this.vipType,
        this.content,
        this.commentType,
        this.img,
        this.beUserId,
        this.beUserName,
        this.fakeLikes,
        this.replyNum,
        this.createdAt,
        this.isLike,
        this.officialComment,
        this.jump,
        this.jumpType,
        this.jumpUrl});

  IntensionMapDetailComment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    commentId = json['commentId'];
    type = json['type'];
    parentId = json['parentId'];
    connotationId = json['connotationId'];
    userId = json['userId'];
    nickName = json['nickName'];
    logo = json['logo'];
    vipType = json['vipType'];
    content = json['content'];
    commentType = json['commentType'];
    img = json['img'];
    beUserId = json['beUserId'];
    beUserName = json['beUserName'];
    fakeLikes = json['fakeLikes'];
    replyNum = json['replyNum'];
    createdAt = json['createdAt'];
    isLike = json['isLike'];
    officialComment = json['officialComment'];
    jump = json['jump'];
    jumpType = json['jumpType'];
    jumpUrl = json['jumpUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['commentId'] = this.commentId;
    data['type'] = this.type;
    data['parentId'] = this.parentId;
    data['connotationId'] = this.connotationId;
    data['userId'] = this.userId;
    data['nickName'] = this.nickName;
    data['logo'] = this.logo;
    data['vipType'] = this.vipType;
    data['content'] = this.content;
    data['commentType'] = this.commentType;
    data['img'] = this.img;
    data['beUserId'] = this.beUserId;
    data['beUserName'] = this.beUserName;
    data['fakeLikes'] = this.fakeLikes;
    data['replyNum'] = this.replyNum;
    data['createdAt'] = this.createdAt;
    data['isLike'] = this.isLike;
    data['officialComment'] = this.officialComment;
    data['jump'] = this.jump;
    data['jumpType'] = this.jumpType;
    data['jumpUrl'] = this.jumpUrl;
    return data;
  }
}
