import 'package:easy_do_app/model/all_task_model.dart';
import 'package:easy_do_app/screens/task/details_task.dart';
import 'package:easy_do_app/screens/task/new_task.dart';
import 'package:easy_do_app/services/task_notifier.dart';
import 'package:easy_do_app/services/task_services.dart';
import 'package:easy_do_app/utils/colors.dart';
import 'package:easy_do_app/widgets/custom_action_button.dart';

import 'package:easy_do_app/widgets/task_for_day.dart';

import 'package:flutter/material.dart';
import 'package:flutter_calendar_week/flutter_calendar_week.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Tasks extends StatefulWidget {
  const Tasks({super.key});

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  String? pickedDate;

  List<AllTaskDataModel> tasks = [];

  String formatDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    String formattedDate =
        DateFormat('dd MMM yyyy').format(dateTime).toUpperCase();
    return formattedDate;
  }

  void currentDate() {
    var now = DateTime.now();
    var formatter = DateFormat('dd MMM yyyy');
    pickedDate = formatter.format(now).toUpperCase();
  }

  @override
  void initState() {
    fetchTasks();
    currentDate();

    super.initState();
  }

  Future fetchTasks() async {
    try {
      List<AllTaskDataModel> fetchedTasks = await TaskServices().getAllTasks();
      if (mounted) {
        setState(() {
          tasks = fetchedTasks;
        });
      }
    } catch (error) {
      print('Error fetching tasks: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskNotifier>(
      builder: (context, taskNotifier, child) {
        return Scaffold(
          backgroundColor: BACKGROUND_COLOR,
          appBar: AppBar(
            title: Text(
              "Tasks",
              style: GoogleFonts.manrope(
                textStyle: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              setState(() {});
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: FutureBuilder<List<AllTaskDataModel>>(
                future: TaskServices().getAllTasks(),
                builder: (context, snapshot) {
                  if (taskNotifier.shouldReload) {
                    TaskServices().getAllTasks();
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Loading state
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    // Error state
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    // Success state
                    List<AllTaskDataModel> tasks = snapshot.data!;

                    List<AllTaskDataModel> filteredTasks = tasks
                        .where((task) =>
                            pickedDate == null ||
                            DateFormat('dd MMM yyyy')
                                    .format(DateTime.parse(task.dueDate!))
                                    .toUpperCase() ==
                                pickedDate)
                        .toList();
                    return Column(
                      children: [
                        Expanded(
                          flex: 0,
                          child: calendar(context),
                        ),
                        // SizedBox(
                        //     height: MediaQuery.of(context).size.height * .04),
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .01),
                              Expanded(
                                child: ListView.separated(
                                  itemBuilder: (context, index) {
                                    String originalDate =
                                        filteredTasks[index].dueDate.toString();
                                    String formattedDate =
                                        formatDate(originalDate);

                                    if (formattedDate == pickedDate) {
                                      return GestureDetector(
                                        onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => DetailsTask(
                                              id: filteredTasks[index]
                                                  .sId
                                                  .toString(),
                                              title: filteredTasks[index]
                                                  .title
                                                  .toString(),
                                              description: filteredTasks[index]
                                                  .description
                                                  .toString(),
                                              date: formattedDate,
                                              isCompleted: filteredTasks[index]
                                                  .completed!,
                                            ),
                                          ),
                                        ),
                                        child: TaskForDay(
                                          title: filteredTasks[index]
                                              .title
                                              .toString(),
                                          date: formattedDate,
                                          details: filteredTasks[index]
                                              .description
                                              .toString(),
                                          isCompleted:
                                              filteredTasks[index].completed!,
                                        ),
                                      );
                                    } else {
                                      return SizedBox.shrink();
                                    }
                                  },
                                  separatorBuilder: (context, index) =>
                                      SizedBox(height: 15),
                                  itemCount: filteredTasks.length,
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
          ),
          floatingActionButton: InkWell(
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NewTask()),
              );
            },
            child: CustomActionButton(),
          ),
        );
      },
    );
  }

  CalendarWeek calendar(BuildContext context) {
    return CalendarWeek(
      controller: CalendarWeekController(),
      height: MediaQuery.of(context).size.height * .16,
      showMonth: true,
      backgroundColor: BACKGROUND_COLOR,
      minDate: DateTime.now().add(
        Duration(days: -365),
      ),
      maxDate: DateTime.now().add(
        Duration(days: 365),
      ),
      onDatePressed: (DateTime datetime) {
        pickedDate = DateFormat('dd MMM yyyy').format(datetime).toUpperCase();
        setState(() {});
      },
      monthViewBuilder: (DateTime time) => Align(
        alignment: FractionalOffset.topLeft,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: Text(
            DateFormat.yMMMM().format(time),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: GoogleFonts.manrope(
              textStyle: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      todayBackgroundColor: Colors.blue,
      todayDateStyle: TextStyle(
        color: Colors.white,
      ),
      dateStyle: TextStyle(
        color: Theme.of(context).primaryColor,
      ),
      dayOfWeekStyle: TextStyle(
        color: Theme.of(context).primaryColor,
      ),
      weekendsStyle: TextStyle(
        color: Theme.of(context).primaryColor,
      ),
      decorations: [
        DecorationItem(
          decorationAlignment: FractionalOffset.bottomRight,
          date: DateTime.now(),
        ),
      ],
    );
  }
}
