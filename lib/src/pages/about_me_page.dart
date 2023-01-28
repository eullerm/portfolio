import 'package:flutter/material.dart';
import 'package:portfolio/src/widgets/enhanced_container.dart';
import 'package:portfolio/src/widgets/lifebar.dart';
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

class _AboutMeState extends State<AboutMe> with TickerProviderStateMixin {
  bool startHoover = false;
  bool menuHoover = false;
  late AnimationController _controllerButtonLeft;
  late Animation<double> _animationButtonLeft;
  late AnimationController _controllerButtonRight;
  late Animation<double> _animationButtonRight;

  @override
  void initState() {
    super.initState();
    _controllerButtonLeft = AnimationController(
      duration: const Duration(milliseconds: 275),
      vsync: this,
    );
    _animationButtonLeft = Tween(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(
        parent: _controllerButtonLeft,
        curve: Curves.ease,
        reverseCurve: Curves.easeIn,
      ),
    );
    _controllerButtonLeft.addListener(() {
      setState(() {});
    });

    _controllerButtonRight = AnimationController(
      duration: const Duration(milliseconds: 275),
      vsync: this,
    );
    _animationButtonRight = Tween(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(
        parent: _controllerButtonRight,
        curve: Curves.ease,
        reverseCurve: Curves.easeIn,
      ),
    );
    _controllerButtonRight.addListener(() {
      setState(() {});
    });
  }

  void navigateTo(String path, {Object? arguments}) {
    if (path.isNotEmpty) {
      Navigator.pushNamed(context, path, arguments: arguments);
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(50),
      width: size.width,
      height: size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _header(),
          Flexible(
            flex: 1,
            child: Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  EnhancedContainer(
                    width: 650,
                    height: 600,
                    header: Container(
                      padding: const EdgeInsets.all(20),
                      child: Text.rich(
                        TextSpan(text: 'Sobre mim'),
                        style: Theme.of(context).textTheme.headline2,
                      ),
                    ),
                    content: Container(
                      padding: const EdgeInsets.all(20),
                      height: 400,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text.rich(
                            textAlign: TextAlign.justify,
                            TextSpan(
                              text:
                                  """Sou um desenvolvedor full stack com graduação em ciência da computação pela UFF. Apaixonado por criar aplicações que facilitem a vida do usuário. 
                              Minhas especializações incluem web e mobile.""",
                            ),
                            style: Theme.of(context).textTheme.bodyText1,
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
                  const SizedBox(
                    width: 32,
                  ),
                  EnhancedContainer(
                    width: 600,
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
    );
  }

  Widget _header() {
    return SizedBox(
      height: 100,
      child: Align(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MouseRegion(
              onEnter: (value) {
                setState(() {
                  _controllerButtonLeft.forward();
                });
              },
              onExit: (value) {
                setState(() {
                  _controllerButtonLeft.reverse();
                });
              },
              child: GestureDetector(
                onTap: () => navigateTo(''),
                child: ScaleTransition(
                  scale: _animationButtonLeft,
                  child: EnhancedContainer(
                    width: 60,
                    height: 60,
                    shadow: 8,
                    content: Image.asset(
                      'assets/images/LeftButton.png',
                      fit: BoxFit.cover,
                      width: 40,
                      height: 40,
                    ),
                  ),
                ),
              ),
            ),
            Lifebar(
              percentOfLifebar: widget.page / widget.numberOfPages,
            ),
            MouseRegion(
              onEnter: (value) {
                setState(() {
                  _controllerButtonRight.forward();
                });
              },
              onExit: (value) {
                setState(() {
                  _controllerButtonRight.reverse();
                });
              },
              child: GestureDetector(
                onTap: () => navigateTo(''),
                child: ScaleTransition(
                  scale: _animationButtonRight,
                  child: EnhancedContainer(
                    width: 60,
                    height: 60,
                    shadow: 8,
                    content: Image.asset(
                      'assets/images/RightButton.png',
                      fit: BoxFit.cover,
                      width: 40,
                      height: 40,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
