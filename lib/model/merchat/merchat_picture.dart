/*
 * @Author: ziqi jhzq12345678
 * @Date: 2025-01-21 09:41:40
 * @LastEditors: ziqi jhzq12345678
 * @LastEditTime: 2025-01-21 09:43:15
 * @FilePath: /xhs_app/lib/model/merchat/merchat_picture.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
class MerchatPicture {
  String? createdAt;
  String? id;
  String? imageUrl;
  int? status;
  int? type;
  String? updatedAt;

  MerchatPicture({createdAt, id, imageUrl, status, type, updatedAt});

  MerchatPicture.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    id = json['id'];
    imageUrl = json['imageUrl'];
    status = json['status'];
    type = json['type'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createdAt'] = createdAt;
    data['id'] = id;
    data['imageUrl'] = imageUrl;
    data['status'] = status;
    data['type'] = type;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
