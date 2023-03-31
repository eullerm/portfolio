import 'package:flutter/material.dart';

class EnhancedContainer extends StatelessWidget {
  final double width;
  final double height;
  final double? maxWidth;
  final double? maxHeight;
  final Widget? child;
  final double shadow;
  final EdgeInsetsGeometry? margin;
  final MainAxisAlignment mainAxisAlignment;
  const EnhancedContainer({
    super.key,
    required this.width,
    required this.height,
    this.maxWidth,
    this.maxHeight,
    this.child,
    this.shadow = 16,
    this.margin,
    this.mainAxisAlignment = MainAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.all(0),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: maxWidth ?? width + shadow,
          maxHeight: maxHeight ?? height + shadow,
        ),
        width: width + shadow,
        height: height + shadow,
        child: Stack(
          children: [
            Positioned(
              top: shadow / 2,
              left: shadow / 2,
              child: Container(
                width: width + shadow / 2,
                height: height + shadow / 2,
                color: Theme.of(context).colorScheme.background,
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                width: width,
                height: height,
                color: Theme.of(context).primaryColor,
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
