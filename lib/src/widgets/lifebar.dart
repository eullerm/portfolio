import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:portfolio/src/widgets/pixelated_clipper_square.dart';

class Lifebar extends StatelessWidget {
  final double percentOfLifebar;

  const Lifebar({super.key, this.percentOfLifebar = 1 / 2});

  @override
  Widget build(BuildContext context) {
    const heartIcon = 'icons/heart.svg';
    double lifebarSize = 250;
    double life = lifebarSize * percentOfLifebar;
    double positionOfLifebar = 0;
    if (life == lifebarSize) {
      positionOfLifebar = 15;
    } else {
      // 15 is the left value of the Positioned Widget
      positionOfLifebar = life - (lifebarSize - 15);
    }

    return SizedBox(
      width: 300,
      height: 40,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 15,
            child: _backgroundLifebar(lifebarSize: lifebarSize),
          ),
          // Doesn't show the overflow of lifebar to the left
          Positioned(
            left: positionOfLifebar,
            child: _lifebar(lifebarSize: lifebarSize),
          ),
          Positioned(
            left: 0,
            child: Container(
              width: 20,
              height: 40,
              color: Colors.black,
            ),
          ),
          Positioned(
            left: 0,
            child: SvgPicture.asset(heartIcon, width: 40, height: 40),
          ),
        ],
      ),
    );
  }

  Widget _backgroundLifebar({double lifebarSize = 250}) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ClipPath(
          clipper: PixelatedClipperSquare(fracW: 0.02),
          child: Container(
            color: Colors.black,
            height: 30.0,
            width: lifebarSize + 5,
          ),
        ),
        ClipPath(
          clipper: PixelatedClipperSquare(fracW: 0.02),
          child: Container(
            color: Colors.white,
            height: 20.0,
            width: lifebarSize,
          ),
        ),
      ],
    );
  }

  _lifebar({required double lifebarSize}) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ClipPath(
          clipper: PixelatedClipperSquare(fracW: 0.02),
          child: Container(
            color: Colors.black,
            height: 30.0,
            width: lifebarSize + 5,
          ),
        ),
        ClipPath(
          clipper: PixelatedClipperSquare(fracW: 0.02),
          child: Container(
            color: Colors.red,
            height: 20.0,
            width: lifebarSize,
          ),
        ),
      ],
    );
  }
}
