import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DetailsTask extends StatelessWidget {
  DetailsTask(
      {super.key,
      this.title,
      required this.date,
      required this.isCompleted,
      required this.description});
  String? title;
  String? date;
  bool isCompleted;
  String description;

  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    descriptionController.text = description;
    return Scaffold(
      appBar: AppBar(
          title: ListTile(
        title: Text(title!),
        subtitle: Row(children: [
          Icon(Icons.watch_later_outlined, size: 18),
          SizedBox(width: 5),
          Text(date.toString()),
          SizedBox(width: 5),
          isCompleted
              ? SvgPicture.asset("assets/task_complete.svg")
              : SvgPicture.asset("assets/task_incomplete.svg")
        ]),
        trailing: isCompleted
            ? SvgPicture.asset("assets/checked.svg")
            : SvgPicture.asset("assets/unchecked.svg"),
      )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: descriptionController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelStyle: TextStyle(
                  fontSize: 14,
                  color: Color(0xffE9E9E9),
                ),
                alignLabelWithHint: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black, width: 0.6),
                  borderRadius: BorderRadius.circular(14.0),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14.0),
                ),
              ),
            ),
            SizedBox(height: 16),
            SvgPicture.asset("assets/delete_task.svg"),
          ],
        ),
      ),
    );
  }
}
