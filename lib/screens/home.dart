import 'package:easy_do_app/model/all_task_model.dart';
import 'package:easy_do_app/screens/details_task.dart';
import 'package:easy_do_app/screens/new_task.dart';
import 'package:easy_do_app/services/task_services.dart';
import 'package:easy_do_app/utils/colors.dart';
import 'package:easy_do_app/widgets/custom_action_button.dart';
import 'package:easy_do_app/widgets/home_appbar.dart';
import 'package:easy_do_app/widgets/task_for_day.dart';
import 'package:easy_do_app/widgets/task_summary.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  String formatDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    String formattedDate =
        DateFormat('dd MMM yyyy').format(dateTime).toUpperCase();
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      appBar: HomeAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: FutureBuilder<List<AllTaskDataModel>>(
          future: TaskServices().getAllTasks(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Loading state
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              // Error state
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              // Success state
              List<AllTaskDataModel> tasks = snapshot.data!;
              return Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * .03),
                  Expanded(
                    flex: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Task Summary",
                          style: GoogleFonts.manrope(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * .01),
                        TaskSummary(),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .04),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Task for the Day",
                          style: GoogleFonts.manrope(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * .01),
                        Expanded(
                          child: ListView.separated(
                            itemBuilder: (context, index) {
                              String originalDate =
                                  tasks[index].dueDate.toString();
                              String formattedDate = formatDate(originalDate);

                              return GestureDetector(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailsTask(
                                      title: tasks[index].title.toString(),
                                      description:
                                          tasks[index].description.toString(),
                                      date: formattedDate,
                                      isCompleted: tasks[index].completed!,
                                    ),
                                  ),
                                ),
                                child: TaskForDay(
                                  title: tasks[index].title.toString(),
                                  date: formattedDate,
                                  details: tasks[index].description.toString(),
                                  isChecked: tasks[index].completed!,
                                ),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 15),
                            itemCount: tasks.length,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
      floatingActionButton: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NewTask()),
        ),
        child: CustomActionButton(),
      ),
    );
  }
}
