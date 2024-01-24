import 'package:easy_do_app/screens/auth/sign_in.dart';
import 'package:easy_do_app/screens/auth/sign_up.dart';
import 'package:easy_do_app/widgets/appbar.dart';
import 'package:easy_do_app/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/colors.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      body: ListView(children: [
        Stack(
          children: [
            CustomAppBar(),
            InkWell(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => SignIn()));
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0, left: 12.0),
                child: CircleAvatar(
                  backgroundColor: Color(0xffDEEAFC),
                  maxRadius: 25,
                  minRadius: 10,
                  child: Icon(Icons.arrow_back_ios, size: 20),
                ),
              ),
            )
          ],
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Sign up",
                  style: GoogleFonts.manrope(
                    textStyle: TextStyle(
                        color: TEXT_ACCENT_COLOR,
                        fontSize: 32,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: height * .04),
              Text(
                "Name",
              ),
              SizedBox(height: height * .01),
              customTextField(nameController,
                  label: "Type name here...", validator: "Please enter name"),
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
                "Password",
              ),
              SizedBox(height: height * .01),
              customTextField(passwordController,
                  isObscure: true,
                  label: "Type password here...",
                  validator: "Please enter password"),
              SizedBox(height: height * .04),
              Text(
                "Retype Password",
              ),
              SizedBox(height: height * .01),
              customTextField(confirmPasswordController,
                  isObscure: true,
                  label: "Type password here...",
                  validator: "Please retype password"),
              SizedBox(height: height * .04),
              PrimaryButton(name: "Sign up"),
            ],
          ),
        ),
      ]),
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
