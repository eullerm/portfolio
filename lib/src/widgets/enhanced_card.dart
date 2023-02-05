import 'package:flutter/material.dart';

class EnhancedCard extends StatelessWidget {
  final double width;
  final double height;
  final Widget? header;
  final Widget? content;
  final Widget? footer;
  final double shadow;
  final EdgeInsetsGeometry? margin;
  final MainAxisAlignment mainAxisAlignment;
  const EnhancedCard({
    super.key,
    required this.width,
    required this.height,
    this.header,
    this.content,
    this.footer,
    this.shadow = 16,
    this.margin,
    this.mainAxisAlignment = MainAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.all(0),
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
                color: const Color(0xFF507335),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                width: width,
                height: height,
                color: const Color(0xFFFFFFFF),
                child: Column(
                  mainAxisAlignment: mainAxisAlignment,
                  children: [
                    Padding(padding: header != null ? const EdgeInsets.all(16) : const EdgeInsets.all(0), child: header),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(padding: content != null ? const EdgeInsets.all(16) : const EdgeInsets.all(0), child: content),
                          Padding(padding: footer != null ? const EdgeInsets.all(16) : const EdgeInsets.all(0), child: footer),
                        ],
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
