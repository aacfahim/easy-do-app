import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskForDay extends StatelessWidget {
  const TaskForDay({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.only(top: 10),
            height: 100,
            width: double.maxFinite,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Column(children: [
              Text(
                "Mentorship Session",
                style: GoogleFonts.manrope(),
              )
            ]),
          );
        },
        separatorBuilder: (context, index) => SizedBox(height: 5),
        itemCount: 100);
  }
}
