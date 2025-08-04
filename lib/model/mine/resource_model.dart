import 'package:json2dart_safe/json2dart.dart';

class ResourceModel {
  bool? blogger; //是否博主
  int? classifyId; //分类Id
  String? classifyTitle; //分类名称
  String? coverImg; //封面
  String? createdAt; //发布时间
  String? extractionCode; //提取码
  int? fakeLikes; //伪造点赞次数
  bool? hasResourceLink; //是否有链接
  List<String>? images; //图片
  String? info; //资源内容
  bool? isLike; //是否点赞
  bool? isUnlock; //是否已解锁
  String? logo; //头像
  String? nickName; //用户昵称
  double? price; //价格
  int? resourceId; //资源id
  String? resourceLink; //链接
  String? resourcePassWord; //密码
  int? resourcesMark; //1-vip，2-付费
  String? title; //资源标题
  int? userId; //发布者ID
  bool? isSelected;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('blogger', blogger)
      ..put('classifyId', classifyId)
      ..put('classifyTitle', classifyTitle)
      ..put('coverImg', coverImg)
      ..put('createdAt', createdAt)
      ..put('extractionCode', extractionCode)
      ..put('fakeLikes', fakeLikes)
      ..put('hasResourceLink', hasResourceLink)
      ..put('images', images)
      ..put('info', info)
      ..put('isLike', isLike)
      ..put('isUnlock', isUnlock)
      ..put('logo', logo)
      ..put('nickName', nickName)
      ..put('price', price)
      ..put('resourceId', resourceId)
      ..put('resourceLink', resourceLink)
      ..put('resourcePassWord', resourcePassWord)
      ..put('resourcesMark', resourcesMark)
      ..put('title', title)
      ..put('userId', userId)
      ..put('isSelected', isSelected);
  }

  ResourceModel.fromJson(Map<String, dynamic> json) {
    blogger = json.asBool('blogger');
    classifyId = json.asInt('classifyId');
    classifyTitle = json.asString('classifyTitle');
    coverImg = json.asString('coverImg');
    createdAt = json.asString('createdAt');
    extractionCode = json.asString('extractionCode');
    fakeLikes = json.asInt('fakeLikes');
    hasResourceLink = json.asBool('hasResourceLink');
    images = json.asList<String>('images', null);
    info = json.asString('info');
    isLike = json.asBool('isLike');
    isUnlock = json.asBool('isUnlock');
    logo = json.asString('logo');
    nickName = json.asString('nickName');
    price = json.asDouble('price');
    resourceId = json.asInt('resourceId');
    resourceLink = json.asString('resourceLink');
    resourcePassWord = json.asString('resourcePassWord');
    resourcesMark = json.asInt('resourcesMark');
    title = json.asString('title');
    userId = json.asInt('userId');
    isSelected = json.asBool('isSelected');
  }

  dynamic toBean(Map<String, dynamic> json) => ResourceModel.fromJson(json);
}
