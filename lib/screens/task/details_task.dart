import 'package:easy_do_app/services/task_notifier.dart';
import 'package:easy_do_app/services/task_services.dart';
import 'package:easy_do_app/utils/common.dart';
import 'package:easy_do_app/widgets/custom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class DetailsTask extends StatefulWidget {
  DetailsTask(
      {super.key,
      this.title,
      required this.id,
      required this.date,
      required this.isCompleted,
      required this.description});
  String? title;
  String id;
  String? date;
  bool isCompleted;
  String description;

  @override
  State<DetailsTask> createState() => _DetailsTaskState();
}

class _DetailsTaskState extends State<DetailsTask> {
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    descriptionController.text = widget.description;
    return Consumer<TaskNotifier>(builder: (context, taskNotifier, child) {
      return Scaffold(
        appBar: AppBar(
          // leading: InkWell(
          //     onTap: () {
          //       Navigator.pushReplacement(
          //           context,
          //           MaterialPageRoute(
          //               builder: (context) => CustomBottomNavigationBar()));
          //     },
          //     child: Icon(Icons.arrow_back)),
          title: ListTile(
            title: Text(widget.title!),
            subtitle: Row(children: [
              Icon(Icons.watch_later_outlined, size: 18),
              SizedBox(width: 5),
              Text(widget.date.toString()),
              SizedBox(width: 5),
              GestureDetector(
                onTap: () async {
                  widget.isCompleted = !widget.isCompleted;
                  setState(() {});
                  await TaskServices().updateTask(
                      widget.id, widget.isCompleted, widget.description);
                  taskNotifier.setShouldReload(true);
                },
                child: widget.isCompleted
                    ? SvgPicture.asset("assets/task_complete.svg")
                    : SvgPicture.asset("assets/task_incomplete.svg"),
              ),
            ]),
            trailing: GestureDetector(
              onTap: () async {
                widget.isCompleted = !widget.isCompleted;
                setState(() {});
                await TaskServices().updateTask(
                    widget.id, widget.isCompleted, widget.description);
                taskNotifier.setShouldReload(true);
              },
              child: widget.isCompleted
                  ? SvgPicture.asset("assets/checked.svg")
                  : SvgPicture.asset("assets/unchecked.svg"),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: descriptionController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                onChanged: (value) async {
                  await TaskServices()
                      .updateTask(widget.id, widget.isCompleted, value);
                  taskNotifier.setShouldReload(true);
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelStyle: TextStyle(
                    fontSize: 14,
                    color: Color(0xffE9E9E9),
                  ),
                  alignLabelWithHint: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.black, width: 0.6),
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                ),
              ),
              SizedBox(height: 16),
              InkWell(
                onTap: () async {
                  bool deleteConfirmed = await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Confirm Deletion"),
                        content:
                            Text("Are you sure you want to delete this task?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            child: Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("Delete"),
                          ),
                        ],
                      );
                    },
                  );

                  if (deleteConfirmed == true) {
                    bool result = await TaskServices().deleteTask(widget.id);

                    if (result) {
                      showSnackbar(context, "Task Deleted");
                      Navigator.pop(context);

                      taskNotifier.setShouldReload(true);
                    } else {
                      showSnackbar(
                        context,
                        "Something went wrong, please try again",
                      );
                    }
                  }
                },
                child: SvgPicture.asset("assets/delete_task.svg"),
              ),
            ],
          ),
        ),
      );
    });
  }
}
