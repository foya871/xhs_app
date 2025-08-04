import 'package:json2dart_safe/json2dart.dart';

class PrivateMessageDetailModel {
  int? chatMsgNum;
  int? distance;
  List<Products>? products;

  PrivateMessageDetailModel({
    this.chatMsgNum,
    this.distance,
    this.products,
  });

  PrivateMessageDetailModel.fromJson(Map<String, dynamic> json) {
    chatMsgNum = json.asInt('chatMsgNum');
    distance = json.asInt('distance', -9999);
    products = json.asList<Products>(
        'products', (v) => Products.fromJson(Map<String, dynamic>.from(v)));
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('chatMsgNum', chatMsgNum)
      ..put('distance', distance)
      ..put('products', this.products?.map((v) => v.toJson()).toList());
  }

  static PrivateMessageDetailModel toBean(Map<String, dynamic> json) =>
      PrivateMessageDetailModel.fromJson(json);
}

class Products {
  String? createdAt;
  int? msgNum;
  int? price;
  int? productId;
  bool? status;
  String? updatedAt;

  Products.fromJson(Map<String, dynamic> json) {
    createdAt = json.asString('createdAt');
    msgNum = json.asInt('msgNum');
    price = json.asInt('price');
    productId = json.asInt('productId');
    status = json.asBool('status');
    updatedAt = json.asString('updatedAt');
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('createdAt', createdAt)
      ..put('msgNum', msgNum)
      ..put('price', price)
      ..put('productId', productId)
      ..put('status', status)
      ..put('updatedAt', updatedAt);
  }

  static Products toBean(Map<String, dynamic> json) => Products.fromJson(json);
}
