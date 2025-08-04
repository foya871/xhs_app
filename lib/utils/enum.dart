// ignore_for_file: constant_identifier_names

import 'dart:async';

import 'package:xhs_app/generate/app_image_path.dart';

typedef ValueCallback<T> = void Function(T);
typedef FutureOrValueCallback<T, F> = FutureOr<F> Function(T);
typedef FutureOrValueCallback2<T, T1, F> = FutureOr<F> Function(T, T1);
typedef FutureOrPredicate = FutureOr<bool?> Function();

// 视频排序
typedef VideoSortType = int;

abstract class VideoSortTypeEnum {
  static const VideoSortType none = 0;
  static const VideoSortType latest = 1; // 最近更新
  static const VideoSortType mostPlayed = 2; // 最多观看(播放)
  static const VideoSortType mostSale = 3; // 最多购买
  static const VideoSortType minute10 = 4; // 十分钟以上
}

enum VideoLayout { small, big }

typedef ClassifyVideoType = int;

abstract class CliassifyVideoTypeEnum {
  static const ClassifyVideoType none = 0;
  static const ClassifyVideoType horzontal = 1; // 每行2个(横版)
  static const ClassifyVideoType vertical = 2; // 每行3个(竖版)
}

// home的tab 类型
typedef ShiPinClassifyType = int;

abstract class ShiPinClassifyTypeEnum {
  static const ShiPinClassifyType none = 0;
  static const ShiPinClassifyType vidoes = 1;
  static const ShiPinClassifyType stations = 2;
  static const ShiPinClassifyType wh = 3;
  // 前端自定义
  static const ShiPinClassifyType attention = -66666666;
}

enum StationDetailStyle { horizontal, vertical, rank }

// 频道样式
typedef StationType = int;

abstract class StationTypeEnum {
  static const StationType none = 0;
  static const StationType h2WithHead = 1; // 第一个单独占一行，其余每行显示2个
  static const StationType h2 = 2; // 横版4宫格，每行显示2个（两行,4个）
  static const StationType h2_3 = 3; // 横版6宫格，同h2 (三行,6个)
  static const StationType v3 = 4; // 竖版6宫格，每行显示3个
  static const StationType v2 = 5; // 竖版6宫格，每行显示2个
  static const StationType saleRank = 6; // 销售排行
  static const StationType playRank = 7; // 播放排行
  static const StationType favRank = 8; // 收藏排行

  static bool isRank(StationType type) =>
      type == saleRank || type == playRank || type == favRank;

  // 需要显示 查看更多和换一换 的类型
  static bool showMoreAndChange(StationType type) =>
      type == h2WithHead || type == h2 || type == h2_3 || isRank(type);

  // 详情页是否使用横版样式
  static StationDetailStyle getDetailStyle(StationType type) {
    if (type == v3 || type == v2) {
      return StationDetailStyle.vertical;
    } else if (isRank(type)) {
      return StationDetailStyle.rank;
    } else {
      return StationDetailStyle.horizontal;
    }
  }

  //换一换pageSize
  static int pageSize(StationType type) => switch (type) {
        h2WithHead => 5,
        h2 => 4,
        h2_3 => 6,
        v3 => 6,
        v2 => 6,
        saleRank => 4,
        playRank => 4,
        favRank => 4,
        _ => 0,
      };
}

typedef MainTabName = String;

typedef AiTabName = String;

abstract class AiTabNameEnum {
  static const AiTabName index = 'index';
  static const AiTabName cloth = 'cloth';
  static const AiTabName faceImage = 'faceImage';
  static const AiTabName faceVideo = 'faceVideo';
  static const AiTabName faceCustom = 'faceCustom';
}

typedef PaymentType = String;

abstract class PaymentTypeEnum {
  static const PaymentType none = '';
  static const PaymentType balance = '0001';
  static const PaymentType alipay = '1001';
  static const PaymentType wechat = '1002';
  static const PaymentType unionPay = '1003';

  static bool isBalance(PaymentType payment) => payment == balance;

  static bool isAlipay(PaymentType payment) => payment == alipay;

  static bool isWechat(PaymentType payment) => payment == wechat;

  static bool isUnionPay(PaymentType payment) => payment == unionPay;

  static RechType toRechType(PaymentType payment) => switch (payment) {
        balance => RechTypeEnum.gold,
        alipay => RechTypeEnum.alipay,
        wechat => RechTypeEnum.wechat,
        unionPay => RechTypeEnum.unionPay,
        _ => RechTypeEnum.gold,
      };
}

typedef RechType = int;

abstract class RechTypeEnum {
  static const RechType gold = 0; // 余额
  static const RechType alipay = 1; // 支付宝
  static const RechType wechat = 2; // 微信
  static const RechType unionPay = 3; // 云闪付
}

