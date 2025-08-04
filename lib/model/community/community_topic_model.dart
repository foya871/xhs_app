import 'package:json2dart_safe/json2dart.dart';

class CommunityTopicModel {
  String? id; //话题id
  String? introduction; //话题简介
  String? logo; //话题头像
  String? name; //话题名
  String? refreshAt; //帖子更新时间
  int? participate; //参与人数
  List<String>? participateLogo; //参与人头像
  int? postNum; //话题动态数
  int? subscribeNum; //圈子参加人数
  bool? isAttention;
  bool? isMore;
  bool? subscribe;
  bool? selected;
  bool? participated;

  CommunityTopicModel.empty() : this.fromJson({});

  CommunityTopicModel.add(String this.name, String this.introduction);

  CommunityTopicModel.addMore(String this.name, bool this.isMore);

  CommunityTopicModel({
    this.id,
    this.introduction,
    this.logo,
    this.name,
    this.refreshAt,
    this.participate,
    this.participateLogo,
    this.postNum,
    this.subscribeNum,
    this.isAttention,
    this.isMore,
    this.subscribe,
    this.selected,
    this.participated,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('id', id)
      ..put('introduction', introduction)
      ..put('logo', logo)
      ..put('name', name)
      ..put('refreshAt', refreshAt)
      ..put('participate', participate)
      ..put('participateLogo', participateLogo)
      ..put('postNum', postNum)
      ..put('subscribeNum', subscribeNum)
      ..put('isAttention', isAttention)
      ..put('subscribe', subscribe)
      ..put('selected', selected)
      ..put('participated', participated)
      ..put('isMore', isMore);
  }

  CommunityTopicModel.fromJson(Map<String, dynamic> json) {
    id = json.asString('id');
    introduction = json.asString('introduction');
    logo = json.asString('logo');
    name = json.asString('name');
    refreshAt = json.asString('refreshAt');
    participate = json.asInt('participate');
    participateLogo = json.asList<String>('participateLogo');
    postNum = json.asInt('postNum');
    subscribeNum = json.asInt('subscribeNum');
    isAttention = json.asBool('isAttention');
    isMore = json.asBool('isMore');
    selected = json.asBool('selected');
    participated = json.asBool('participated');
    subscribe = json.asBool('subscribe');
  }

  static CommunityTopicModel toBean(dynamic json) =>
      CommunityTopicModel.fromJson(json);
}
