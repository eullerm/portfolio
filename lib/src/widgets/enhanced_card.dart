import 'package:flutter/material.dart';

class EnhancedCard extends StatelessWidget {
  final double width;
  final double height;
  final double? maxWidth;
  final double? maxHeight;
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
    this.maxWidth,
    this.maxHeight,
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
                child: Column(
                  mainAxisAlignment: mainAxisAlignment,
                  children: [
                    Visibility(
                      visible: header != null,
                      child: Padding(
                        padding: header != null ? const EdgeInsets.all(8) : const EdgeInsets.all(0),
                        child: header,
                      ),
                    ),
                    Visibility(
                      visible: content != null,
                      child: Flexible(
                        flex: 2,
                        child: Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: content != null ? const EdgeInsets.all(8) : const EdgeInsets.all(0),
                            child: Scrollbar(
                              thumbVisibility: true,
                              child: SingleChildScrollView(child: content ?? Container()),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: footer != null,
                      child: Flexible(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: footer != null ? const EdgeInsets.all(8) : const EdgeInsets.all(0),
                            child: footer,
                          ),
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
