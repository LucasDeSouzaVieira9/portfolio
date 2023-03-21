import 'package:flutter/material.dart';
import 'package:portfolio/packages/instant_page_route.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const route = "home_screen";

  static PageRoute<void> create(RouteSettings routeSettings) {
    return InstantPageRoute<void>(
      settings: routeSettings,
      builder: (context) {
        return const HomeScreen();
      },
    );
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // var locale = MyApp.getLocale(context);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 50),
          const CircleAvatar(
            maxRadius: 50,
            child: Icon(Icons.person),
          ),
          const SizedBox(height: 30),
          Row(
            children: const [],
          ),
          const Text('asdasdasdsadas asdasd'),
        ],
      ),
    );
  }
}
