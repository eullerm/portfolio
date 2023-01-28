import 'package:flutter/material.dart';
import 'package:portfolio/src/widgets/enhanced_container.dart';
import 'package:portfolio/src/widgets/lifebar.dart';
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
  bool startHoover = false;
  bool menuHoover = false;

  void navigateTo(String path, {Object? arguments}) {
    Navigator.pushNamed(context, path, arguments: arguments);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(50),
      width: size.width,
      height: size.height,
      child: Column(
        children: [
          _header(),
          Flexible(
            flex: 3,
            child: Align(
              alignment: Alignment.center,
              child: EnhancedContainer(
                width: 1200,
                height: 400,
                header: Text.rich(
                  TextSpan(text: 'Euller Macena'),
                  style: Theme.of(context).textTheme.headline1,
                ),
                content: Text.rich(
                  TextSpan(text: 'Desenvolvedor Full Stack'),
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PixelatedButton(
                    title: 'Start',
                    onClick: () => navigateTo('/about-me'),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  PixelatedButton(
                    title: 'Menu',
                    onClick: () => print('menu'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _header() {
    return SizedBox(
      height: 100,
      child: Align(
        alignment: Alignment.center,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lifebar(
              percentOfLifebar: widget.page / widget.numberOfPages,
            ),
          ],
        ),
      ),
    );
  }
}
