import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:portfolio/src/pages/about_me_page.dart';
import 'package:portfolio/src/pages/landing_page.dart';
import 'settings/settings_controller.dart';
import 'pages/settings.dart';

class MyApp extends StatefulWidget {
  final SettingsController settingsController;

  const MyApp({
    super.key,
    required this.settingsController,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  late AnimationController _backgroundController;
  late Animation<Offset> _backgroundAnimation;
  @override
  void initState() {
    super.initState();
    _backgroundController = AnimationController(vsync: this, duration: Duration(seconds: 10));
    _backgroundAnimation = Tween<Offset>(begin: Offset.zero, end: Offset(-100, 0)).animate(_backgroundController);
    _backgroundController.repeat();
  }

  @override
  void dispose() {
    _backgroundController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.settingsController,
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
              bodyText1: TextStyle(fontSize: 18.0, fontFamily: 'PublicPixel'),
              bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'PublicPixel'),
              button: TextStyle(fontSize: 25.0, fontFamily: 'PublicPixel', color: Colors.white),
            ),
            scaffoldBackgroundColor: Colors.black,
          ),
          darkTheme: ThemeData.dark().copyWith(
            textTheme: const TextTheme(
              headline1: TextStyle(fontSize: 80.0, fontFamily: 'PublicPixel', fontWeight: FontWeight.bold, color: Colors.black),
              headline2: TextStyle(fontSize: 50.0, fontFamily: 'PublicPixel', fontStyle: FontStyle.italic, color: Colors.black),
              headline3: TextStyle(fontSize: 30.0, fontFamily: 'PublicPixel', fontStyle: FontStyle.italic, color: Colors.black),
              bodyText1: TextStyle(fontSize: 18.0, fontFamily: 'PublicPixel'),
              bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'PublicPixel'),
              button: TextStyle(fontSize: 25.0, fontFamily: 'PublicPixel', color: Colors.white),
            ),
            scaffoldBackgroundColor: Colors.red,
          ),
          themeMode: widget.settingsController.themeMode,
          initialRoute: '/landing-page',
          onGenerateRoute: (RouteSettings routeSettings) {
            return PageRouteBuilder<void>(
              settings: routeSettings,
              fullscreenDialog: true,
              transitionDuration: const Duration(milliseconds: 500),
              reverseTransitionDuration: const Duration(milliseconds: 500),
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
                const double numberOfPages = 3;
                return Stack(
                  children: [
                    Image.asset(
                      'assets/images/background.jpg',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),

                    /* Positioned(
                      child: AnimatedBuilder(
                        animation: _backgroundAnimation,
                        builder: (context, child) {
                          return Transform.translate(
                            offset: _backgroundAnimation.value,
                            child: child,
                          );
                        },
                        child: Image.asset(
                          'assets/images/background.jpg',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                    ), */
                    Builder(
                      builder: (BuildContext _) {
                        switch (routeSettings.name) {
                          case LandingPage.routeName:
                            return const LandingPage(page: 1, numberOfPages: numberOfPages);
                          case AboutMe.routeName:
                            return const AboutMe(page: 2, numberOfPages: numberOfPages);
                          case SettingsView.routeName:
                            return SettingsView(controller: widget.settingsController);
                          default:
                            return const LandingPage(page: 1, numberOfPages: numberOfPages);
                        }
                      },
                    ),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }
}
