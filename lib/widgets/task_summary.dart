import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskSummary extends StatelessWidget {
  const TaskSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Stack(
          children: [
            Image.asset("assets/incomplete.png"),
            Positioned(
              top: 30,
              left: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Incomplete"),
                  Text(
                    "12",
                    style: GoogleFonts.manrope(
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        // SizedBox(width: width * .089),
        Stack(
          children: [
            Image.asset("assets/complete.png"),
            Positioned(
              top: 30,
              left: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Completed"),
                  Text(
                    "52",
                    style: GoogleFonts.manrope(
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
