import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/core/app_colors.dart';
import 'package:portfolio/core/get_size.dart';
import 'package:portfolio/core/inject.dart';
import 'package:portfolio/feature/dart_logic/cpf/cpf_validate_screen.dart';
import 'package:portfolio/feature/firebase/feature/home_firebase_screen/home_firebase_screen.dart';
import 'package:portfolio/feature/firebase/feature/login_screen/login_screen.dart';
import 'package:portfolio/feature/firebase/feature/registration_screen/registration_screen.dart';
import 'package:portfolio/feature/firebase/feature/splash_firebase_screen/splash_firebase_screen.dart';
import 'package:portfolio/feature/firebase/feature/storage/storage_screen.dart';
import 'package:portfolio/feature/home/home_screen.dart';
import 'package:portfolio/packages/instant_page_route.dart';

class NavigatorSettings extends StatelessWidget {
  NavigatorSettings({
    Key? key,
  }) : super(key: key);

  static const route = "nav_settings";

  static PageRoute<void> create(RouteSettings routeSettings) {
    return InstantPageRoute<void>(
      settings: routeSettings,
      builder: (context) {
        return NavigatorSettings();
      },
    );
  }

  final GlobalKey<NavigatorState> _navigator =
      inject<GlobalKey<NavigatorState>>(instanceName: "navigator_settings");

  @override
  Widget build(BuildContext context) {
    return DevicePreview(
      enabled: GetSize.web(context),
      backgroundColor: AppColors.darkBackground2,
      isToolbarVisible: false,
      defaultDevice: Devices.ios.iPhone13,
      builder: ((context) => Navigator(
            key: _navigator,
            initialRoute: HomeScreen.route,
            onGenerateRoute: ((RouteSettings settings) {
              switch (settings.name) {
                case HomeScreen.route:
                  return HomeScreen.create(settings);
                case CpfValidateScreen.route:
                  return CpfValidateScreen.create(settings);
                case RegistrationScreen.route:
                  return RegistrationScreen.create(settings);
                case SplashFirebaseScreen.route:
                  return SplashFirebaseScreen.create(settings);
                case StorageScreen.route:
                  return StorageScreen.create(settings);
                case LoginScreen.route:
                  return LoginScreen.create(settings);
                case HomeFirebaseScreen.route:
                  return HomeFirebaseScreen.create(settings);
              }
              return null;
            }),
          )),
    );
  }
}
