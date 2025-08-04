import 'package:json2dart_safe/json2dart.dart';

class BloggerFansTicketModel{
  int? groupId;
  int? ticketPrice;
  int? ticketType;
  int? userId;

  BloggerFansTicketModel({this.groupId,this.ticketPrice,this.ticketType,this.userId,});

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('groupId',this.groupId)
      ..put('ticketPrice',this.ticketPrice)
      ..put('ticketType',this.ticketType)
      ..put('userId',this.userId);
  }

  BloggerFansTicketModel.fromJson(Map<String, dynamic> json) {
    this.groupId=json.asInt('groupId');
    this.ticketPrice=json.asInt('ticketPrice');
    this.ticketType=json.asInt('ticketType');
    this.userId=json.asInt('userId');
  }

  static BloggerFansTicketModel toBean(Map<String, dynamic> json) => BloggerFansTicketModel.fromJson(json);
}