typedef PurType = int;

abstract class PurTypeEnum {
  static const PurType vip = 2;
  static const PurType gold = 3;
  static const PurType ticket = 4;
  static const PurType aiVip = 5;
  static const PurType groupBuy = 5;
}

// typedef AdPlaceEnum = String;

// abstract class AdPlaceNameEnum {
//   /// 启动页
//   static const AdPlaceEnum START = "START";

//   /// 首页弹窗(横)
//   static const AdPlaceEnum INDEX_POP_ICON = 'INDEX_POP_ICON';

//   /// 竖版插入
//   static const AdPlaceEnum VERTICAL_INSERT = 'VERTICAL_INSERT';

//   ///底部横幅
//   static const AdPlaceEnum BOTTOM_BANNER = 'BOTTOM_BANNER';

//   ///刷片广告
//   static const AdPlaceEnum BRUSH_INSERT = 'BRUSH_INSERT';

//   ///播放页
//   static const AdPlaceEnum PLAY_PAGE = 'PLAY_PAGE';

//   static const AdPlaceEnum PLAY_MARK = 'PLAY_MARK';

//   ///暂停广告
//   static const AdPlaceEnum VIDEO_PAUSED = 'PLAY_PAGE';

//   ///顶部banner
//   static const AdPlaceEnum INDEXBANNER = 'INDEXBANNER';

//   ///顶部分类
//   static const AdPlaceEnum CLASSIFY_ICON = 'CLASSIFY_ICON';

//   static const AdPlaceEnum PLAY_WIDGET = 'PLAY_WIDGET';

//   /// 以下目前没用到，保留以不报错
//   static const AdPlaceEnum THREE_LIST_VERTICAL = 'THREE_LIST_VERTICAL';
//   static const AdPlaceEnum INSERT_COMMON = 'INSERT_COMMON';
//   static const AdPlaceEnum HORIZONTAL_LIST_INSERT = 'HORIZONTAL_LIST_INSERT';
//   static const AdPlaceEnum LIST_STREAM = 'LIST_STREAM';
//   static const AdPlaceEnum VERTICAL_LIST_INSERT = 'VERTICAL_LIST_INSERT';
// }

typedef VideoTypeEnum = int;

///视频类型：0-普通视频 1-VIP视频 2-付费视频
abstract class VideoTypeValueEnum {
  // ignore: constant_identifier_names
  static const VideoTypeEnum Commmon = 0;

  // ignore: constant_identifier_names
  static const VideoTypeEnum VIP = 1;

  // ignore: constant_identifier_names
  static const VideoTypeEnum Pay = 2;
}

///不能关于原因 1-无次数 2-需要付费 3-需要vip 4-无粉丝团门票
typedef VideoReasonTypeEnum = int;

abstract class VideoReasonTypeValueEnum {
  // ignore: constant_identifier_names
  static const VideoReasonTypeEnum HaveNoTimes = 1;

  // ignore: constant_identifier_names
  static const VideoReasonTypeEnum NeedPay = 2;

  // ignore: constant_identifier_names
  static const VideoReasonTypeEnum VIP = 3;
// ignore: constant_identifier_names
  static const VideoReasonTypeEnum Luoli = 4;
}

///关联视频描述类型: 1-点击观看原片 2-点击观看解说版
typedef RSVideoDescType = int;

abstract class RSVideoDescTypeValueEnum {
  // ignore: constant_identifier_names
  static const RSVideoDescType original = 1;

  // ignore: constant_identifier_names
  static const RSVideoDescType speak = 2;
}

// 博主性别
typedef UserGenderType = int;

abstract class UserGenderTypeEnum {
  static const UserGenderType none = 0;
  static const UserGenderType female = 1; // 女
  static const UserGenderType male = 2; // 男
  static const UserGenderType third = 3; // 中性
}

// 视频Mark
typedef VideoMarkType = int;

abstract class VideoMarkTypeEnum {
  static const VideoMarkType none = 0;
  static const VideoMarkType long = 1; // 长视频
  static const VideoMarkType short = 2; // 短视频
}

typedef UserUpType = int;

///博主类型 1普通up 2-明星 3-出品方
abstract class UserUpTypeEnum {
  static const UserUpType common = 1;
  static const UserUpType star = 2;
  static const UserUpType producer = 3;
}

typedef VipType = int;

/// VIP 类型
abstract class VipTypeEnum {
  static const VipType none = 0;

