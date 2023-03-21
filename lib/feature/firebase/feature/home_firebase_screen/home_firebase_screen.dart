import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/packages/instant_page_route.dart';

class HomeFirebaseScreen extends StatefulWidget {
  const HomeFirebaseScreen({Key? key}) : super(key: key);

  static const route = "home_firebase_screen";

  static PageRoute<void> create(RouteSettings routeSettings) {
    return InstantPageRoute<void>(
      settings: routeSettings,
      builder: (context) {
        return const HomeFirebaseScreen();
      },
    );
  }

  @override
  State<HomeFirebaseScreen> createState() => _HomeFirebaseScreenState();
}

class _HomeFirebaseScreenState extends State<HomeFirebaseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xffFFCB2B),
        title: const Text('Firebase', style: TextStyle(color: Colors.black)),
      ),
      backgroundColor: const Color.fromARGB(255, 28, 27, 27),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const CardHome(
                label: 'Storage',
                routeName: '/storage',
              ),
              const SizedBox(height: 10),
              const CardHome(
                label: 'Cloud Messaging',
                fontSize: 35,
                routeName: '/storage',
              ),
              const SizedBox(height: 10),
              const CardHome(
                label: 'Cloud Messaging Chat',
                fontSize: 35,
                routeName: '/storage',
              ),
              ElevatedButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  },
                  child: const Text('signOut')),
            ],
          ),
        ),
      ),
    );
  }
}

class CardHome extends StatelessWidget {
  final String label;
  final String routeName;
  final double? fontSize;
  const CardHome({
    Key? key,
    required this.label,
    required this.routeName,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, routeName),
      child: Container(
        constraints: const BoxConstraints(minHeight: 70),
        decoration: BoxDecoration(
          color: const Color(0xffFFCB2B),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                label,
                style: TextStyle(fontSize: fontSize ?? 50),
                textAlign: TextAlign.center,
              ),
            ),
            Row(),
          ],
        ),
      ),
    );
  }
}
