import 'package:flutter/material.dart';
import 'package:portfolio/src/widgets/enhanced_container.dart';
import 'package:portfolio/src/widgets/header.dart';

class Experiences extends StatefulWidget {
  static const routeName = '/experiences';
  final Object? arguments;
  final double page;
  final double numberOfPages;
  const Experiences({super.key, this.arguments, required this.page, required this.numberOfPages});

  @override
  State<Experiences> createState() => _ExperiencesState();
}

class _ExperiencesState extends State<Experiences> {
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
          leftButtonPath: '/about-me',
          rightButtonPath: '/skills',
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(50),
        child: Wrap(
          runSpacing: 50,
          children: [
            Align(
              alignment: Alignment.center,
              child: EnhancedContainer(
                width: 1200,
                height: 100,
                header: RichText(
                  text: TextSpan(
                    text: 'Experiências',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height - kToolbarHeight - 250,
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: 32,
                  runSpacing: 32,
                  children: [
                    EnhancedContainer(
                      padding: const EdgeInsets.all(16),
                      width: 500,
                      height: 600,
                      content: Center(
                        child: Image.asset(
                          'assets/images/euller.jpg',
                          height: 550,
                        ),
                      ),
                    ),
                    EnhancedContainer(
                      padding: const EdgeInsets.all(16),
                      width: 500,
                      height: 600,
                      content: Center(
                        child: Image.asset(
                          'assets/images/euller.jpg',
                          height: 550,
                        ),
                      ),
                    ),
                    EnhancedContainer(
                      padding: const EdgeInsets.all(16),
                      width: 500,
                      height: 600,
                      content: Center(
                        child: Image.asset(
                          'assets/images/euller.jpg',
                          height: 550,
                        ),
                      ),
                    ),
                    EnhancedContainer(
                      padding: const EdgeInsets.all(16),
                      width: 500,
                      height: 600,
                      content: Center(
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
          ],
        ),
      ),
    );
  }
}
