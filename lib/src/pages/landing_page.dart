import 'package:flutter/material.dart';
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
  bool startHoover = false;
  bool menuHoover = false;

  void navigateTo(String path, {Object? arguments}) {
    Navigator.pushNamed(context, path, arguments: arguments);
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
          needLeftButton: false,
          needRightButton: false,
        ),
      ),
      body: Align(
        alignment: Alignment.center,
        child: EnhancedCard(
          width: 1200,
          height: 400,
          header: SelectableText.rich(
            textAlign: TextAlign.justify,
            TextSpan(
              text: 'Euller Macena',
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ),
          content: SelectableText.rich(
            textAlign: TextAlign.justify,
            TextSpan(
              text: 'Desenvolvedor Full Stack',
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 200,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: PixelatedButton(
                title: 'Start',
                onClick: () => navigateTo('/about-me'),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: PixelatedButton(
                title: 'Menu',
                onClick: () => print('menu'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
