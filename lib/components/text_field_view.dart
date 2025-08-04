import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef FocusStatusCallBack = void Function(bool status);

class TextFieldView extends StatefulWidget {
  // 控制文本字段文本的TextEditingController。
  final TextEditingController controller;

  // 当文本字段为空时显示的提示文本。
  final String? hintText;

  // 提示文本的样式。
  final TextStyle? hintTextStyle;

  // 输入文本的样式。
  final TextStyle? inputTextStyle;

  // 输入文本的字体大小。
  final double? fontSize;

  // 输入文本的颜色。
  final Color? textColor;

  // 文本字段的初始值。
  final String? initialValue;

  // 是否应模糊显示文本（例如，用于密码）。
  final bool obscureText;

  // 要显示的键盘类型。
  final TextInputType? inputType;

  // 输入格式
  final List<TextInputFormatter>? inputFormatters;

  // 输入文本的最大长度。
  final int? maxLength;

  // 输入文本的最大行数。
  final int? maxLines;

  // 输入文本的最小行数。
  final int? minLines;

  // 当文本更改时的回调函数。
  final ValueChanged<String>? onChanged;

  // 是否启用文本字段。
  final bool? isEnabled;

  final TextAlign textAlign;

  // InputDecoration 属性
  final InputBorder? border; // 边框样式。
  final String? labelText; // 输入框上方显示的文本标签。
  final String? counterText; // 右下角的字符计数文本。
  final bool? isFilled; // 是否应填充背景颜色。
  final Color? fillColor; // 填充背景颜色的颜色。
  final String? errorText; // 输入框下方的错误文本。
  final Widget? prefixIcon; // 在输入框前面显示的图标。
  final Widget? prefix; // 输入框前面显示的内容。
  final Widget? suffixIcon; // 在输入框后面显示的图标。
  final Widget? suffix; // 输入框后面显示的内容。
  final String? prefixText; // 输入框前面显示的文本。
  final String? suffixText; // 输入框后面显示的文本。
  final bool? alignLabelWithHint; // 是否将标签与提示文本对齐。
  final FloatingLabelBehavior? floatingLabelBehavior; // 标签的浮动行为。
  final String? helperText; // 输入框下方的辅助文本。
  final TextStyle? helperTextStyle; // 辅助文本的样式。
  final int? errorMaxLines; // 错误文本的最大行数。
  final bool? isDense; // 是否紧凑型布局。
  final EdgeInsets? contentPadding; // 内容的填充。
  final OutlineInputBorder? focusedBorder; // 聚焦时的边框样式。
  final OutlineInputBorder? enabledBorder; // 启用时的边框样式。
  final OutlineInputBorder? disabledBorder; // 禁用时的边框样式。
  final OutlineInputBorder? focusedErrorBorder; // 有错误时的边框样式。
  final OutlineInputBorder? errorBorder; // 错误时的边框样式。
  final String? semanticCounterText; // 语义化的字符计数文本。
  final TextDirection? hintTextDirection; // 提示文本的文本方向。
  final BoxConstraints? prefixIconConstraints; // 前缀图标的约束。
  final BoxConstraints? suffixIconConstraints; // 后缀图标的约束。

  // TextStyle 属性
  final Color? textBackgroundColor; // 文本的背景颜色。
  final String? fontFamily; // 字体系列。
  final List<String>? fontFamilyFallback; // 字体系列的后备。
  final FontWeight? fontWeight; // 字体的粗细。
  final FontStyle? fontStyle; // 字体的样式。
  final double? letterSpacing; // 字符之间的间距。
  final double? wordSpacing; // 单词之间的间距。
  final TextBaseline? textBaseline; // 文本基线对齐。
  final double? lineHeight; // 行高。
  final Paint? foregroundPaint; // 文本前景绘制。
  final Paint? backgroundPaint; // 文本背景绘制。
  final TextDecoration? textDecoration; // 文本装饰。
  final Color? decorationColor; // 文本装饰的颜色。
  final TextDecorationStyle? decorationStyle; // 文本装饰的样式。
  final String? debugLabel; // 用于调试的标签。
  final Locale? locale; // 用于区域设置的区域。
  final StrutStyle? strutStyle; // 结构样式。
  final bool? isCollapsed; //修饰文本位置

  final FocusNode? focusNode;
  final FocusStatusCallBack? focusStatus;

