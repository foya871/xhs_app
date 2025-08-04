class PortrayGetPictureListItem {
  int? portrayPicId;
  String? title;
  String? coverImg;
  int? imgNum;
  int? picType;
  String? price;
  int? fakeFavoritesNum;

  PortrayGetPictureListItem(
      {this.portrayPicId,
      this.title,
      this.coverImg,
      this.imgNum,
      this.picType,
      this.price,
      this.fakeFavoritesNum});

  PortrayGetPictureListItem.fromJson(Map<String, dynamic> json) {
    portrayPicId = json['portrayPicId'];
    title = json['title'];
    coverImg = json['coverImg'];
    imgNum = json['imgNum'];
    picType = json['picType'];
    price = json['price'];
    fakeFavoritesNum = json['fakeFavoritesNum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['portrayPicId'] = this.portrayPicId;
    data['title'] = this.title;
    data['coverImg'] = this.coverImg;
    data['imgNum'] = this.imgNum;
    data['picType'] = this.picType;
    data['price'] = this.price;
    data['fakeFavoritesNum'] = this.fakeFavoritesNum;
    return data;
  }
}
