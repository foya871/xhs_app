class GenericPlayerModel {
  final String coverImg;
  final String playUrl;
  final int? width;
  final int? height;

  GenericPlayerModel({
    required this.coverImg,
    required this.playUrl,
    this.width,
    this.height,
  });
}
