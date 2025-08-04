/*
 * @Author: wangdazhuang
 * @Date: 2024-08-27 08:59:00
 * @LastEditTime: 2024-09-05 14:34:18
 * @LastEditors: wangdazhuang
 * @Description: 
 * @FilePath: /xhs_app/lib/src/utils/utils.dart
 */
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:crypto/crypto.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:xhs_app/utils/logger.dart';

import 'extension.dart';

abstract class Utils {
  static final _random = Random();

  static String secondsToTime(int? duration,
      {String defaultValue = '', bool short = true}) {
    if (duration == null || duration <= 0) return defaultValue;

    final dInt = duration.floor();
    final h = dInt ~/ 3600;
    final m = (dInt - (h * 3600)) ~/ 60;
    final s = dInt % 60;
    List<int> arr = [h, m, s];
    if (short) {
      arr = arr.trimLeading((e) => e == 0);
    }

    return arr.map((e) => '$e'.padLeft(2, '0')).join(':');
  }

  static List<Widget> widgetsJoinSeperator(
    List<Widget> widgets,
    Widget sep, {
    bool head = false,
    bool tail = false,
  }) {
    List<Widget> result = [];
    if (widgets.isNotEmpty) {
      if (head) result.add(sep);
      for (var i = 0; i < widgets.length - 1; i++) {
        result.add(widgets[i]);
        result.add(sep);
      }
      result.add(widgets[widgets.length - 1]);
      if (tail) {
        result.add(sep);
      }
    }
    return result;
  }

  /// k w化处理
  static String numFmt(int number, {bool upper = false}) {
    var shortForm = "";
    final k = upper ? 'K' : 'k';
    final w = upper ? 'W' : 'w';
    if (number < 1000) {
      shortForm = number.toString();
    } else if (number >= 1000 && number < 10000) {
      shortForm = "${(number / 1000).toStringAsFixed(1)}$k";
    } else {
      shortForm = "${(number / 10000).toStringAsFixed(1)}$w";
    }
    return shortForm;
  }

  static String numFmtCh(int number) {
    var shortForm = '';
    if (number < 10000) {
      shortForm = number.toString();
    } else {
      shortForm = '${(number / 10000).toStringAsFixed(1)}万';
    }
    return shortForm;
  }

  static const full = [
    'yyyy',
    '-',
    'mm',
    '-',
    'dd',
    ' ',
    'HH',
    ':',
    'mm',
    ':',
    'ss'
  ];
  //日期格式化
  static String dateFmt(
    String v, [
    List<String> formats = const ['yyyy', '.', 'mm', '.', 'dd'],
    bool toCST = true,
  ]) {
    var result = '';
    const cstOffset = Duration(hours: 8);

    try {
      DateTime date = v.isEmpty ? DateTime.now() : DateTime.parse(v);
      if (toCST && date.timeZoneOffset.compareTo(cstOffset) != 0) {
        // 这里add之后仍然是utc时间
        // !! 如果使用 z Z 时区相关format会有问题
        date = date.toUtc().add(cstOffset);
      }

      result = formatDate(date, formats);
    } on Exception catch (e) {
      logger.d("dateFmt pasrse error:$e");
    }
    return result;
  }

  // 1分钟前, 1小时前,1天前,1个月前,1年前
  static String dateAgo(String v) {
    const hoursPerDay = 24;
    const daysPerMonth = 30;
    const hoursPerMonth = 24 * daysPerMonth;
    const daysPerYear = 365;
    const monthsPerYear = 12;
    const hoursPerYear = hoursPerMonth * monthsPerYear;
    final date = DateTime.tryParse(v);
    if (date == null) return '';
    final now = DateTime.now();
    final diff = now.difference(date);
    if (diff < const Duration(minutes: 1)) {
      return '刚刚';
    } else if (diff < const Duration(hours: 1)) {
      return '${diff.inMinutes}分钟前';
    } else if (diff < const Duration(days: 1)) {
      return '${diff.inHours}小时前';
    } else if (diff < const Duration(days: daysPerMonth)) {
      return '${diff.inHours ~/ hoursPerDay}天前';
    } else if (diff < const Duration(days: daysPerYear)) {
      return '${diff.inHours ~/ hoursPerMonth}个月前';
    } else {
      return '${diff.inHours ~/ hoursPerYear}年前';
    }
  }

