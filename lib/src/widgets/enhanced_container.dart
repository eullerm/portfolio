import 'package:flutter/material.dart';

class EnhancedContainer extends StatelessWidget {
  final double width;
  final double height;

  const EnhancedContainer({super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width + 16,
      height: height + 16,
      child: Stack(
        children: [
          Positioned(
            top: 8,
            left: 8,
            child: Container(
              width: width + 8,
              height: height + 8,
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
                  Text.rich(
                    TextSpan(text: 'Euller Macena'),
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Text.rich(
                    TextSpan(text: 'Desenvolvedor Full Stack'),
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
