import 'package:flutter/material.dart';

class BoxButton extends StatefulWidget {
  final Widget? child;
  final Function()? onClick;

  const BoxButton({super.key, this.child, this.onClick});

  @override
  State<BoxButton> createState() => _BoxButtonState();
}

class _BoxButtonState extends State<BoxButton> with SingleTickerProviderStateMixin {
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
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onClick,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
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
          child: widget.child,
        ),
      ),
    );
  }
}
