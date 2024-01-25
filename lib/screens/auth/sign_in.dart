import 'package:easy_do_app/screens/auth/sign_up.dart';
import 'package:easy_do_app/services/auth_services.dart';
import 'package:easy_do_app/widgets/appbar.dart';
import 'package:easy_do_app/widgets/custom_navbar.dart';
import 'package:easy_do_app/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../utils/colors.dart';

class SignIn extends StatelessWidget {
  SignIn({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(height: MediaQuery.of(context).viewInsets.top),
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
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "Type email here...",
                      labelStyle: TextStyle(
                        fontSize: 14,
                        color: Color(0xffE9E9E9),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color(0xffE9E9E9), width: 1.0),
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
                        borderSide: const BorderSide(
                            color: Color(0xffE9E9E9), width: 1.0),
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
                  Consumer<AuthProvider>(
                    builder: (context, authProvider, child) {
                      return InkWell(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            authProvider.setLoading(true);

                            final result = await authProvider.signIn(
                              emailController.text,
                              passwordController.text,
                            );

                            authProvider.setLoading(false);

                            if (result['success']) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CustomBottomNavigationBar(),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(result['error']),
                                ),
                              );
                            }
                          }
                        },

                        // child: PrimaryButton(name: "Sign in"),
                        child: authProvider.isLoading
                            ? Center(child: CircularProgressIndicator())
                            : PrimaryButton(name: "Sign in"),
                      );
                    },
                  ),
                  SizedBox(height: height * .02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?"),
                      SizedBox(width: 5),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUp()));
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
          ]),
        ),
      ),
    );
  }
}