  TextFieldView({
    super.key,
    required this.controller,
    this.hintText,
    this.hintTextStyle,
    this.inputTextStyle,
    this.fontSize,
    this.textColor,
    this.initialValue,
    this.obscureText = false,
    this.inputType,
    this.inputFormatters,
    this.maxLength,
    this.maxLines,
    this.minLines,
    this.onChanged,
    this.isEnabled = true,
    this.border,
    this.labelText,
    this.counterText,
    this.isFilled,
    this.fillColor,
    this.errorText,
    this.prefixIcon,
    this.prefix,
    this.suffixIcon,
    this.suffix,
    this.prefixText,
    this.suffixText,
    this.alignLabelWithHint,
    this.floatingLabelBehavior,
    this.helperText,
    this.helperTextStyle,
    this.errorMaxLines,
    this.isDense,
    this.contentPadding,
    this.focusedBorder,
    this.enabledBorder,
    this.disabledBorder,
    this.focusedErrorBorder,
    this.errorBorder,
    this.semanticCounterText,
    this.hintTextDirection,
    this.prefixIconConstraints,
    this.suffixIconConstraints,
    this.textBackgroundColor,
    this.fontFamily,
    this.fontFamilyFallback,
    this.fontWeight,
    this.fontStyle,
    this.letterSpacing,
    this.wordSpacing,
    this.textBaseline,
    this.lineHeight,
    this.foregroundPaint,
    this.backgroundPaint,
    this.textDecoration,
    this.decorationColor,
    this.decorationStyle,
    this.debugLabel,
    this.locale,
    this.strutStyle,
    this.isCollapsed,
    this.focusNode,
    this.focusStatus,
    this.textAlign = TextAlign.start,
  });

  @override
  _TextFieldViewState createState() => _TextFieldViewState();
}

class _TextFieldViewState extends State<TextFieldView> {
  late FocusNode _focusNode;
  bool _isFocus = false; //是否聚焦

  @override
  void initState() {
    _focusNode = widget.focusNode ?? FocusNode();
    super.initState();
    _focusNode.addListener(() {
      _isFocus = _focusNode.hasFocus;
      if (widget.focusStatus != null) {
        widget.focusStatus?.call(_isFocus);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: widget.obscureText,
      keyboardType: widget.inputType,
      inputFormatters: widget.inputFormatters,
      maxLength: widget.maxLength,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      onChanged: widget.onChanged,
      enabled: widget.isEnabled!,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: widget.hintTextStyle ??
            TextStyle(
              fontSize: widget.fontSize,
              color: widget.textColor,
              fontFamily: widget.fontFamily,
              fontWeight: widget.fontWeight,
              fontStyle: widget.fontStyle,
              letterSpacing: widget.letterSpacing,
              wordSpacing: widget.wordSpacing,
              height: widget.lineHeight,
              decoration: widget.textDecoration,
              decorationColor: widget.decorationColor,
              decorationStyle: widget.decorationStyle,
              background: widget.backgroundPaint,
              foreground: widget.foregroundPaint,
            ),
        labelText: widget.labelText,
        counterText: widget.counterText,
        border: widget.border,
        filled: widget.isFilled ?? false,
        fillColor: widget.fillColor,
        errorText: widget.errorText,
        prefixIcon: widget.prefixIcon,
        prefix: widget.prefix,
        suffixIcon: widget.suffixIcon,
        suffix: widget.suffix,
        prefixText: widget.prefixText,
        suffixText: widget.suffixText,
        alignLabelWithHint: widget.alignLabelWithHint ?? false,
        floatingLabelBehavior:
            widget.floatingLabelBehavior ?? FloatingLabelBehavior.auto,
        helperText: widget.helperText,
        helperStyle: widget.helperTextStyle,
        errorMaxLines: widget.errorMaxLines,
        isDense: widget.isDense ?? false,
        contentPadding: widget.contentPadding ?? EdgeInsets.zero,
        focusedBorder: widget.focusedBorder,
        enabledBorder: widget.enabledBorder,
        disabledBorder: widget.disabledBorder,
        focusedErrorBorder: widget.focusedErrorBorder,
        errorBorder: widget.errorBorder,
        semanticCounterText: widget.semanticCounterText,
        hintTextDirection: widget.hintTextDirection,
        prefixIconConstraints: widget.prefixIconConstraints,
        suffixIconConstraints: widget.suffixIconConstraints,
        isCollapsed: widget.isCollapsed ?? false,
      ),
      style: widget.inputTextStyle ??
          TextStyle(
            fontSize: widget.fontSize ?? 14.0,
            color: widget.textColor ?? Colors.black,
            // 默认文本颜色
            backgroundColor: widget.textBackgroundColor,
            fontFamily: widget.fontFamily,
            fontFamilyFallback: widget.fontFamilyFallback,
            fontWeight: widget.fontWeight,
            fontStyle: widget.fontStyle,
            letterSpacing: widget.letterSpacing,
            wordSpacing: widget.wordSpacing,
            textBaseline: widget.textBaseline,
            height: widget.lineHeight,
            foreground: widget.foregroundPaint,
            background: widget.backgroundPaint,
            decoration: widget.textDecoration,
            decorationColor: widget.decorationColor,
            decorationStyle: widget.decorationStyle,
            debugLabel: widget.debugLabel,
            locale: widget.locale,
          ),
      focusNode: _focusNode,
      textAlign: widget.textAlign,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }
}
