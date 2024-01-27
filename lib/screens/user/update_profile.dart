import 'package:easy_do_app/screens/user/profile.dart';
import 'package:easy_do_app/services/auth_services.dart';
import 'package:easy_do_app/services/user_services.dart';
import 'package:easy_do_app/utils/colors.dart';
import 'package:easy_do_app/utils/common.dart';
import 'package:easy_do_app/widgets/custom_navbar.dart';
import 'package:easy_do_app/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class UpdateProfile extends StatelessWidget {
  UpdateProfile({super.key, required this.name, required this.email});
  String name;
  String email;
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    nameController.text = name;

    emailController.text = email;

    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      appBar: AppBar(title: Text("Profile")),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        width: double.maxFinite,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/profile_background.png"))),
        child: Column(children: [
          CircleAvatar(
            backgroundImage: AssetImage("assets/default_dp.jpg"),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Name",
                    ),
                    SizedBox(height: height * .01),
                    customTextField(nameController,
                        label: "Type name here...",
                        validator: "Please enter name"),
                    SizedBox(height: height * .04),
                    Text(
                      "Email",
                    ),
                    SizedBox(height: height * .01),
                    customTextField(emailController,
                        textInputType: TextInputType.emailAddress,
                        label: "Type email here...",
                        validator: "Please enter email"),
                    SizedBox(height: height * .04),
                    Text(
                      "Age",
                    ),
                    SizedBox(height: height * .01),
                    customTextField(ageController,
                        textInputType: TextInputType.emailAddress,
                        label: "Type age here...",
                        validator: "Please enter your age"),
                    SizedBox(height: height * .04),
                    Consumer<AuthProvider>(
                      builder: (context, authProvider, child) {
                        return InkWell(
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              authProvider.setLoading(true);

                              final result = await UserServices().updateUser(
                                  nameController.text,
                                  emailController.text,
                                  int.parse(ageController.text));

                              authProvider.setLoading(false);

                              if (result['success']) {
                                showSnackbar(context, "Profile Updated");

                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        CustomBottomNavigationBar(),
                                  ),
                                );
                              } else {
                                showSnackbar(context, result['error']);
                              }
                            }
                          },
                          child: authProvider.isLoading
                              ? Center(child: CircularProgressIndicator())
                              : PrimaryButton(name: "Update"),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }

  TextFormField customTextField(TextEditingController textEditingController,
      {String label = "",
      String validator = "",
      bool isObscure = false,
      TextInputType textInputType = TextInputType.text}) {
    return TextFormField(
      keyboardType: textInputType,
      controller: textEditingController,
      obscureText: isObscure,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        labelText: label,
        labelStyle: TextStyle(
          fontSize: 14,
          color: Color(0xffE9E9E9),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xffE9E9E9), width: 1.0),
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
          return validator;
        }

        return null;
      },
    );
  }
}
