import 'package:easy_do_app/services/task_notifier.dart';
import 'package:easy_do_app/services/task_services.dart';
import 'package:easy_do_app/utils/common.dart';
import 'package:easy_do_app/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewTask extends StatelessWidget {
  NewTask({super.key});
  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now()) {
      dateController.text = "${picked.year}/${picked.month}/${picked.day}";
    }
  }

  clearFields() {
    titleController.clear();
    dateController.clear();
    descriptionController.clear();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("New Task"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "Title",
              ),
              SizedBox(height: height * .01),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: titleController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: "Type here...",
                  labelStyle: TextStyle(
                    fontSize: 14,
                    color: Color(0xffE9E9E9),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Color(0xffE9E9E9), width: 1.0),
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                ),
                onChanged: (String value) {
                  // name = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter title';
                  }
                  return null;
                },
              ),
              SizedBox(height: height * .04),
              Text(
                "Date",
              ),
              SizedBox(height: height * .01),
              TextFormField(
                controller: dateController,
                readOnly: true,
                onTap: () => selectDate(context),
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.calendar_today, color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  labelText: "yyyy/mm/dd",
                  labelStyle: TextStyle(
                    fontSize: 14,
                    color: Color(0xffE9E9E9),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Color(0xffE9E9E9), width: 1.0),
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Pick a date';
                  }
                  return null;
                },
              ),
              SizedBox(height: height * .04),
              Text(
                "Description",
              ),
              SizedBox(height: height * .01),
              TextField(
                controller: descriptionController,
                textAlignVertical: TextAlignVertical.top,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: "Type here...",
                  labelStyle: TextStyle(
                    fontSize: 14,
                    color: Color(0xffE9E9E9),
                  ),
                  alignLabelWithHint: true,
                  contentPadding: EdgeInsets.symmetric(vertical: height * .05),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Color(0xffE9E9E9), width: 1.0),
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                ),
              ),
              SizedBox(height: height * .23),
              InkWell(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      final result = await TaskServices().addTask(
                          titleController.text,
                          dateController.text,
                          descriptionController.text);

                      if (result) {
                        showSnackbar(context, "Task Added");
                        clearFields();
                        Provider.of<TaskNotifier>(context, listen: false)
                            .setShouldReload(true);
                      } else {
                        showSnackbar(
                            context, "Something went wrong, please try again");
                      }
                    }
                  },
                  child: PrimaryButton(name: "Create Task")),
            ]),
          ),
        ),
      ),
    );
  }
}
