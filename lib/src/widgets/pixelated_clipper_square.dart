import 'package:flutter/material.dart';

class PixelatedClipperSquare extends CustomClipper<Path> {
  double fracW;
  double fracH;
  PixelatedClipperSquare({
    this.fracW = 0.04,
    this.fracH = 0.1,
  });
  @override
  Path getClip(Size size) {
    double width = size.width;
    double height = size.height;

    final path = Path();

    //Diagonal inferior
    path.moveTo(fracW * width, (1 - fracH) * height); // 1/21.
    path.lineTo(2 * fracW * width, (1 - fracH) * height); // 2.
    path.lineTo(2 * fracW * width, 1 * height); // 3.
    path.lineTo((1 - 2 * fracW) * width, 1 * height); // 4.
    path.lineTo((1 - 2 * fracW) * width, (1 - fracH) * height); // 5.
    path.lineTo((1 - fracW) * width, (1 - fracH) * height); // 6.
    path.lineTo((1 - fracW) * width, (1 - 2 * fracH) * height); // 7.
    path.lineTo(1 * width, (1 - 2 * fracH) * height); // 8.
    path.lineTo(1 * width, 2 * fracH * height); // 9.
    path.lineTo((1 - fracW) * width, 2 * fracH * height); // 10.

    //Diagonal superior
    path.lineTo((1 - fracW) * width, fracH * height); // 11.
    path.lineTo((1 - 2 * fracW) * width, fracH * height); // 12.
    path.lineTo((1 - 2 * fracW) * width, 0 * height); // 13.
    path.lineTo(2 * fracW * width, 0 * height); // 14.
    path.lineTo(2 * fracW * width, fracH * height); // 15.
    path.lineTo(fracW * width, fracH * height); // 16.
    path.lineTo(fracW * width, 2 * fracH * height); // 17.
    path.lineTo(0 * width, 2 * fracH * height); // 18.
    path.lineTo(0 * width, (1 - 2 * fracH) * height); // 19.
    path.lineTo(fracW * width, (1 - 2 * fracH) * height); // 20.

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
