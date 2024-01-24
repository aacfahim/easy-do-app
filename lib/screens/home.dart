import 'package:easy_do_app/utils/colors.dart';
import 'package:easy_do_app/widgets/home_appbar.dart';
import 'package:easy_do_app/widgets/task_for_day.dart';
import 'package:easy_do_app/widgets/task_summary.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      appBar: HomeAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          children: [
            SizedBox(height: height * .03),
            Expanded(
              flex: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Task Summary",
                    style: GoogleFonts.manrope(
                      textStyle:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  SizedBox(height: height * .01),
                  TaskSummary(),
                ],
              ),
            ),
            SizedBox(height: height * .04),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Task for the Day",
                    style: GoogleFonts.manrope(
                      textStyle:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  SizedBox(height: height * .01),
                  Expanded(child: TaskForDay()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
