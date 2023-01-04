import 'package:flutter/material.dart';
import 'package:portfolio/src/widgets/enhanced_container.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LandingPage extends StatefulWidget {
  static const routeName = '/landing-page';
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const heartIcon = 'icons/heart.svg';
    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      body: Container(
        padding: const EdgeInsets.all(50),
        width: size.width,
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(
              heartIcon,
              width: 40.0,
              height: 40.0,
            ),
            const EnhancedContainer(
              width: 1200,
              height: 400,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(200.0, 80.0),
                    backgroundColor: Color(0xFF507335),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Start',
                    style: Theme.of(context).textTheme.button,
                  ),
                ),
                const SizedBox(
                  width: 50,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(200.0, 80.0),
                    backgroundColor: Color(0xFF507335),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Menu',
                    style: Theme.of(context).textTheme.button,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
