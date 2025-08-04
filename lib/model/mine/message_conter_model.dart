class MessageConterModel {
  int? consumerUserId;
  String? content;
  String? createdAt;
  int? gold;
  int? informationType;
  String? msgActionDesc;
  int? producerIdentity;
  String? producerLogo;
  String? producerName;
  int? producerUserId;
  QuoteMsg? quoteMsg;
  int? ticketType;
  bool? attentionHe;
  String? updatedAt;

  MessageConterModel(
      {this.consumerUserId,
      this.content,
      this.createdAt,
      this.gold,
      this.informationType,
      this.msgActionDesc,
      this.producerIdentity,
      this.producerLogo,
      this.producerName,
      this.producerUserId,
      this.quoteMsg,
      this.ticketType,
      this.updatedAt});

  MessageConterModel.fromJson(Map<String, dynamic> json) {
    consumerUserId = json['consumerUserId'];
    content = json['content'];
    createdAt = json['createdAt'];
    gold = json['gold'];
    informationType = json['informationType'];
    msgActionDesc = json['msgActionDesc'];
    producerIdentity = json['producerIdentity'];
    producerLogo = json['producerLogo'];
    producerName = json['producerName'];
    producerUserId = json['producerUserId'];
    quoteMsg = json['quoteMsg'] != null
        ? new QuoteMsg.fromJson(json['quoteMsg'])
        : null;
    ticketType = json['ticketType'];
    attentionHe = json['attentionHe'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['consumerUserId'] = this.consumerUserId;
    data['content'] = this.content;
    data['createdAt'] = this.createdAt;
    data['gold'] = this.gold;
    data['informationType'] = this.informationType;
    data['msgActionDesc'] = this.msgActionDesc;
    data['producerIdentity'] = this.producerIdentity;
    data['producerLogo'] = this.producerLogo;
    data['producerName'] = this.producerName;
    data['producerUserId'] = this.producerUserId;
    if (this.quoteMsg != null) {
      data['quoteMsg'] = this.quoteMsg?.toJson();
    }
    data['ticketType'] = this.ticketType;
    data['attentionHe'] = this.attentionHe;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class QuoteMsg {
  String? quoteSubContent;
  int? quoteSubId;
  String? quoteSubImg;
  int? quoteSubImgType;
  int? quoteSubLinkType;
  int? quoteSubType;

  QuoteMsg(
      {this.quoteSubContent,
      this.quoteSubId,
      this.quoteSubImg,
      this.quoteSubImgType,
      this.quoteSubLinkType,
      this.quoteSubType});

  QuoteMsg.fromJson(Map<String, dynamic> json) {
    quoteSubContent = json['quoteSubContent'];
    quoteSubId = json['quoteSubId'];
    quoteSubImg = json['quoteSubImg'];
    quoteSubImgType = json['quoteSubImgType'];
    quoteSubLinkType = json['quoteSubLinkType'];
    quoteSubType = json['quoteSubType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quoteSubContent'] = this.quoteSubContent;
    data['quoteSubId'] = this.quoteSubId;
    data['quoteSubImg'] = this.quoteSubImg;
    data['quoteSubImgType'] = this.quoteSubImgType;
    data['quoteSubLinkType'] = this.quoteSubLinkType;
    data['quoteSubType'] = this.quoteSubType;
    return data;
  }
}
