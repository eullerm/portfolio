import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 25.0,
          ),
        ],
      ),
      child: Container(
        color: Colors.red,
      ),
    );
  }
}
