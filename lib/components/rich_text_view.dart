import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RichTextView extends StatelessWidget {
  const RichTextView({
    super.key,
    required this.text, // 输入的文本内容
    this.style, // 普通文本样式
    this.highlightStyle, // 高亮文本样式
    this.regex,
    this.specifyTexts, // 指定文本列表
    this.caseSensitive = false, // 是否区分大小写
    this.onTap, // 点击事件
  });

  final String text; // 文本内容
  final TextStyle? style; // 普通文本样式
  final TextStyle? highlightStyle; // 高亮文本样式
  final Function(String)? onTap; // 点击事件回调
  final RegExp? regex; // 外部传入的正则表达式
  final bool caseSensitive; // 是否区分大小写
  final List<String>? specifyTexts; // 指定文本列表（需要转化为可点击的文本）

  @override
  Widget build(BuildContext context) {
    final List<TextSpan> textSpans = [];

    // 默认的正则表达式：匹配网址和邮箱
    RegExp exp = regex ??
        RegExp(
            r'((http|https|ftp)://([\w_-]+(?:(?:\.[\w_-]+)+))([\w.,@?^=%&:/~+#-]*[\w@?^=%&/~+#-])?)|([a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,})');

    // 如果指定了specifyTexts，将它们转化为正则表达式
    List<RegExp>? specifyExpList;
    if (specifyTexts != null && specifyTexts!.isNotEmpty) {
      specifyExpList = specifyTexts!
          .map(
            (text) => RegExp(
              RegExp.escape(text), // 将specifyText转义为正则表达式
              caseSensitive: caseSensitive, // 区分大小写
            ),
          )
          .toList();
    }

    // 合并正则表达式
    final List<RegExp> regexList = [
      exp,
      if (specifyExpList != null && specifyExpList.isNotEmpty)
        ...specifyExpList, // 如果有多个specifyExp，将它们全部添加
    ];

    // 合并多个正则表达式为一个大的正则
    final combinedRegex = RegExp(
      regexList.map((e) => e.pattern).join('|'), // 合并多个正则表达式
      caseSensitive: caseSensitive, // 区分大小写
    );

    // 通过正则分割文本并生成对应的TextSpan
    text.splitMapJoin(
      combinedRegex,
      onMatch: (match) {
        // 如果是匹配的链接或指定的文本，创建一个可点击的 TextSpan
        textSpans.add(TextSpan(
          text: match.group(0),
          style: highlightStyle ??
              const TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              if (onTap != null) {
                onTap?.call(match.group(0) ?? "");
              }
            },
        ));
        return ''; // 返回空字符串，match已经添加到textSpans中
      },
      onNonMatch: (nonMatch) {
        // 非匹配部分的普通文本
        textSpans.add(TextSpan(
          text: nonMatch,
          style: style, // 使用普通文本样式
        ));
        return nonMatch; // 保持非匹配部分的内容不变
      },
    );

    // 返回一个 RichText，包含所有的文本和可点击部分
    return RichText(
      text: TextSpan(
        children: textSpans,
        style: style, // 默认的文本样式
      ),
    );
  }
}
