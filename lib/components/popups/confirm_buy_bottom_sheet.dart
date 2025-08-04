import 'package:xhs_app/utils/extension.dart';

import '../popup/bottomsheet/base_confirm_buy_bottom_sheet.dart';

class ConfirmBuyBottomSheet extends BaseConfirmBuyBottomSheet {
  ConfirmBuyBottomSheet(double price, {super.onTapConfirm})
      : super(
          priceText: '${price.toStringAsShort()}金币',
          titleText: '确认支付',
          desc1Text: '支持原创，支持作者',
          desc2Text: '您的付费是作者创作更好的内容动力',
          confirmText: '确认支付',
          autoBackOnTapClose: true,
          autoBackOnTapConfirm: true,
        );
}
