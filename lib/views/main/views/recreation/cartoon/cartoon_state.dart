import 'package:get/get.dart';
import 'package:xhs_app/model/video/comics_other_tag_list_item.dart';
import 'package:xhs_app/model/video/other_class_list_other_tag_list_item.dart';

class CartoonState {

  RxList<OtherClassListOtherTagListItem> list1=["全部", ].map((e)=>OtherClassListOtherTagListItem(title:e)).toList().obs;


  List<String> list2= ["全部", "成人漫画", "青年漫画"];
  List<String> list4= ["全部", "连载", "完结"];
  List<String> list5= ["全部", "人气", "最近更新"];
  RxList<ComicsOtherTagListItem> list3= ["全部", ].map((e)=>ComicsOtherTagListItem(title:e)).toList().obs;
  int index1=0;

  int parame1=0;
  int index2=0;
  int index3=0;

  int parame3=0;

  int index4=0;
  int index5=0;
  CartoonState() {
    ///Initialize variables
  }


}
