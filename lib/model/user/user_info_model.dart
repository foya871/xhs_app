/*
 * @Author: wangdazhuang
 * @Date: 2024-08-15 17:24:29
 * @LastEditTime: 2024-10-16 19:13:06
 * @LastEditors: ziqi jhzq12345678
 * @Description: 
 * @FilePath: /xhs_app/lib/src/model/user/user_info_model.dart
 */
import 'package:hive/hive.dart';
import 'package:json2dart_safe/json2dart.dart';

import '../../utils/enum.dart';

@HiveType(typeId: 12)
class UserInfo extends HiveObject {
  String? account;
  int? adultGameFreeNum;
  int? aiNum;
  int? aiMovie;
  String? area;
  bool? attentionHe;
  bool? attention;
  String? bgImg;
  String? bgImgReview;
  int? bgImgStatus;
  bool? bindAccount;
  bool? blogger;
  int? bu;
  String? bust;
  String? cityName;
  String? expiredAIVip;
  String? expiredGold;
  String? expiredVip;
  String? chatExpiredVip;
  int? favoritesNum;
  bool? forbiddenWord;
  String? freeVip;
  int? freeWatches;
  bool? gameVip;
  int? gender;
  int? goldWatchNum;
  String? imgDomain;
  String? inviteCode;
  int? inviteUserNum;
  int? level;
  int? likedNum;
  int? resourcesResidueNum;

////登陆状态 1-登陆中 2-已退出
  int? loginStatus;
  String? logo;
  String? mobile;
  String? nickName;
  int? noticeNotReadNum;
  String? personSign;
  int? playNum;
  String? proxyCode;
  int? proxyGrade;
  bool? recharge;
  String? token;
  int? ua;
  UserUpType? upType;
  int? userId;
  double? vipGoldVideoDis;
  int? vipType;
  int? chatVipType;
  int? watched;
  int? workNum;
  bool? isInterest;
  int? chatMsgNum; //剩余聊天次数
  int? dynNum; //帖子数
  int? longVideoNum; //长视频数
  int? shortVideoNum; //短视频数
  int? collectionNum; //合集数
  bool? hasFansGroup; //粉丝团专属数
  bool? hasChatRoom; //是否有群聊
  bool? hasCollection; //是否有合集
  int? infoNum; //资讯数
  int? playlistNum; //播单数
  String? birthday; //生日
  int? height; //身高
  int? weight; //体重
  String? prefer; //偏好
  String? bodyShape; //体型
  String? emotion; //感情状况
  String? intention; //交友目的
  List<String>? newFans;
  int? fansGroupNum;
  bool? fansMember;
  int? age;

