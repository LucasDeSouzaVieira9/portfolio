import 'package:flutter/material.dart';
import 'package:portfolio/core/get_size.dart';
import 'package:portfolio/feature/nav/nav_menu_screen.dart';
import 'package:portfolio/feature/nav/navigator_settings.dart';
import 'package:portfolio/packages/instant_page_route.dart';

class NavBarScreen extends StatelessWidget {
  const NavBarScreen({Key? key}) : super(key: key);
  static const route = "/";

  static PageRoute<void> create(RouteSettings routeSettings) {
    return InstantPageRoute<void>(
      settings: routeSettings,
      builder: (context) {
        return const NavBarScreen();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: !GetSize.getNavBar(context) ? AppBar() : null,
      drawer: !GetSize.getNavBar(context)
          ? Drawer(
              width: GetSize.widthPorc(context, 80),
              child: const NavBarMenuScreen(),
            )
          : null,
      body: Row(
        children: [
          if (GetSize.getNavBar(context)) const NavBarMenuScreen(),
          Expanded(
            child: NavigatorSettings(),
          ),
        ],
      ),
    );
  }
}
