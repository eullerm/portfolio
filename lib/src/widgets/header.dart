import 'package:flutter/material.dart';
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
    print(MediaQuery.of(context).size);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 100),
      child: Align(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BoxButton(
              onClick: () => navigateTo(widget.leftButtonPath),
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
            Lifebar(
              percentOfLifebar: widget.page / widget.numberOfPages,
            ),
            BoxButton(
              onClick: () => navigateTo(widget.rightButtonPath),
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
          ],
        ),
      ),
    );
  }
}
