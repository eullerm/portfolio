import 'package:flutter/material.dart';
import 'package:portfolio/src/widgets/enhanced_container.dart';
import 'package:portfolio/src/widgets/header.dart';

class Skills extends StatefulWidget {
  static const routeName = '/skills';
  final Object? arguments;
  final double page;
  final double numberOfPages;
  const Skills({super.key, this.arguments, required this.page, required this.numberOfPages});

  @override
  State<Skills> createState() => _SkillsState();
}

class _SkillsState extends State<Skills> {
  void navigateTo(String path, {Object? arguments}) {
    if (path.isNotEmpty) {
      Navigator.pushNamed(context, path, arguments: arguments);
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Header(
          page: widget.page,
          numberOfPages: widget.numberOfPages,
          leftButtonPath: '/experiences',
          rightButtonPath: '',
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(50),
        child: Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              EnhancedContainer(
                padding: EdgeInsets.all(16),
                width: 600,
                height: 600,
                content: Center(
                  child: Image.asset(
                    'assets/images/euller.jpg',
                    height: 550,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
