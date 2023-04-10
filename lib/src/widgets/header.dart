import 'package:flutter/material.dart';
import 'package:portfolio/src/responsive/responsive.dart';
import 'package:portfolio/src/widgets/box_button.dart';
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

class _HeaderState extends State<Header> {
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
  }

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive(context: context);
    double width = 60;
    double height = 60;
    double shadow = 8;
    double widthIcon = 40;
    double heightIcon = 40;

    if (responsive.screen == 'MOBILE') {
      width = 50;
      height = 50;
      shadow = 8;
      widthIcon = 30;
      heightIcon = 30;
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: ['4K', 'DESKTOP', 'TABLET'].contains(responsive.screen) ? 100.0 : 4.0),
      child: Align(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Visibility(
              visible: widget.needLeftButton && widget.needLeftButton,
              child: BoxButton(
                onClick: () => navigateTo(widget.leftButtonPath),
                child: EnhancedContainer(
                  width: width,
                  height: height,
                  shadow: shadow,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/icons/LeftButton.png',
                      fit: BoxFit.scaleDown,
                      width: widthIcon,
                      height: heightIcon,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Lifebar(
                percentOfLifebar: widget.page / widget.numberOfPages,
              ),
            ),
            Visibility(
              visible: widget.needLeftButton && widget.needLeftButton,
              child: BoxButton(
                onClick: () => navigateTo(widget.rightButtonPath),
                child: EnhancedContainer(
                  width: width,
                  height: height,
                  shadow: shadow,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/icons/RightButton.png',
                      fit: BoxFit.scaleDown,
                      width: widthIcon,
                      height: heightIcon,
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
