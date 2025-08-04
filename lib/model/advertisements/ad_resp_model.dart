// import 'package:json2dart_safe/json2dart.dart';

// import '../../utils/enum.dart';

// class AdRspModel {
//   List<AdvertisementInfos>? advertisementInfos;
//   List<AdvertisementPlaces>? advertisementPlaces;
//   String? domain;

//   AdRspModel({
//     this.advertisementInfos,
//     this.advertisementPlaces,
//     this.domain,
//   });

//   Map<String, dynamic> toJson() {
//     return Map<String, dynamic>()
//       ..put('advertisementInfos',
//           this.advertisementInfos?.map((v) => v.toJson()).toList())
//       ..put('advertisementPlaces',
//           this.advertisementPlaces?.map((v) => v.toJson()).toList())
//       ..put('domain', this.domain);
//   }

//   AdRspModel.fromJson(Map<String, dynamic> json) {
//     this.advertisementInfos = json.asList<AdvertisementInfos>(
//         'advertisementInfos',
//         (v) => AdvertisementInfos.fromJson(Map<String, dynamic>.from(v)));
//     this.advertisementPlaces = json.asList<AdvertisementPlaces>(
//         'advertisementPlaces',
//         (v) => AdvertisementPlaces.fromJson(Map<String, dynamic>.from(v)));
//     this.domain = json.asString('domain');
//   }

//   static AdRspModel toBean(Map<String, dynamic> json) =>
//       AdRspModel.fromJson(json);
// }

// class AdvertisementInfos {
//   int? adId;
//   String? adImage;
//   String? adJump;
//   String? adName;
//   String? adPlay;
//   String? adSerialNumber;
//   int? adSort;
//   String? adStartTime;
//   String? adStopTime;
//   String? adType;
//   int? adWeight;
//   int? clickNum;
//   String? createdAt;
//   String? id;
//   int? jumpType;
//   int? minStaySecond;
//   String? ownerName;
//   String? placeId;
//   int? status;
//   int? todayIncome;
//   String? updatedAt;

//   AdvertisementInfos({
//     this.adId,
//     this.adImage,
//     this.adJump,
//     this.adName,
//     this.adPlay,
//     this.adSerialNumber,
//     this.adSort,
//     this.adStartTime,
//     this.adStopTime,
//     this.adType,
//     this.adWeight,
//     this.clickNum,
//     this.createdAt,
//     this.id,
//     this.jumpType,
//     this.minStaySecond,
//     this.ownerName,
//     this.placeId,
//     this.status,
//     this.todayIncome,
//     this.updatedAt,
//   });

//   Map<String, dynamic> toJson() {
//     return Map<String, dynamic>()
//       ..put('adId', this.adId)
//       ..put('adImage', this.adImage)
//       ..put('adJump', this.adJump)
//       ..put('adName', this.adName)
//       ..put('adPlay', this.adPlay)
//       ..put('adSerialNumber', this.adSerialNumber)
//       ..put('adSort', this.adSort)
//       ..put('adStartTime', this.adStartTime)
//       ..put('adStopTime', this.adStopTime)
//       ..put('adType', this.adType)
//       ..put('adWeight', this.adWeight)
//       ..put('clickNum', this.clickNum)
//       ..put('createdAt', this.createdAt)
//       ..put('id', this.id)
//       ..put('jumpType', this.jumpType)
//       ..put('minStaySecond', this.minStaySecond)
//       ..put('ownerName', this.ownerName)
//       ..put('placeId', this.placeId)
//       ..put('status', this.status)
//       ..put('todayIncome', this.todayIncome)
//       ..put('updatedAt', this.updatedAt);
//   }

//   AdvertisementInfos.fromJson(Map<String, dynamic> json) {
//     this.adId = json.asInt('adId');
//     this.adImage = json.asString('adImage');
//     this.adJump = json.asString('adJump');
//     this.adName = json.asString('adName');
//     this.adPlay = json.asString('adPlay');
//     this.adSerialNumber = json.asString('adSerialNumber');
//     this.adSort = json.asInt('adSort');
//     this.adStartTime = json.asString('adStartTime');
//     this.adStopTime = json.asString('adStopTime');
//     this.adType = json.asString('adType');
//     this.adWeight = json.asInt('adWeight');
//     this.clickNum = json.asInt('clickNum');
//     this.createdAt = json.asString('createdAt');
//     this.id = json.asString('id');
//     this.jumpType = json.asInt('jumpType');
//     this.minStaySecond = json.asInt('minStaySecond');
//     this.ownerName = json.asString('ownerName');
//     this.placeId = json.asString('placeId');
//     this.status = json.asInt('status');
//     this.todayIncome = json.asInt('todayIncome');
//     this.updatedAt = json.asString('updatedAt');
//   }
// }

// class AdvertisementPlaces {
//   int? adNumber;
//   AdPlaceEnum? adPlaceEnum;
//   String? createdAt;
//   String? id;
//   String? loadTypeEnum;
//   String? name;
//   String? nickName;
//   int? ruleIntervalNum;
//   String? updatedAt;

//   AdvertisementPlaces({
//     this.adNumber,
//     this.adPlaceEnum,
//     this.createdAt,
//     this.id,
//     this.loadTypeEnum,
//     this.name,
//     this.nickName,
//     this.ruleIntervalNum,
//     this.updatedAt,
//   });

//   Map<String, dynamic> toJson() {
//     return Map<String, dynamic>()
//       ..put('adNumber', this.adNumber)
//       ..put('adPlaceEnum', this.adPlaceEnum)
//       ..put('createdAt', this.createdAt)
//       ..put('id', this.id)
//       ..put('loadTypeEnum', this.loadTypeEnum)
//       ..put('name', this.name)
//       ..put('nickName', this.nickName)
//       ..put('ruleIntervalNum', this.ruleIntervalNum)
//       ..put('updatedAt', this.updatedAt);
//   }

//   AdvertisementPlaces.fromJson(Map<String, dynamic> json) {
//     this.adNumber = json.asInt('adNumber');
//     this.adPlaceEnum = json.asString('adPlaceEnum');
//     this.createdAt = json.asString('createdAt');
//     this.id = json.asString('id');
//     this.loadTypeEnum = json.asString('loadTypeEnum');
//     this.name = json.asString('name');
//     this.nickName = json.asString('nickName');
//     this.ruleIntervalNum = json.asInt('ruleIntervalNum');
//     this.updatedAt = json.asString('updatedAt');
//   }
// }
