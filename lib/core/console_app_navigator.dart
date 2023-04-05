import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/feature/home/home_screen.dart';
import 'package:portfolio/feature/nav/app_navigator.dart';
import 'package:portfolio/feature/nav/nav_screen.dart';
import 'package:portfolio/feature/projects/dart_logic/cpf/cpf_validate_screen.dart';
import 'package:portfolio/feature/projects/firebase/feature/home_firebase_screen/home_firebase_screen.dart';
import 'package:portfolio/feature/projects/firebase/feature/login_screen/login_screen.dart';
import 'package:portfolio/feature/projects/firebase/feature/registration_screen/registration_screen.dart';
import 'package:portfolio/feature/projects/firebase/feature/splash_firebase_screen/splash_firebase_screen.dart';
import 'package:portfolio/feature/projects/firebase/feature/storage/storage_screen.dart';

class ConsoleAppNavigator extends AppNavigator {
  final GlobalKey<NavigatorState> _navigator;
  final GlobalKey<NavigatorState> _globalNavigator;
  ConsoleAppNavigator(this._navigator, this._globalNavigator);

  void _navigateToHomeItem(String route, {dynamic arguments}) async {
    await Navigator.of(_navigator.currentContext!).maybePop();
    Navigator.of(_navigator.currentContext!).pushNamedAndRemoveUntil(route, (Route<dynamic> r) {
      return r.settings.name == '/';
    }, arguments: arguments);
  }

  @override
  void navigateToNavScreen() {
    _globalNavigator.currentState!.pushNamed(
      NavBarScreen.route,
    );
  }

  @override
  void navigateToValidateCpf() {
    _navigateToHomeItem(CpfValidateScreen.route);
  }

  @override
  void navigateToHomeScreen() {
    _navigateToHomeItem(HomeScreen.route);
  }

  @override
  navigateToLoginScreen(context) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        _navigateToHomeItem(HomeFirebaseScreen.route);

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.green,
          content: Text('Voce ja esta logado!'),
        ));
      } else {
        _navigateToHomeItem(LoginScreen.route);
      }
    });
  }

  @override
  navigateToRegisterScreen(context) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        _navigateToHomeItem(HomeFirebaseScreen.route);

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.green,
          content: Text('Voce ja esta logado!'),
        ));
      } else {
        _navigateToHomeItem(RegistrationScreen.route);
      }
    });
  }

  @override
  navigateToSplashFirebaseScreen() {
    _navigateToHomeItem(SplashFirebaseScreen.route);
  }

  @override
  navigateToStorageScreen(context) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        _navigateToHomeItem(LoginScreen.route);

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.red,
          content: Text('é preciso fazer login!'),
        ));
      } else {
        _navigateToHomeItem(StorageScreen.route);
      }
    });
  }

  @override
  navigateToHomeFirebaseScreen() {
    _navigateToHomeItem(HomeFirebaseScreen.route);
  }
}
