import 'package:flutter/material.dart';
import 'package:portfolio/src/widgets/pixelated_clipper_square.dart';

class PixelatedButton extends StatefulWidget {
  final String title;
  final Function()? onClick;
  final double width;
  final double height;
  final double shadow;
  final TextStyle? style;
  const PixelatedButton({
    super.key,
    this.title = '',
    this.onClick,
    this.width = 200,
    this.height = 80,
    this.shadow = 1,
    this.style,
  });

  @override
  State<PixelatedButton> createState() => _PixelatedButtonState();
}

class _PixelatedButtonState extends State<PixelatedButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 275),
      vsync: this,
    );
    _animation = Tween(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.ease,
        reverseCurve: Curves.easeIn,
      ),
    );
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
      child: ScaleTransition(
        scale: _animation,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            ClipPath(
              clipper: PixelatedClipperSquare(
                bottomRight: true,
                topLeft: true,
                bottomLeft: true,
                topRight: true,
              ),
              child: Container(
                color: Colors.black,
                width: widget.width + widget.shadow,
                height: widget.height + widget.shadow,
              ),
            ),
            ClipPath(
              clipper: PixelatedClipperSquare(
                bottomRight: true,
                topLeft: true,
                bottomLeft: true,
                topRight: true,
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(widget.width, widget.height),
                  backgroundColor: Color(0xFF507335),
                ),
                onPressed: widget.onClick,
                child: Text(
                  widget.title,
                  style: widget.style ?? Theme.of(context).textTheme.labelLarge,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
