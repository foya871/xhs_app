import 'package:json2dart_safe/json2dart.dart';

class CertVideo {
  String? authKey;
  List<String>? coverImg;
  String? fileId;
  int? playTime;
  int? size;
  int? type;
  String? url;

  CertVideo({
    this.authKey,
    this.coverImg,
    this.fileId,
    this.playTime,
    this.size,
    this.type,
    this.url,
  });

  factory CertVideo.fromJson(Map<String, dynamic> json) {
    return CertVideo(
      authKey: json.asString('authKey'),
      coverImg: json.asList<String>('coverImg', (v) => v.toString()),
      fileId: json.asString('fileId'),
      playTime: json.asInt('playTime'),
      size: json.asInt('size'),
      type: json.asInt('type'),
      url: json.asString('url'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'authKey': authKey,
      'coverImg': coverImg,
      'fileId': fileId,
      'playTime': playTime,
      'size': size,
      'type': type,
      'url': url,
    };
  }
}
