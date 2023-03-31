import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:portfolio/src/widgets/pixelated_clipper_square.dart';

class Lifebar extends StatelessWidget {
  final double percentOfLifebar;

  const Lifebar({super.key, this.percentOfLifebar = 1});

  @override
  Widget build(BuildContext context) {
    const heartIcon = 'assets/icons/heart.svg';
    double lifebarSize = (MediaQuery.of(context).size.width - 200) > 250 ? 250 : MediaQuery.of(context).size.width - 200;
    double life = lifebarSize * percentOfLifebar;
    double positionOfLifebar = 0;

    positionOfLifebar = life - lifebarSize;

    return Hero(
      tag: 'lifebar',
      child: SizedBox(
        width: lifebarSize + 25,
        height: 40,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              left: 15,
              child: SizedBox(
                width: 300,
                height: 40,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      left: 0,
                      child: _backgroundLifebar(lifebarSize: lifebarSize),
                    ),
                    Positioned(
                      left: positionOfLifebar,
                      child: _lifebar(lifebarSize: lifebarSize),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              child: SvgPicture.asset(
                heartIcon,
                width: 40,
                height: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _backgroundLifebar({double lifebarSize = 250}) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ClipPath(
          clipper: PixelatedClipperSquare(
            fracW: 0.02,
            bottomRight: true,
            topRight: true,
          ),
          child: Container(
            color: Colors.black,
            height: 30.0,
            width: lifebarSize + 6,
          ),
        ),
        ClipPath(
          clipper: PixelatedClipperSquare(
            fracW: 0.02,
            bottomRight: true,
            topRight: true,
          ),
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
          clipper: PixelatedClipperSquare(
            fracW: 0.02,
            bottomRight: true,
            topRight: true,
          ),
          child: Container(
            color: Colors.black,
            height: 30.0,
            width: lifebarSize + 6,
          ),
        ),
        ClipPath(
          clipper: PixelatedClipperSquare(
            fracW: 0.02,
            bottomRight: true,
            topRight: true,
          ),
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
