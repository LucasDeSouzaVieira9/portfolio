import 'package:flutter/material.dart';

abstract class AppNavigator {
  navigateToNavScreen();

  navigateToHomeScreen();

  navigateToValidateCpf();

  navigateToRegisterScreen(BuildContext context);

  navigateToSplashFirebaseScreen();

  navigateToStorageScreen(BuildContext context);

  navigateToLoginScreen(BuildContext context);

  navigateToHomeFirebaseScreen();
}
