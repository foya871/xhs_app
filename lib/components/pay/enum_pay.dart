typedef PurType = int;

abstract class PurTypeEnum {
  static const PurType vip = 2;
  static const PurType gold = 3;
  static const PurType ticket = 4;
  static const PurType aiVip = 5;
  static const PurType groupBuy = 5;
}

typedef PayType = int;

abstract class PayTypeEnum {
  static const PayType balance = 0; // 余额
  static const PayType alipay = 1; // 支付宝
  static const PayType wechat = 2; // 微信
  static const PayType unionPay = 3; // 云闪付
}
