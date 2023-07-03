import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:portfolio/src/pages/404_error.dart';
import 'package:portfolio/src/pages/about_me.dart';
import 'package:portfolio/src/pages/experiences.dart';
import 'package:portfolio/src/pages/landing_page.dart';
import 'package:portfolio/src/pages/portfolio_code.dart';
import 'package:portfolio/src/pages/skills.dart';
import 'settings/settings_controller.dart';
import 'pages/settings.dart';
import 'package:portfolio/src/storage/local_storage.dart';

class MyApp extends StatefulWidget {
  final SettingsController settingsController;

  const MyApp({super.key, required this.settingsController});

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
          debugShowCheckedModeBanner: false,
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
            scrollbarTheme: ScrollbarThemeData(
              thumbColor: MaterialStateColor.resolveWith((Set<MaterialState> states) {
                return const Color(0xFF507335);
              }),
            ),
            textTheme: const TextTheme(
              displayLarge: TextStyle(fontSize: 32.0, fontFamily: 'PublicPixel', fontWeight: FontWeight.bold, color: Colors.black),
              displayMedium: TextStyle(fontSize: 24.0, fontFamily: 'PublicPixel', color: Colors.black),
              displaySmall: TextStyle(fontSize: 18.72, fontFamily: 'PublicPixel', color: Colors.black),
              bodyLarge: TextStyle(fontSize: 16.0, fontFamily: 'PublicPixel', height: 2, color: Colors.black),
              bodyMedium: TextStyle(fontSize: 13.28, fontFamily: 'PublicPixel', height: 2, color: Colors.black),
              bodySmall: TextStyle(fontSize: 10.72, fontFamily: 'PublicPixel', height: 2, color: Colors.black),
              labelLarge: TextStyle(fontSize: 16.0, fontFamily: 'PublicPixel', color: Colors.black),
              labelMedium: TextStyle(fontSize: 13.28, fontFamily: 'PublicPixel', color: Colors.black),
              labelSmall: TextStyle(fontSize: 10, fontFamily: 'PublicPixel', color: Colors.black),
            ),
            scaffoldBackgroundColor: Colors.transparent,
            primaryColor: Color(0xFF7fb258),
            colorScheme: ColorScheme(
              primary: Color(0xFF7fb258),
              secondary: Color(0xFF7fb258),
              background: Color(0xFF616161),
              brightness: Brightness.light,
              error: Colors.redAccent,
              onBackground: Colors.redAccent,
              onError: Colors.redAccent,
              onPrimary: Colors.redAccent,
              onSecondary: Colors.redAccent,
              onSurface: Colors.redAccent,
              surface: Colors.redAccent,
            ),
          ),
          darkTheme: ThemeData.dark().copyWith(
            scrollbarTheme: ScrollbarThemeData(
              thumbColor: MaterialStateColor.resolveWith((Set<MaterialState> states) {
                return const Color(0xFF507335);
              }),
            ),
            textTheme: const TextTheme(
              displayLarge: TextStyle(fontSize: 32.0, fontFamily: 'PublicPixel', fontWeight: FontWeight.bold, color: Colors.white),
              displayMedium: TextStyle(fontSize: 24.0, fontFamily: 'PublicPixel', color: Colors.white),
              displaySmall: TextStyle(fontSize: 18.72, fontFamily: 'PublicPixel', color: Colors.white),
              bodyLarge: TextStyle(fontSize: 16.0, fontFamily: 'PublicPixel', height: 2, color: Colors.white),
              bodyMedium: TextStyle(fontSize: 13.28, fontFamily: 'PublicPixel', height: 2, color: Colors.white),
              bodySmall: TextStyle(fontSize: 10.72, fontFamily: 'PublicPixel', height: 2, color: Colors.white),
              labelLarge: TextStyle(fontSize: 16.0, fontFamily: 'PublicPixel', color: Colors.white),
              labelMedium: TextStyle(fontSize: 13.28, fontFamily: 'PublicPixel', color: Colors.white),
              labelSmall: TextStyle(fontSize: 10, fontFamily: 'PublicPixel', color: Colors.white),
            ),
            scaffoldBackgroundColor: Colors.transparent,
            primaryColor: Color(0xFF3C5727),
            colorScheme: ColorScheme(
              primary: Color(0xFF3C5727),
              secondary: Color(0xFF2C411D),
              background: Color(0xFF2C2B2C),
              brightness: Brightness.dark,
              error: Colors.redAccent,
              onBackground: Colors.redAccent,
              onError: Colors.redAccent,
              onPrimary: Colors.redAccent,
              onSecondary: Colors.redAccent,
              onSurface: Colors.redAccent,
              surface: Colors.redAccent,
            ),
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
                const double numberOfPages = 5;
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
                        try {
                          switch (routeSettings.name) {
                            case LandingPage.routeName:
                              return LandingPage(page: 1, numberOfPages: numberOfPages);
                            case AboutMe.routeName:
                              return const AboutMe(page: 2, numberOfPages: numberOfPages);
                            case ExperiencesPage.routeName:
                              return const ExperiencesPage(page: 3, numberOfPages: numberOfPages);
                            case Skills.routeName:
                              return const Skills(page: 4, numberOfPages: numberOfPages);
                            case PortfolioCode.routeName:
                              return const PortfolioCode(page: 5, numberOfPages: numberOfPages);
                            case SettingsView.routeName:
                              return SettingsView(controller: widget.settingsController);

                            default:
                              return const Error404();
                          }
                        } catch (e) {
                          clearLocalStorage();
                          return const Error404();
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
