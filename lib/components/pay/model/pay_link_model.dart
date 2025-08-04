import 'package:json2dart_safe/json2dart.dart';

class PayLinkModel {
  final String url;

  Map<String, dynamic> toJson() => {'url': url};

  PayLinkModel.fromJson(Map<String, dynamic> json) : url = json.asString('url');

  static dynamic toBean(dynamic json) => PayLinkModel.fromJson(json);
}
