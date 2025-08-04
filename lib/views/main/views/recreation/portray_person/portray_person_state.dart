import 'package:get/get.dart';
import 'package:xhs_app/model/video/community_resource_classify_model.dart';
import 'package:xhs_app/model/video/tag_list_other_tag_list_item.dart';
class PortrayPersonState {
  PortrayPersonState() {
    ///Initialize variables
  }

  RxList<TagListOtherTagListItem> list1= ["全部", "cos娘", "足控领域", "女神图集", "清纯唯美"].map((e)=>TagListOtherTagListItem(title:e)).toList().obs;
  List<String> list2= ["全部", "人气", "最近更新"];
  int index1=0;

  int parame1=0;
  int index2=0;

}
