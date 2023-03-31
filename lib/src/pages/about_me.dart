import 'package:flutter/material.dart';
import 'package:portfolio/src/responsive/responsive.dart';
import 'package:portfolio/src/widgets/enhanced_card.dart';
import 'package:portfolio/src/widgets/enhanced_container.dart';
import 'package:portfolio/src/widgets/header.dart';
import 'package:portfolio/src/widgets/pixelated_button.dart';

class AboutMe extends StatefulWidget {
  static const routeName = '/about-me';
  final Object? arguments;
  final double page;
  final double numberOfPages;
  const AboutMe({super.key, this.arguments, required this.page, required this.numberOfPages});

  @override
  State<AboutMe> createState() => _AboutMeState();
}

class _AboutMeState extends State<AboutMe> {
  bool startHoover = false;
  bool menuHoover = false;

  void navigateTo(String path, {Object? arguments}) {
    if (path.isNotEmpty) {
      Navigator.pushNamed(context, path, arguments: arguments);
    } else {
      Navigator.pop(context);
    }
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
          leftButtonPath: '',
          rightButtonPath: '/experiences',
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: ['4K', 'DESKTOP'].contains(responsive.screen) ? 50 : 8),
        child: Align(
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
      ),
    );
  }

  Widget mobile() {
    return SingleChildScrollView(
      child: Column(
        children: [
          aboutMe(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.width * 0.9,
          ),
          photo(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.width * 0.8,
          ),
        ],
      ),
    );
  }

  Widget tablet() {
    return SingleChildScrollView(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          aboutMe(
            width: MediaQuery.of(context).size.width * 0.4,
            height: MediaQuery.of(context).size.width * 0.4,
          ),
          photo(
            width: MediaQuery.of(context).size.width * 0.4,
            height: MediaQuery.of(context).size.width * 0.4,
          ),
        ],
      ),
    );
  }

  Widget desktop() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        aboutMe(
          width: MediaQuery.of(context).size.width * 0.4,
          height: MediaQuery.of(context).size.width * 0.4,
        ),
        photo(
          width: MediaQuery.of(context).size.width * 0.4,
          height: MediaQuery.of(context).size.width * 0.4,
        ),
      ],
    );
  }

  Widget aboutMe({required double width, required double height, double? buttonWidth, double? buttonHeight}) {
    return EnhancedCard(
      width: width > 600 ? 600 : width,
      height: height > 600 ? 600 : height,
      margin: EdgeInsets.all(16),
      header: Container(
        padding: const EdgeInsets.all(20),
        child: SelectableText.rich(
          textAlign: TextAlign.justify,
          TextSpan(
            text: 'Sobre mim',
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
      ),
      content: Container(
        padding: EdgeInsets.symmetric(horizontal: width > 600 ? 20.0 : 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SelectableText.rich(
              textAlign: TextAlign.justify,
              TextSpan(
                children: [
                  TextSpan(
                    text:
                        "Sou um desenvolvedor full stack com graduação em ciência da computação pela UFF. Apaixonado por criar aplicações que facilitem a vida do usuário.\n",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  TextSpan(
                    text: 'Minhas especializações incluem web e mobile.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      footer: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PixelatedButton(
            title: 'Home',
            onClick: () => navigateTo(''),
          ),
          PixelatedButton(
            title: 'Menu',
            onClick: () => navigateTo('/menu'),
          ),
        ],
      ),
    );
  }

  Widget photo({required double width, required double height}) {
    return EnhancedContainer(
      width: width > 600 ? 600 : width,
      height: height > 600 ? 600 : height,
      margin: EdgeInsets.all(16),
      child: Center(
        child: Image.asset(
          'assets/images/euller.jpg',
          width: width - 20 > 580 ? 580 : width - 20,
        ),
      ),
    );
  }
}
