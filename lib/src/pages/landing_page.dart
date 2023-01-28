import 'package:flutter/material.dart';
import 'package:portfolio/src/widgets/enhanced_container.dart';
import 'package:portfolio/src/widgets/lifebar.dart';
import 'package:portfolio/src/widgets/pixelated_button.dart';
import 'package:portfolio/src/widgets/pixelated_clipper_square.dart';

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
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      body: Container(
        padding: const EdgeInsets.all(50),
        width: size.width,
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Lifebar(
              percentOfLifebar: widget.page / widget.numberOfPages,
            ),
            const EnhancedContainer(
              width: 1200,
              height: 400,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PixelatedButton(
                  title: 'Start',
                  onClick: () => print('start'),
                ),
                const SizedBox(
                  width: 50,
                ),
                PixelatedButton(
                  title: 'Menu',
                  onClick: () => print('menu'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
