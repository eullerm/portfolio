import 'package:flutter/material.dart';
import 'package:portfolio/src/widgets/enhanced_container.dart';
import 'package:portfolio/src/widgets/lifebar.dart';

class Header extends StatefulWidget {
  final double page;
  final double numberOfPages;
  final String leftButtonPath;
  final String rightButtonPath;
  final bool needLeftButton;
  final bool needRightButton;
  const Header({
    super.key,
    required this.page,
    required this.numberOfPages,
    this.leftButtonPath = '',
    this.rightButtonPath = '',
    this.needLeftButton = true,
    this.needRightButton = true,
  });

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> with TickerProviderStateMixin {
  late AnimationController _controllerButtonLeft;
  late Animation<double> _animationButtonLeft;
  late AnimationController _controllerButtonRight;
  late Animation<double> _animationButtonRight;

  void navigateTo(String path, {Object? arguments}) {
    if (path.isNotEmpty) {
      Navigator.pushNamed(context, path, arguments: arguments);
    } else {
      Navigator.pop(context);
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 100),
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
                onTap: () => navigateTo(widget.leftButtonPath),
                child: ScaleTransition(
                  scale: _animationButtonLeft,
                  child: EnhancedContainer(
                    width: widget.needLeftButton ? 60 : 0,
                    height: widget.needLeftButton ? 60 : 0,
                    shadow: 8,
                    child: Image.asset(
                      'assets/icons/LeftButton.png',
                      fit: BoxFit.scaleDown,
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
                onTap: () => navigateTo(widget.rightButtonPath),
                child: ScaleTransition(
                  scale: _animationButtonRight,
                  child: EnhancedContainer(
                    width: widget.needRightButton ? 60 : 0,
                    height: widget.needRightButton ? 60 : 0,
                    shadow: 8,
                    child: Image.asset(
                      'assets/icons/RightButton.png',
                      fit: BoxFit.scaleDown,
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