  UserInfo({
    this.account,
    this.adultGameFreeNum,
    this.aiNum,
    this.aiMovie,
    this.area,
    this.attentionHe,
    this.attention,
    this.bgImg,
    this.bgImgReview,
    this.bgImgStatus,
    this.bindAccount,
    this.blogger,
    this.bu,
    this.bust,
    this.cityName,
    this.expiredAIVip,
    this.expiredGold,
    this.expiredVip,
    this.chatExpiredVip,
    this.favoritesNum,
    this.forbiddenWord,
    this.freeVip,
    this.freeWatches,
    this.gameVip,
    this.gender,
    this.goldWatchNum,
    this.imgDomain,
    this.inviteCode,
    this.inviteUserNum,
    this.level,
    this.likedNum,
    this.loginStatus,
    this.logo,
    this.mobile,
    this.nickName,
    this.noticeNotReadNum,
    this.personSign,
    this.playNum,
    this.proxyCode,
    this.proxyGrade,
    this.recharge,
    this.token,
    this.ua,
    this.upType,
    this.userId,
    this.vipGoldVideoDis,
    this.vipType,
    this.chatVipType,
    this.watched,
    this.workNum,
    this.isInterest,
    this.chatMsgNum,
    this.dynNum,
    this.longVideoNum,
    this.shortVideoNum,
    this.infoNum,
    this.playlistNum,
    this.birthday,
    this.height,
    this.weight,
    this.prefer,
    this.bodyShape,
    this.emotion,
    this.intention,
    this.fansGroupNum,
    this.age,
    this.hasFansGroup,
    this.hasChatRoom,
    this.hasCollection,
    this.fansMember,
    this.resourcesResidueNum,
  });

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>()
      ..put('account', this.account)
      ..put('adultGameFreeNum', this.adultGameFreeNum)
      ..put('aiNum', this.aiNum)
      ..put('aiMovie', this.aiMovie)
      ..put('area', this.area)
      ..put('attentionHe', this.attentionHe)
      ..put('attention', this.attention)
      ..put('bgImg', this.bgImg)
      ..put('bgImgReview', this.bgImgReview)
      ..put('bgImgStatus', this.bgImgStatus)
      ..put('bindAccount', this.bindAccount)
      ..put('blogger', this.blogger)
      ..put('bu', this.bu)
      ..put('bust', this.bust)
      ..put('cityName', this.cityName)
      ..put('expiredAIVip', this.expiredAIVip)
      ..put('expiredGold', this.expiredGold)
      ..put('expiredVip', this.expiredVip)
      ..put('chatExpiredVip', this.chatExpiredVip)
      ..put('favoritesNum', this.favoritesNum)
      ..put('forbiddenWord', this.forbiddenWord)
      ..put('freeVip', this.freeVip)
      ..put('freeWatches', this.freeWatches)
      ..put('gameVip', this.gameVip)
      ..put('gender', this.gender)
      ..put('goldWatchNum', this.goldWatchNum)
      ..put('imgDomain', this.imgDomain)
      ..put('inviteCode', this.inviteCode)
      ..put('inviteUserNum', this.inviteUserNum)
      ..put('level', this.level)
      ..put('likedNum', this.likedNum)
      ..put('loginStatus', this.loginStatus)
      ..put('logo', this.logo)
      ..put('mobile', this.mobile)
      ..put('nickName', this.nickName)
      ..put('noticeNotReadNum', this.noticeNotReadNum)
      ..put('personSign', this.personSign)
      ..put('playNum', this.playNum)
      ..put('proxyCode', this.proxyCode)
      ..put('proxyGrade', this.proxyGrade)
      ..put('recharge', this.recharge)
      ..put('token', this.token)
      ..put('ua', this.ua)
      ..put('upType', this.upType)
      ..put('userId', this.userId)
      ..put('vipGoldVideoDis', this.vipGoldVideoDis)
      ..put('vipType', this.vipType)
      ..put('chatVipType', this.chatVipType)
      ..put('watched', this.watched)
      ..put('workNum', this.workNum)
      ..put('isInterest', this.workNum)
      ..put('chatMsgNum', this.chatMsgNum)
      ..put('dynNum', this.dynNum)
      ..put('longVideoNum', this.longVideoNum)
      ..put('shortVideoNum', this.shortVideoNum)
      ..put('collectionNum', this.collectionNum)
      ..put('hasFansGroup', this.hasFansGroup)
      ..put('hasChatRoom', this.hasChatRoom)
      ..put('hasCollection', this.hasCollection)
      ..put('newFans', this.newFans)
      ..put('infoNum', this.infoNum)
      ..put('playlistNum', this.playlistNum)
      ..put('birthday', this.birthday)
      ..put('height', this.height)
      ..put('weight', this.weight)
      ..put('prefer', this.prefer)
      ..put('bodyShape', this.bodyShape)
      ..put('emotion', this.emotion)
      ..put('intention', this.intention)
      ..put('fansGroupNum', this.fansGroupNum)
      ..put('age', this.age)
      ..put('fansMember', this.fansMember)
      ..put('resourcesResidueNum', this.resourcesResidueNum);
  }

  UserInfo.fromJson(Map<String, dynamic> json) {
    this.account = json.asString('account');
    this.adultGameFreeNum = json.asInt('adultGameFreeNum');
    this.aiNum = json.asInt('aiNum');
    this.aiMovie = json.asInt('aiMovie');
    this.area = json.asString('area');
    this.attentionHe = json.asBool('attentionHe');
    this.attention = json.asBool('attention');
    this.bgImg = json.asString('bgImg');
    this.bgImgReview = json.asString('bgImgReview');
    this.bgImgStatus = json.asInt('bgImgStatus');
    this.bindAccount = json.asBool('bindAccount');
    this.blogger = json.asBool('blogger');
    this.bu = json.asInt('bu');
    this.bust = json.asString('bust');
    this.cityName = json.asString('cityName');
    this.expiredAIVip = json.asString('expiredAIVip');
    this.expiredGold = json.asString('expiredGold');
    this.expiredVip = json.asString('expiredVip');
    this.chatExpiredVip = json.asString('chatExpiredVip');
    this.favoritesNum = json.asInt('favoritesNum');
    this.forbiddenWord = json.asBool('forbiddenWord');
    this.freeVip = json.asString('freeVip');
    this.freeWatches = json.asInt('freeWatches');
    this.gameVip = json.asBool('gameVip');
    this.gender = json.asInt('gender');
    this.goldWatchNum = json.asInt('goldWatchNum');
    this.imgDomain = json.asString('imgDomain');
    this.inviteCode = json.asString('inviteCode');
    this.inviteUserNum = json.asInt('inviteUserNum');
    this.level = json.asInt('level');
    this.age = json.asInt('age');
    this.likedNum = json.asInt('likedNum');
    this.loginStatus = json.asInt('loginStatus');
    this.logo = json.asString('logo');
    this.mobile = json.asString('mobile');
    this.nickName = json.asString('nickName');
    this.noticeNotReadNum = json.asInt('noticeNotReadNum');
    this.personSign = json.asString('personSign');
    this.playNum = json.asInt('playNum');
    this.proxyCode = json.asString('proxyCode');
    this.proxyGrade = json.asInt('proxyGrade');
    this.recharge = json.asBool('recharge');
    this.token = json.asString('token');
    this.ua = json.asInt('ua');
    this.upType = json.asInt('upType');
    this.userId = json.asInt('userId');
    this.vipGoldVideoDis = json.asDouble('vipGoldVideoDis');
    this.vipType = json.asInt('vipType');
    this.chatVipType = json.asInt('chatVipType');
    this.watched = json.asInt('watched');
    this.workNum = json.asInt('workNum');
    this.isInterest = json.asBool('isInterest');
    this.chatMsgNum = json.asInt('chatMsgNum');
    this.dynNum = json.asInt('dynNum');
    this.longVideoNum = json.asInt('longVideoNum');
    this.shortVideoNum = json.asInt('shortVideoNum');
    this.collectionNum = json.asInt('collectionNum');
    this.hasFansGroup = json.asBool('hasFansGroup');
    this.hasChatRoom = json.asBool('hasChatRoom');
    this.hasCollection = json.asBool('hasCollection');
    this.infoNum = json.asInt('infoNum');
    this.playlistNum = json.asInt('playlistNum');
    this.birthday = json.asString('birthday');
    this.height = json.asInt('height');
    this.weight = json.asInt('weight');
    this.prefer = json.asString('prefer');
    this.bodyShape = json.asString('bodyShape');
    this.emotion = json.asString('emotion');
    this.intention = json.asString('intention');
    this.newFans = json.asList<String>('newFans', null);
    this.fansGroupNum = json.asInt('fansGroupNum');
    this.fansMember = json.asBool('fansMember');
    this.age = json.asInt('age');
    this.resourcesResidueNum = json.asInt('resourcesResidueNum');
  }

  static UserInfo toBean(Map<String, dynamic> json) => UserInfo.fromJson(json);
}
