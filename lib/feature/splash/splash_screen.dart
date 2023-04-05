import 'package:flutter/material.dart';
import 'package:portfolio/core/app_colors.dart';
import 'package:portfolio/core/app_theme.dart';
import 'package:portfolio/core/inject.dart';
import 'package:portfolio/feature/nav/app_navigator.dart';
import 'package:portfolio/widgets/instant_page_route.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static const route = "splash";

  static PageRoute<void> create(RouteSettings routeSettings) {
    return InstantPageRoute<void>(
      settings: routeSettings,
      builder: (context) {
        return const SplashScreen();
      },
    );
  }

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    final AppNavigator appNavigator = inject<AppNavigator>();

    Future.delayed(const Duration(seconds: 3), () => appNavigator.navigateToNavScreen());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground1,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.my_library_books_sharp,
                size: 100,
                color: AppColors.darkBlue,
              ),
              const SizedBox(width: 5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Portfólio',
                    style: ThemeTextStyle.h4HeadlineBold().copyWith(fontSize: 30),
                  ),
                  Text(
                    'Lucas de souza vieira',
                    style: ThemeTextStyle.h4HeadlineBold(),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
