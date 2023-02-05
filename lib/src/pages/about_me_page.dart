import 'package:flutter/material.dart';
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
        padding: const EdgeInsets.all(50),
        child: Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              EnhancedCard(
                margin: const EdgeInsets.all(16),
                width: 650,
                height: 600,
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
                  padding: const EdgeInsets.all(20),
                  height: 400,
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
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            TextSpan(
                              text: 'Minhas especializações incluem web e mobile.',
                              style: Theme.of(context).textTheme.bodyLarge,
                            )
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PixelatedButton(
                            title: 'Home',
                            onClick: () => navigateTo(''),
                          ),
                          const SizedBox(
                            width: 50,
                          ),
                          PixelatedButton(
                            title: 'Menu',
                            onClick: () => navigateTo('/menu'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              EnhancedContainer(
                margin: const EdgeInsets.all(16),
                width: 600,
                height: 600,
                child: Center(
                  child: Image.asset(
                    'assets/images/euller.jpg',
                    height: 550,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
