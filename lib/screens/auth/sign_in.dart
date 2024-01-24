import 'package:easy_do_app/screens/auth/sign_up.dart';
import 'package:easy_do_app/widgets/appbar.dart';
import 'package:easy_do_app/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/colors.dart';

class SignIn extends StatelessWidget {
  SignIn({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      body: Column(children: [
        CustomAppBar(),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Sign in",
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
                "Email",
              ),
              SizedBox(height: height * .01),
              TextFormField(
                keyboardType: TextInputType.text,
                // controller: emailController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: "Type email here...",
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
                    return 'Enter email';
                  }
                  return null;
                },
              ),
              SizedBox(height: height * .04),
              Text(
                "Password",
              ),
              SizedBox(height: height * .01),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: "Type password here...",
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
                    return 'Enter password';
                  }
                  return null;
                },
              ),
              SizedBox(height: height * .04),
              PrimaryButton(name: "Sign in"),
              SizedBox(height: height * .02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?"),
                  SizedBox(width: 5),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SignUp()));
                    },
                    child: Text(
                      "Sign Up",
                      style: GoogleFonts.manrope(
                        textStyle: TextStyle(
                            color: TEXT_ACCENT_COLOR,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),

        // button here'
      ]),
    );
  }
}