  static const VipType trial = 1; // 体验
  static const VipType week = 2; // 周卡
  static const VipType download = 3; // 下载
  static const VipType duanJu = 4; // 短剧
  static const VipType month = 5; // 月卡
  static const VipType goldMonth = 6; // 金币年卡
  static const VipType year = 7; // 年卡
  static const VipType goldForever = 8; // 金币永久
  static const VipType zhiZun = 9; // 至尊
  static const VipType world = 10; // 禁区(世界)

  static String badge(VipType? vipType) => switch (vipType) {
        month => AppImagePath.mine_vip_badge_month,
        goldForever => AppImagePath.mine_vip_badge_forever,
        world => AppImagePath.mine_vip_badge_world,
        _ => '',
      };

  static String name(VipType? vipType) => switch (vipType) {
        month => '月卡会员',
        goldForever => '永久卡会员',
        world => '世界卡会员',
        _ => '',
      };
}

/// AI绘画tab页样式
typedef AiDrawPromptShowType = int;

abstract class AiDrawPromptShowTypeEnum {
  static const AiDrawPromptShowType none = 0;
  static const AiDrawPromptShowType text = 1; // warp text
  static const AiDrawPromptShowType image = 2; // 一排三个图片
}

// AI 脱衣类型
typedef AiClothType = int;

abstract class AiClothTypeEnum {
  static const AiClothType none = 0;
  static const AiClothType shangYi = 1; // 掀起上衣
  static const AiClothType biJiNi = 2; // 比基尼
  static const AiClothType shaQun = 3; // 透明纱裙
  static const AiClothType qiPao = 4; // 透明旗袍
}

// AI 换脸
typedef AiFaceClassifyType = int;

abstract class AiFaceClassifyTypeEnum {
  static const AiFaceClassifyType none = 0;
  static const AiFaceClassifyType image = 1; // 图片
  static const AiFaceClassifyType video = 2; // 视频
}

// AI 申诉状态
typedef AiAppealType = int;

abstract class AiAppealTypeEnum {
  static const AiAppealType none = 0; //未申诉
  static const AiAppealType appeal = 1; // 申诉
  static const AiAppealType repainting = 2; // 重绘中
  static const AiAppealType repaintOk = 3; // 重绘完成
  static const AiAppealType reapintFail = 4; // 重绘失败
  static const AiAppealType reject = 5; // 驳回
  static const AiAppealType kf = 6; // 转人工处理
  static const AiAppealType kfDone = 7; // 人工完成

  static String name(AiAppealType? type) => switch (type) {
        none => '申诉', // 这里状态是未申诉，显示为申诉
        appeal => '申诉中',
        repainting => '重绘中',
        repaintOk => '重绘完成',
        reapintFail => '重绘失败',
        reject => '驳回',
        kf => '人工处理',
        kfDone => '人工完成',
        _ => ''
      };
}

// 服务器有4种状态, 前端只有3种状态
enum AiRecordClientStatus { none, making, success, error }

// AI 记录状态
typedef AiRecordStatus = String;

abstract class AiRecordStatusEnum {
  static const AiRecordStatus none = '';
  static const AiRecordStatus send = 'send'; // 发送中
  static const AiRecordStatus received = 'received'; // 处理中
  static const AiRecordStatus success = 'success'; // 成功
  static const AiRecordStatus error = 'error'; // 失败

  static AiRecordClientStatus to(AiRecordStatus status) {
    return switch (status) {
      send => AiRecordClientStatus.making,
      received => AiRecordClientStatus.making,
      success => AiRecordClientStatus.success,
      error => AiRecordClientStatus.error,
      _ => AiRecordClientStatus.none,
    };
  }
}

// AI消耗类型
enum AiCostType { fail, num, gold }

// 帖子classify
typedef CommunityClassifyType = int;

abstract class CommunityClassifyTypeEnum {
  static const CommunityClassifyType none = 0;
  static const CommunityClassifyType tuiJian = 1;
  static const CommunityClassifyType fix = 2;
  static const CommunityClassifyType optional = 3;
}

// 帖子类型
typedef CommunityType = int;

abstract class CommunityTypeEnum {
  static const CommunityType none = -1;
  static const CommunityType text = 0; // 文字
  static const CommunityType picture = 1; //图文
  static const CommunityType video = 2; // 视频
  static const CommunityType ad = 3; // 广告
}

typedef CommunityMarkType = int;

abstract class CommunityMarkTypeEnum {
  static const CommunityMarkType free = 0; //免费
  static const CommunityMarkType vip = 1; //vip
  static const CommunityMarkType gold = 2; //金币
}

typedef CommunityReasonType = int;

abstract class CommunityReasonTypeEnum {
  static const CommunityReasonType noCount = 1; //无次数
  static const CommunityReasonType needBuy = 2; //需购买
  static const CommunityReasonType needVip = 3; //需要VIP
  static const CommunityReasonType needFans = 4; //需粉丝团
}
