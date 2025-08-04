/*
 * @Author: wangdazhuang
 * @Date: 2024-12-02 11:37:28
 * @LastEditTime: 2024-12-02 11:38:10
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /xhs_app/lib/src/chewie/src/cupertino/widgets/cupertino_options_dialog.dart
 */
import 'package:flutter/cupertino.dart';

import '../../../chewie.dart';

class CupertinoOptionsDialog extends StatefulWidget {
  const CupertinoOptionsDialog({
    super.key,
    required this.options,
    this.cancelButtonText,
  });

  final List<OptionItem> options;
  final String? cancelButtonText;

  @override
  // ignore: library_private_types_in_public_api
  _CupertinoOptionsDialogState createState() => _CupertinoOptionsDialogState();
}

class _CupertinoOptionsDialogState extends State<CupertinoOptionsDialog> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CupertinoActionSheet(
        actions: widget.options
            .map(
              (option) => CupertinoActionSheetAction(
                onPressed: () => option.onTap!(),
                child: Text(option.title),
              ),
            )
            .toList(),
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.pop(context),
          isDestructiveAction: true,
          child: Text(widget.cancelButtonText ?? 'Cancel'),
        ),
      ),
    );
  }
}
