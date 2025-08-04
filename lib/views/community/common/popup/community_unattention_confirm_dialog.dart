import '../../../../components/popup/dialog/base_confirm_dialog.dart';

// 取消关注确认弹窗
class CommunityUnattentionConfirmDialog extends BaseConfirmDialog {
  CommunityUnattentionConfirmDialog({required super.onConfirm})
      : super(
          titleText: '提示',
          descText: '确认不再关注?',
          cancelText: '取消',
          confirmText: '确认',
        );
}
