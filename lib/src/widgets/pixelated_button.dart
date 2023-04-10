import 'package:flutter/material.dart';
import 'package:portfolio/src/widgets/box_button.dart';
import 'package:portfolio/src/widgets/pixelated_clipper_square.dart';

class PixelatedButton extends StatelessWidget {
  final String title;
  final Function()? onClick;
  final double? width;
  final double? height;
  final double? shadow;
  final TextStyle? style;
  const PixelatedButton({
    super.key,
    this.title = '',
    this.onClick,
    this.width,
    this.height,
    this.shadow,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return BoxButton(
      onClick: onClick,
      child: Container(
        width: width ?? 120 + (shadow ?? (width ?? 120) * 0.04),
        height: height ?? 48 + (shadow ?? (height ?? 48) * 0.10),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: ClipPath(
                clipper: PixelatedClipperSquare(
                  bottomRight: true,
                  topLeft: true,
                  bottomLeft: true,
                  topRight: true,
                ),
                child: Container(
                  color: Colors.black,
                  width: width ?? 120 + (shadow ?? (width ?? 120) * 0.04),
                  height: height ?? 48 + (shadow ?? (height ?? 48) * 0.10),
                ),
              ),
            ),
            Positioned(
              top: (shadow ?? (height ?? 48) * 0.10) / 2,
              left: (shadow ?? (width ?? 120) * 0.04) / 2,
              bottom: (shadow ?? (height ?? 48) * 0.10) / 2,
              right: (shadow ?? (width ?? 120) * 0.04) / 2,
              child: ClipPath(
                clipper: PixelatedClipperSquare(
                  bottomRight: true,
                  topLeft: true,
                  bottomLeft: true,
                  topRight: true,
                ),
                child: Container(
                  alignment: Alignment.center,
                  color: Theme.of(context).colorScheme.secondary,
                  width: width ?? 120,
                  height: height ?? 48,
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: style ?? Theme.of(context).textTheme.labelMedium,
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
