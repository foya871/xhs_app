/*
 * @Author: wangdazhuang
 * @Date: 2024-08-15 17:14:24
 * @LastEditTime: 2025-03-01 13:51:23
 * @LastEditors: david wumingshi555888@gmail.com
 * @Description: 
 * @FilePath: /xhs_app/lib/main.dart
 */

import 'package:xhs_app/app.dart';
import 'package:xhs_app/app_prepare.dart';
import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();
  await AppPrepare.init();
  runApp(const MainApp());
}
