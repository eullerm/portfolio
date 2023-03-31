import 'package:flutter/material.dart';
import 'package:portfolio/src/widgets/pixelated_button.dart';

class Error404 extends StatefulWidget {
  const Error404({super.key});

  @override
  State<Error404> createState() => _Error404State();
}

class _Error404State extends State<Error404> {
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
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SelectableText.rich(
              textAlign: TextAlign.justify,
              TextSpan(
                text: '404 ERROR',
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
            SelectableText.rich(
              textAlign: TextAlign.justify,
              TextSpan(
                text: 'PAGE NOT FOUND',
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
          ],
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
                title: 'Back',
                onClick: () => navigateTo(''),
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
