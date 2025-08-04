import 'package:get/get.dart';
import 'package:xhs_app/model/video/community_resource_classify_model.dart';
import 'package:xhs_app/model/video/short_video_get_short_video_classify_item.dart';
class BannedTheStrangeCaseState {
  BannedTheStrangeCaseState() {
    ///Initialize variables
  }
  RxList<ShortVideoGetShortVideoClassify> list1= ["全部", "民间故事", "诡秘档案", "由爱生很傻很"].map((e)=>ShortVideoGetShortVideoClassify(classifyTitle:e)).toList().obs;
  List<String> list2= ["全部", "人气推荐", "最近更新"];
  int index1=0;
  String? param1;
  int index2=0;

}
