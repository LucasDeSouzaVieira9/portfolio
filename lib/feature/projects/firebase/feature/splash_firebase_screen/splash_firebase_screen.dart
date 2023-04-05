import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/widgets/instant_page_route.dart';

class SplashFirebaseScreen extends StatefulWidget {
  const SplashFirebaseScreen({Key? key}) : super(key: key);

  static const route = "splash_firebase_screen";

  static PageRoute<void> create(RouteSettings routeSettings) {
    return InstantPageRoute<void>(
      settings: routeSettings,
      builder: (context) {
        return const SplashFirebaseScreen();
      },
    );
  }

  @override
  State<SplashFirebaseScreen> createState() => _SplashFirebaseScreenState();
}

class _SplashFirebaseScreenState extends State<SplashFirebaseScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2)).then((value) {
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user == null) {
          Navigator.pushReplacementNamed(context, '/login');
        } else {
          Navigator.pushReplacementNamed(context, '/home');
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 28, 27, 27),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'lib/assets/images/firebase.png',
              height: 200,
            ),
          ),
          const SizedBox(height: 80),
          const CircularProgressIndicator(color: Color(0xffFFCB2B)),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}
