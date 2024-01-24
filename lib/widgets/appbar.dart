import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Image.asset(
        "assets/appbar_bg.png",
        fit: BoxFit.cover,
        width: double.maxFinite,
      ),
      Positioned(
        left: 0,
        top: 0,
        right: 0,
        bottom: 0,
        child: Center(
          child: Image.asset(
            "assets/logo.png",
            fit: BoxFit.cover,
            height: 100,
            width: 100,
          ),
        ),
      ),
    ]);
  }
}
