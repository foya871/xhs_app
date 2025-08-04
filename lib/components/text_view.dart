import 'package:flutter/material.dart';

class TextView extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign textAlign;
  final int? maxLines;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final TextDecoration? decoration;
  final Color? decorationColor;
  final double? letterSpacing;
  final double? wordSpacing;
  final String? fontFamily;
  final TextOverflow? overflow;

  const TextView({
    super.key,
    required this.text,
    this.style,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.fontStyle,
    this.decoration,
    this.decorationColor,
    this.letterSpacing,
    this.wordSpacing,
    this.fontFamily,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style ??
          TextStyle(
            color: color,
            fontSize: fontSize,
            fontWeight: fontWeight,
            fontStyle: fontStyle,
            decoration: decoration,
            decorationColor: decorationColor,
            letterSpacing: letterSpacing,
            wordSpacing: wordSpacing,
            fontFamily: fontFamily,
          ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
