import 'package:flutter/material.dart';
import 'package:portfolio/src/widgets/pixelated_clipper_square.dart';

class PixelatedButton extends StatefulWidget {
  final String title;
  final Function()? onClick;
  const PixelatedButton({super.key, this.title = '', this.onClick});

  @override
  State<PixelatedButton> createState() => _PixelatedButtonState();
}

class _PixelatedButtonState extends State<PixelatedButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;
  late Animation paddingX;
  late Animation paddingY;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 275),
      vsync: this,
    );
    _animation = Tween(begin: 1.0, end: 1.1).animate(CurvedAnimation(parent: _controller, curve: Curves.ease, reverseCurve: Curves.easeIn));
    paddingY = Tween(begin: 4.0, end: 0.0).animate(CurvedAnimation(parent: _controller, curve: Curves.ease, reverseCurve: Curves.easeIn));
    paddingX = Tween(begin: 10.0, end: 0.0).animate(CurvedAnimation(parent: _controller, curve: Curves.ease, reverseCurve: Curves.easeIn));
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (value) {
        setState(() {
          _controller.forward();
        });
      },
      onExit: (value) {
        setState(() {
          _controller.reverse();
        });
      },
      child: Container(
        width: 220.0,
        height: 88.0,
        padding: EdgeInsets.symmetric(vertical: paddingY.value, horizontal: paddingX.value),
        child: ClipPath(
          clipper: PixelatedClipperSquare(),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(_animation.value * 200.0, _animation.value * 80.0),
              backgroundColor: Color(0xFF507335),
            ),
            onPressed: widget.onClick,
            child: Text(
              widget.title,
              textScaleFactor: _animation.value,
              style: Theme.of(context).textTheme.button,
            ),
          ),
        ),
      ),
    );
  }
}
