/// coverImg : "string"
/// fakeFavoritesNum : 0
/// imgNum : 0
/// picType : 0
/// portrayPicId : 0
/// price : 0
/// title : "string"

class PortaintItemModel {
  PortaintItemModel({
      String? coverImg, 
      num? fakeFavoritesNum, 
      num? imgNum, 
      num? picType, 
      num? portrayPicId, 
      num? price, 
      String? title,}){
    _coverImg = coverImg;
    _fakeFavoritesNum = fakeFavoritesNum;
    _imgNum = imgNum;
    _picType = picType;
    _portrayPicId = portrayPicId;
    _price = price;
    _title = title;
}

  PortaintItemModel.fromJson(dynamic json) {
    _coverImg = json['coverImg'];
    _fakeFavoritesNum = json['fakeFavoritesNum'];
    _imgNum = json['imgNum'];
    _picType = json['picType'];
    _portrayPicId = json['portrayPicId'];
    _price = json['price'];
    _title = json['title'];
  }
  String? _coverImg;
  num? _fakeFavoritesNum;
  num? _imgNum;
  num? _picType;
  num? _portrayPicId;
  num? _price;
  String? _title;
PortaintItemModel copyWith({  String? coverImg,
  num? fakeFavoritesNum,
  num? imgNum,
  num? picType,
  num? portrayPicId,
  num? price,
  String? title,
}) => PortaintItemModel(  coverImg: coverImg ?? _coverImg,
  fakeFavoritesNum: fakeFavoritesNum ?? _fakeFavoritesNum,
  imgNum: imgNum ?? _imgNum,
  picType: picType ?? _picType,
  portrayPicId: portrayPicId ?? _portrayPicId,
  price: price ?? _price,
  title: title ?? _title,
);
  String? get coverImg => _coverImg;
  num? get fakeFavoritesNum => _fakeFavoritesNum;
  num? get imgNum => _imgNum;
  num? get picType => _picType;
  num? get portrayPicId => _portrayPicId;
  num? get price => _price;
  String? get title => _title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['coverImg'] = _coverImg;
    map['fakeFavoritesNum'] = _fakeFavoritesNum;
    map['imgNum'] = _imgNum;
    map['picType'] = _picType;
    map['portrayPicId'] = _portrayPicId;
    map['price'] = _price;
    map['title'] = _title;
    return map;
  }

}