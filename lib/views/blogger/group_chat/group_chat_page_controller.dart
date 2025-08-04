import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:xhs_app/http/api/api.dart';
import 'package:xhs_app/model/mine/group_chatroom_model.dart';

class GroupChatPageController extends GetxController {
  int userId = 0;
  var nickName = "".obs;
  final EasyRefreshController easyRefreshController = EasyRefreshController();

  RxList<GroupChatroomModel> bloggerGroupChatList = <GroupChatroomModel>[].obs;
  RxList<GroupChatroomModel> hotGroupChatList = <GroupChatroomModel>[].obs;

  @override
  void onInit() {
    userId = Get.arguments['userId'];
    nickName.value = Get.arguments['nickName'];
    super.onInit();
  }

  @override
  onReady() {
    super.onReady();
    getHttpDatas();
  }

  getHttpDatas() async {
    getBloggerGroupChatList();
    getHotGroupChatList();
  }

  ///获取博主的群聊列表
  Future<void> getBloggerGroupChatList() async {
    Api.queryChatRoomByUserId(userId, 1, 100).then((value) {
      if (value != null) {
        bloggerGroupChatList.assignAll(value);
      }
    });
  }

  ///获取热门群聊列表
  Future<void> getHotGroupChatList() async {
    Api.queryHotChatRoomList().then((value) {
      if (value != null) {
        hotGroupChatList.assignAll(value);
      }
    });
  }

  ///加入群聊
  Future<void> joinChatRoom(int roomId, int type) async {
    Api.joinGroupChat(roomId).then((value) {
      if (value) {
        if (type == 1) {
          for (int i = 0; i < bloggerGroupChatList.length; i++) {
            if (bloggerGroupChatList[i].roomId == roomId) {
              GroupChatroomModel groupChatroomModel = bloggerGroupChatList[i];
              groupChatroomModel.join = true;
              bloggerGroupChatList[i] = groupChatroomModel;
            }
          }
        } else {
          for (int i = 0; i < hotGroupChatList.length; i++) {
            if (hotGroupChatList[i].roomId == roomId) {
              GroupChatroomModel groupChatroomModel = hotGroupChatList[i];
              groupChatroomModel.join = true;
              hotGroupChatList[i] = groupChatroomModel;
            }
          }
        }
      }
    });
  }
}
