import 'package:flutter/material.dart';
import 'package:portfolio/src/responsive/responsive.dart';
import 'package:portfolio/src/widgets/enhanced_card.dart';
import 'package:portfolio/src/widgets/header.dart';
import 'package:portfolio/src/widgets/pixelated_button.dart';

class LandingPage extends StatefulWidget {
  static const routeName = '/landing-page';
  final Object? arguments;
  final double page;
  final double numberOfPages;
  const LandingPage({super.key, this.arguments, required this.page, required this.numberOfPages});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  void navigateTo(String path, {Object? arguments}) {
    Navigator.pushNamed(context, path, arguments: arguments);
  }

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive(context: context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Header(
          page: widget.page,
          numberOfPages: widget.numberOfPages,
          needLeftButton: false,
          needRightButton: false,
        ),
      ),
      body: Align(
        alignment: Alignment.center,
        child: Builder(builder: (BuildContext _) {
          switch (responsive.screen) {
            case '4K':
              return desktop();
            case 'DESKTOP':
              return desktop();
            case 'MOBILE':
              return mobile();
            case 'TABLET':
              return tablet();
            default:
              return desktop();
          }
        }),
      ),
      bottomNavigationBar: Builder(builder: (BuildContext _) {
        switch (responsive.screen) {
          case '4K':
            return desktopBottomNavigationBar();
          case 'DESKTOP':
            return desktopBottomNavigationBar();
          case 'MOBILE':
            return mobileBottomNavigationBar();
          case 'TABLET':
            return tabletBottomNavigationBar();
          default:
            return desktopBottomNavigationBar();
        }
      }),
    );
  }

  Widget mobile() {
    double width = MediaQuery.of(context).size.width * 0.9;
    double height = MediaQuery.of(context).size.height * 0.4;
    return EnhancedCard(
      width: width > 1200 ? 1200 : width,
      height: height > 400 ? 400 : height,
      mainAxisAlignment: MainAxisAlignment.center,
      content: content(
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget tablet() {
    double width = MediaQuery.of(context).size.width * 0.8;
    double height = MediaQuery.of(context).size.height * 0.4;
    return EnhancedCard(
      width: width > 1200 ? 1200 : width,
      height: height > 400 ? 400 : height,
      mainAxisAlignment: MainAxisAlignment.center,
      content: content(),
    );
  }

  Widget desktop() {
    double width = MediaQuery.of(context).size.width * 0.8;
    double height = MediaQuery.of(context).size.height * 0.4;
    return EnhancedCard(
      width: width > 1200 ? 1200 : width,
      height: height > 400 ? 400 : height,
      mainAxisAlignment: MainAxisAlignment.center,
      content: content(),
    );
  }

  Widget mobileBottomNavigationBar() {
    return SizedBox(
      height: 180,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: buttons(),
      ),
    );
  }

  Widget tabletBottomNavigationBar() {
    return SizedBox(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: buttons(),
      ),
    );
  }

  Widget desktopBottomNavigationBar() {
    return SizedBox(
      height: 160,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: buttons(),
      ),
    );
  }

  List<Widget> buttons({double? width, double? height}) {
    return [
      Container(
        padding: const EdgeInsets.all(16),
        child: PixelatedButton(
          width: width,
          height: height,
          title: 'Start',
          onClick: () => navigateTo('/about-me'),
        ),
      ),
      Container(
        padding: const EdgeInsets.all(16),
        child: PixelatedButton(
          width: width,
          height: height,
          title: 'Menu',
          onClick: () => print('menu'),
        ),
      ),
    ];
  }

  Widget content({TextAlign textAlign = TextAlign.justify}) {
    return Column(
      children: [
        SelectableText.rich(
          textAlign: textAlign,
          TextSpan(
            text: 'Euller Macena',
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        SizedBox(
          height: 16,
        ),
        SelectableText.rich(
          textAlign: textAlign,
          TextSpan(
            text: 'Desenvolvedor Full Stack',
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ),
      ],
    );
  }
}
