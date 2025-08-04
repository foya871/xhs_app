import 'package:json2dart_safe/json2dart.dart';

class AdInfoModel {
  AdInformation? adInformation;
  String? apkLink;
  int? insertIntervalsNum;
  String? name;
  String? link;
  int? labelType;
  String? id;
  List<AdStations>? stations;
  String? adPlace;
  int? importanceNum;
  int? minStaySecond;
  String? adDescription;
  int? weightSum;

  bool get isEmpty => id == null || id!.isEmpty;

  ///
  String get adId => id ?? '';

  String get adImage => adInformation?.adImagePath ?? '';

  String get adName => name ?? '';

  String get adJump => link ?? '';

  String get desc => adDescription ?? '';

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('adInformation', adInformation?.toJson())
      ..put('apkLink', apkLink)
      ..put('minStaySecond', minStaySecond)
      ..put('insertIntervalsNum', insertIntervalsNum)
      ..put('name', name)
      ..put('link', link)
      ..put('labelType', labelType)
      ..put('id', id)
      ..put('stations', stations?.map((v) => v.toJson()).toList())
      ..put('adPlace', adPlace)
      ..put('adDescription', adDescription)
      ..put('importanceNum', importanceNum);
  }

  AdInfoModel.fromJson(Map<String, dynamic> json) {
    adInformation = json.asBean('adInformation',
        (v) => AdInformation.fromJson(Map<String, dynamic>.from(v)));
    apkLink = json.asString('apkLink');
    insertIntervalsNum = json.asInt('insertIntervalsNum');
    name = json.asString('name');
    link = json.asString('link');
    labelType = json.asInt('labelType');
    id = json.asString('id');
    adDescription = json.asString('adDescription');
    minStaySecond = json.asInt("minStaySecond");
    stations = json.asList<AdStations>(
        'stations', (v) => AdStations.fromJson(Map<String, dynamic>.from(v)));
    adPlace = json.asString('adPlace');
    importanceNum = json.asInt('importanceNum');
  }

  static AdInfoModel toBean(Map<String, dynamic> json) =>
      AdInfoModel.fromJson(json);
}

class AdInformation {
  String? adImagePath;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}..put('adImagePath', adImagePath);
  }

  AdInformation.fromJson(Map<String, dynamic> json) {
    adImagePath = json.asString('adImagePath');
  }
}

class AdStations {
  int? stationId;
  String? stationName;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{}
      ..put('stationId', stationId)
      ..put('stationName', stationName);
  }

  AdStations.fromJson(Map<String, dynamic> json) {
    stationId = json.asInt('stationId');
    stationName = json.asString('stationName');
  }
}

// class InsertAdPlaceHolderModel {
//   final AdApiType place;
//   InsertAdPlaceHolderModel(this.place);
// }

typedef StationOrAdPlaceHolderModel = dynamic;
typedef VideoBaseOrAdPlaceHolderModel = dynamic;
typedef CommunityBaseOrAdPlaceHolderModel = dynamic;
