import 'package:get/get.dart';
import 'package:xhs_app/model/video/community_resource_classify_model.dart';
import 'package:xhs_app/model/video/connotation_classify_list_tag.dart';
class IntensionMapState {
  IntensionMapState() {
    ///Initialize variables
  }

  RxList<ConnotationClassifyListTag> list1= ["全部", "娱乐八卦", "人在囧图"].map((e)=>ConnotationClassifyListTag(name:e)).toList().obs;

  int index1=0;
}
