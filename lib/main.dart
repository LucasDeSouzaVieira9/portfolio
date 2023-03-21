import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:portfolio/core/get_size.dart';
import 'package:portfolio/core/inject.dart';
import 'package:portfolio/core/theme_data.dart';
import 'package:portfolio/feature/nav/nav_screen.dart';
import 'package:portfolio/feature/splash/splash_screen.dart';
import 'package:portfolio/firebase_options.dart';
import 'package:portfolio/inject.dart';
import 'package:portfolio/widgets/app_size_limiter.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await setupInjection();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  static void setLocale(BuildContext context, Locale newLocale) async {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();

    var prefs = await SharedPreferences.getInstance();
    prefs.setString('languageCode', newLocale.languageCode);
    prefs.setString('countryCode', "");

    // ignore: invalid_use_of_protected_member
    state?.setState(() => state._locale = newLocale);
  }

  static Locale getLocale(BuildContext context) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    return state?._locale ?? const Locale('pt');
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('pt');

  final GlobalKey<NavigatorState> _navigator =
      inject<GlobalKey<NavigatorState>>(instanceName: "global");

  @override
  void initState() {
    super.initState();
    _fetchLocale().then((locale) {
      setState(() {
        _locale = locale;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: CustomThemeData.themeData,
      navigatorKey: _navigator,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        if (GetSize.web(context)) {
          return AppSizeLimiter(child: child!);
        } else {
          return child!;
        }
      },
      title: 'Portifolio',
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: _locale,
      supportedLocales: const [
        Locale('en', ''), // English, no country code
        Locale('pt', ''), // Spanish, no country code
      ],
      initialRoute: SplashScreen.route,
      routes: const <String, WidgetBuilder>{},
      onGenerateRoute: (RouteSettings routeSettings) {
        switch (routeSettings.name) {
          case SplashScreen.route:
            return SplashScreen.create(routeSettings);
          case NavBarScreen.route:
            return NavBarScreen.create(routeSettings);
        }
        return null;
      },
    );
  }

  Future<Locale> _fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();

    String languageCode = prefs.getString('languageCode') ?? 'pt';
    String countryCode = prefs.getString('countryCode') ?? 'br';

    return Locale(languageCode, countryCode);
  }
}
