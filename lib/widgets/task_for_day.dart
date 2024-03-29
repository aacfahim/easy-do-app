import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskForDay extends StatelessWidget {
  TaskForDay({
    super.key,
    required this.date,
    required this.details,
    this.isCompleted = false,
    required this.title,
  });
  String title;
  String date;
  String details;

  bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      height: MediaQuery.of(context).size.height * .18,
      width: double.maxFinite,
      decoration: BoxDecoration(
          border: Border.all(
              color: isCompleted ? Colors.green : Colors.transparent),
          color: Colors.white,
          borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        ListTile(
            title: Text(
              title,
              style: GoogleFonts.manrope(fontWeight: FontWeight.bold),
            ),
            subtitle: Row(children: [
              Icon(Icons.watch_later_outlined, size: 18),
              SizedBox(width: 5),
              Text(date),
              SizedBox(width: 5),
              isCompleted
                  ? SvgPicture.asset("assets/task_complete.svg")
                  : SvgPicture.asset("assets/task_incomplete.svg")
            ]),
            trailing: isCompleted
                ? SvgPicture.asset("assets/checked.svg")
                : SvgPicture.asset("assets/unchecked.svg")),
        Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
          ),
          child: Text(
            details,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ]),
    );
  }
}
