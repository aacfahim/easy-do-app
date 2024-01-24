import 'package:easy_do_app/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class NewTask extends StatelessWidget {
  NewTask({super.key});
  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Future selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now()) {
      dateController.text = "${picked.day}/${picked.month}/${picked.year}";
    }
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
          child: Container(
            height: MediaQuery.of(context).size.height,
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
                  labelText: "dd/mm/yyyy",
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
              PrimaryButton(name: "Create Task"),
            ]),
          ),
        ),
      ),
    );
  }
}
