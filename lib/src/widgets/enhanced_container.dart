import 'package:flutter/material.dart';

class EnhancedContainer extends StatelessWidget {
  final double width;
  final double height;
  final Widget? header;
  final Widget? content;
  final double shadow;
  final EdgeInsetsGeometry? padding;
  const EnhancedContainer({
    super.key,
    required this.width,
    required this.height,
    this.header,
    this.content,
    this.shadow = 16,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.all(0),
      child: SizedBox(
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
                color: Color(0xFF507335),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                width: width,
                height: height,
                color: Color(0xFFFFFFFF),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(child: header),
                    SizedBox(
                      height: (header != null && content != null) ? 50 : 0,
                    ),
                    SizedBox(child: content),
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
