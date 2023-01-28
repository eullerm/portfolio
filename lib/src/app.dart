import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:portfolio/src/pages/landing_page.dart';
import 'settings/settings_controller.dart';
import 'pages/settings.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          restorationScopeId: 'app',
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''),
            Locale('pt', 'BR'),
          ],
          onGenerateTitle: (BuildContext context) => AppLocalizations.of(context)!.appTitle,
          theme: ThemeData(
            textTheme: const TextTheme(
              headline1: TextStyle(fontSize: 80.0, fontFamily: 'PublicPixel', fontWeight: FontWeight.bold, color: Colors.black),
              headline2: TextStyle(fontSize: 30.0, fontFamily: 'PublicPixel', fontStyle: FontStyle.italic, color: Colors.black),
              bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
              button: TextStyle(fontSize: 25.0, fontFamily: 'PublicPixel', color: Colors.white),
            ),
            scaffoldBackgroundColor: Colors.black,
          ),
          darkTheme: ThemeData.dark().copyWith(
            textTheme: const TextTheme(
              headline1: TextStyle(fontSize: 80.0, fontFamily: 'PublicPixel', fontWeight: FontWeight.bold, color: Colors.black),
              headline2: TextStyle(fontSize: 30.0, fontFamily: 'PublicPixel', fontStyle: FontStyle.italic, color: Colors.black),
              bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
              button: TextStyle(fontSize: 25.0, fontFamily: 'PublicPixel', color: Colors.white),
            ),
            scaffoldBackgroundColor: Colors.red,
          ),
          themeMode: settingsController.themeMode,
          initialRoute: '/landing-page',
          onGenerateRoute: (RouteSettings routeSettings) {
            return PageRouteBuilder<void>(
              settings: routeSettings,
              fullscreenDialog: true,
              transitionDuration: const Duration(milliseconds: 100),
              reverseTransitionDuration: const Duration(milliseconds: 100),
              transitionsBuilder: (
                BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child,
              ) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0.0, 1.0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                );
              },
              pageBuilder: (
                BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
              ) {
                const double numberOfPages = 2;
                switch (routeSettings.name) {
                  case LandingPage.routeName:
                    return const LandingPage(page: 1, numberOfPages: numberOfPages);
                  case SettingsView.routeName:
                    return SettingsView(controller: settingsController);
                  default:
                    return const LandingPage(page: 1, numberOfPages: numberOfPages);
                }
              },
            );
          },
        );
      },
    );
  }
}