  static String formatTime(String timeString) {
    if (timeString == "") {
      return "";
    }
    // 解析时间字符串为 DateTime 对象
    DateTime inputDateTime = DateTime.parse(timeString);

    // 获取当前时间
    DateTime now = DateTime.now();

    // 获取今天的起始时间（00:00:00）
    DateTime startOfDay = DateTime(now.year, now.month, now.day);

    // 获取昨天的日期
    DateTime yesterday = startOfDay.subtract(const Duration(days: 1));

    // 获取前天的日期
    DateTime dayBeforeYesterday = startOfDay.subtract(const Duration(days: 2));

    // 判断时间与当前日期的关系
    if (inputDateTime.isAfter(startOfDay)) {
      // 如果是今天，显示时间（HH:mm:ss）
      return inputDateTime.toString().substring(11, 19); // 提取 HH:mm:ss 部分
    } else if (inputDateTime.isAfter(yesterday) &&
        inputDateTime.isBefore(startOfDay)) {
      // 如果是昨天
      return "昨天";
    } else if (inputDateTime.isAfter(dayBeforeYesterday) &&
        inputDateTime.isBefore(yesterday)) {
      // 如果是前天
      return "前天";
    } else {
      // 如果是更早的日期，显示完整日期（yyyy-MM-dd）
      return inputDateTime.toString().substring(0, 10); // 提取 yyyy-MM-dd 部分
    }
  }

  static TextPainter _textPainter(
    String text, {
    required double maxWidth,
    TextStyle? style,
    TextDirection textDirection = TextDirection.ltr,
  }) {
    final span = TextSpan(text: text, style: style);
    final painter = TextPainter(text: span, textDirection: textDirection);
    painter.layout(maxWidth: maxWidth);
    return painter;
  }

  static Size sizeOfText(String text,
      {required double maxWidth, TextStyle? style}) {
    final painter = _textPainter(text, style: style, maxWidth: maxWidth);
    return Size(painter.width, painter.height);
  }

  ///计算问题高度
  static double heigthOfText(String text, double fontSize,
      FontWeight fontWeight, double maxWidth, int maxLines) {
    TextPainter textPainter = TextPainter(
      maxLines: maxLines,
      textDirection: TextDirection.ltr,
      text: TextSpan(
        text: text,
        style: TextStyle(
          fontWeight: fontWeight, //字重
          fontSize: fontSize, //字体大小
        ),
      ),
    );
    //最大宽度
    textPainter.layout(maxWidth: maxWidth);
    //返回高度
    return textPainter.height;
  }

  // 行数
  static int linesOfText(String text,
      {required double maxWidth, TextStyle? style}) {
    final painter = _textPainter(text, maxWidth: maxWidth);
    return painter.computeLineMetrics().length;
  }

  ///计算文本宽度
  static widthOfText(String text, TextStyle? style, maxWidth) {
    final textPainter = _textPainter(text, style: style, maxWidth: maxWidth);
    return textPainter.size.width;
  }

  static String md5Bytes(Uint8List bytes) => md5.convert(bytes).toString();

  static String md5String(String s) => md5.convert(utf8.encode(s)).toString();

  // [0, max)
  static int randInt(int max) => _random.nextInt(max);

  static T? asType<T>(dynamic value, {T? defaultValue}) {
    if (value == null) return null;
    return value is T ? value : defaultValue;
  }

  static List<String> get alphabetUpper =>
      List.generate(26, (i) => String.fromCharCode(i + 65));

  ///根据秒计算时长
  static String convertSeconds(int totalSeconds) {
    int hours = totalSeconds ~/ 3600; // 计算小时
    int minutes = (totalSeconds % 3600) ~/ 60; // 计算分钟
    int seconds = totalSeconds % 60; // 计算秒数

    // 格式化分钟和秒数，确保为两位数
    String formattedMinutes = minutes.toString().padLeft(2, '0');
    String formattedSeconds = seconds.toString().padLeft(2, '0');

    // 根据小时是否为 0 来构建结果字符串
    if (hours > 0) {
      return '$hours:$formattedMinutes:$formattedSeconds';
    } else {
      return '$formattedMinutes:$formattedSeconds';
    }
  }

  //日期格式化，带横杠链接
  static String dateFmtWith(
    String v, [
    List<String> formats = const ['yyyy', '-', 'mm', '-', 'dd'],
    bool toCST = true,
  ]) {
    var result = '';
    const cstOffset = Duration(hours: 8);

    try {
      DateTime date = v.isEmpty ? DateTime.now() : DateTime.parse(v);
      if (toCST && date.timeZoneOffset.compareTo(cstOffset) != 0) {
        // 这里add之后仍然是utc时间
        // !! 如果使用 z Z 时区相关format会有问题
        date = date.toUtc().add(cstOffset);
      }

      result = formatDate(date, formats);
    } on Exception catch (e) {
      logger.d("dateFmt pasrse error:$e");
    }
    return result;
  }

  static List<List<T>> chunkList<T>(List<T> list, int chunkSize) {
    List<List<T>> chunks = [];
    for (int i = 0; i < list.length; i += chunkSize) {
      int end = (i + chunkSize < list.length) ? i + chunkSize : list.length;
      chunks.add(list.sublist(i, end));
    }
    return chunks;
  }

  static Future<bool> checkNetworkStatus() async {
    try {
      final List<ConnectivityResult> connectivityResult =
          await (Connectivity().checkConnectivity());
      if (!connectivityResult.contains(ConnectivityResult.none)) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
