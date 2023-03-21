import 'dart:async';

import 'package:flutter/material.dart';
import 'package:portfolio/core/console_app_navigator.dart';
import 'package:portfolio/core/inject.dart';
import 'package:portfolio/feature/nav/app_navigator.dart';

Future<void> setupInjection() async {
  await inject.reset();

  inject.registerSingleton<GlobalKey<NavigatorState>>(
      GlobalKey<NavigatorState>(),
      instanceName: "navigator_settings");

  inject.registerSingleton<GlobalKey<NavigatorState>>(
      GlobalKey<NavigatorState>(),
      instanceName: "global");

  inject.registerLazySingleton<AppNavigator>(() {
    return ConsoleAppNavigator(
      inject<GlobalKey<NavigatorState>>(instanceName: "navigator_settings"),
      inject<GlobalKey<NavigatorState>>(instanceName: "global"),
    );
  });

  return inject.allReady();
}
