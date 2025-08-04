import 'package:get/get.dart';
import 'package:tuple/tuple.dart';
import 'package:xhs_app/components/easy_toast.dart';
import 'package:xhs_app/generate/app_image_path.dart';
import 'package:xhs_app/http/api/api.dart';
import 'package:xhs_app/model/blogger/blogger_fans_group.dart';
import 'package:xhs_app/model/blogger/blogger_fans_model.dart';
import 'package:xhs_app/services/user_service.dart';

class PrivateGroupPageController extends GetxController {
  final userService = Get.find<UserService>();
  int userId = 0;
  Rx<BloggerFansGroupModel> bloggerPrivateGroupInfo =
      BloggerFansGroupModel.fromJson({}).obs;
  RxList<BloggerFansModel> fansRankingList = <BloggerFansModel>[].obs;
  List<Tuple4<String, String, int, int>> tickets = [];

  @override
  void onInit() {
    userId = Get.arguments['userId'];
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    getBloggerPrivateGroupInfo();
    getFansRankingList();
    // queryFansGroupTicket();
  }

  /// 获取博主的私人团信息
  getBloggerPrivateGroupInfo() {
    Api.queryFansGroupByUserId(userId).then((value) {
      if (value != null) {
        bloggerPrivateGroupInfo.value = value;
        tickets.add(Tuple4(AppImagePath.mine_blogger_monthly_ticket, '私人团月票',
            (value.monthTicketPrice ?? 0.0).toInt(), 1));
        tickets.add(Tuple4(AppImagePath.mine_blogger_season_tickets, '私人团季票',
            (value.seasonTicketPrice ?? 0.0).toInt(), 2));
        tickets.add(Tuple4(AppImagePath.mine_blogger_year_ticket, '私人团年票',
            (value.yearTicketPrice ?? 0.0).toInt(), 3));
      }
    });
  }

  ///获取粉丝排行榜
  getFansRankingList() {
    Api.queryFansRankingList(userId, 1, 100).then((value) {
      if (value.isNotEmpty) {
        fansRankingList.value = value;
      }
    });
  }

  /// 获取粉丝团团票
  queryFansGroupTicket() {
    Api.queryFansGroupTicket().then((value) {
      if (value.isNotEmpty) {
        tickets.clear();
        for (var element in value) {
          tickets.add(Tuple4(
              element.ticketType == 1
                  ? AppImagePath.mine_blogger_monthly_ticket
                  : element.ticketType == 2
                      ? AppImagePath.mine_blogger_season_tickets
                      : AppImagePath.mine_blogger_year_ticket,
              element.ticketType == 1
                  ? '私人团月票'
                  : element.ticketType == 2
                      ? '私人团季票'
                      : '私人团年票',
              element.ticketPrice ?? 0,
              element.ticketType ?? 0));
        }
      }
    });
  }

  /// 加入私人团
  joinPrivateGroup(int ticketType) {
    Api.joinFansGroup(bloggerPrivateGroupInfo.value.groupId ?? 0, ticketType)
        .then((value) {
      if (value) {
        EasyToast.show('恭喜您购买成功!');
        userService.updateAll();
        getBloggerPrivateGroupInfo();
      }
    });
  }
}
