/*
 * @Author: wangdazhuang
 * @Date: 2024-08-15 17:14:24
 * @LastEditTime: 2025-06-18 19:20:29
 * @LastEditors: wdz
 * @Description: 
 * @FilePath: /xhs_app/lib/app.dart
 */

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:xhs_app/routes/pages.dart';
import 'package:xhs_app/routes/routes.dart';
import 'package:xhs_app/services/user_service.dart';
import 'package:xhs_app/utils/color.dart';
// import 'package:xhs_app/utils/consts.dart';
import 'package:xhs_app/utils/logger.dart';
import 'package:xhs_app/views/main/controllers/main_controller.dart';

import 'assets/colorx.dart';
import 'utils/consts.dart';

class MainApp extends StatelessWidget {
  static final customNavigatorObserver = CustomNavigatorObserver();

  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    const initialRoute = Routes.launch;
    const defaultTextStyle = TextStyle(color: COLOR.primaryText);
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      child: GetMaterialApp(
        theme: ThemeData(
            primaryColor: Colors.black,
            scaffoldBackgroundColor: COLOR.scaffoldBg,
            tabBarTheme: const TabBarTheme(
              dividerHeight: .0,
              dividerColor: COLOR.transparent,
              labelStyle: TextStyle(
                color: COLOR.primaryText,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              unselectedLabelStyle: TextStyle(
                color: COLOR.color_999999,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
            textTheme: const TextTheme(
              displayLarge: defaultTextStyle,
              displayMedium: defaultTextStyle,
              displaySmall: defaultTextStyle,
              headlineLarge: defaultTextStyle,
              headlineMedium: defaultTextStyle,
              headlineSmall: defaultTextStyle,
              titleLarge: defaultTextStyle,
              titleMedium: defaultTextStyle,
              titleSmall: defaultTextStyle,
              bodyLarge: defaultTextStyle,
              bodyMedium: defaultTextStyle,
              bodySmall: defaultTextStyle,
              labelLarge: defaultTextStyle,
              labelMedium: defaultTextStyle,
              labelSmall: defaultTextStyle,
            ),
            actionIconTheme: ActionIconThemeData(
              backButtonIconBuilder: (_) => const Icon(
                Consts.defaultBackButtonIcon,
                color: COLOR.backButton,
              ),
            ),
            appBarTheme: AppBarTheme(
              centerTitle: true,
              scrolledUnderElevation: 0.0,
              backgroundColor: COLOR.white,
              titleTextStyle: const TextStyle(
                fontSize: 18,
                color: COLOR.primaryText,
                fontWeight: FontWeight.w500,
              ),
              elevation: 0,
              // shadowColor: Colors.white.withOpacity(0.5),
              iconTheme: IconThemeData(color: ColorX.color_999999),
              surfaceTintColor: Colors.white,
              actionsIconTheme: const IconThemeData(color: COLOR.black),
            ),
            sliderTheme: const SliderThemeData(
              trackHeight: 6,
              disabledActiveTrackColor: COLOR.color_393939,
              disabledInactiveTrackColor: COLOR.color_393939,
              disabledThumbColor: COLOR.white,
              thumbColor: COLOR.white,
              disabledSecondaryActiveTrackColor: COLOR.color_393939,
              inactiveTrackColor: COLOR.color_393939,
              activeTickMarkColor: COLOR.color_B93FFF,
              activeTrackColor: COLOR.color_B93FFF,
            )),
        initialRoute: initialRoute,
        getPages: Pages.pages,
        navigatorObservers: [customNavigatorObserver],
        locale: const Locale('zh', 'CN'),
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        supportedLocales: const [
          Locale('zh', 'Hans'), //简体中文
          Locale('zh', 'CN'), //简体中文
        ],
        builder: (context, child) {
          return FlutterSmartDialog(child: child);
        },
      ),
    );
  }
}

class CustomNavigatorObserver extends NavigatorObserver {
  final _routes = <Route>[];

  bool hasNamedRoute(String name) =>
      _routes.indexWhere((e) => e.settings.name == name) >= 0;

  @override
  void didPop(Route route, Route? previousRoute) {
    _routes.remove(route);

    MainController? mainvc;
    try {
      // web页面刷新会丢失MainController
      mainvc = Get.find<MainController>();
    } catch (e) {
      logger.i(
          'didPop route:${route.settings.name},prev:${previousRoute?.settings.name}, $e');
    }

    final index = mainvc?.currentIndex.value;
    if (index == MainController.mine &&
        previousRoute != null &&
        (previousRoute.settings.name ?? '').startsWith("/home/")) {
      Get.find<UserService>().updateAll();
    }
    super.didPop(route, previousRoute);
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    _routes.add(route);
    super.didPush(route, previousRoute);
  }
}
