import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrimaryButton extends StatelessWidget {
  PrimaryButton({super.key, required this.name});
  String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      width: double.maxFinite,
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(14.0)),
      child: Center(
        child: Text(
          name,
          style: GoogleFonts.manrope(
            textStyle: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
