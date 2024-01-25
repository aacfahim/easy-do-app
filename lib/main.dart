import 'package:easy_do_app/screens/auth/sign_in.dart';
import 'package:easy_do_app/screens/home.dart';
import 'package:easy_do_app/screens/splash_screen.dart';
import 'package:easy_do_app/services/auth_services.dart';
import 'package:easy_do_app/widgets/custom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          primaryColor: const Color(0xFF8C88CD),
          textTheme: GoogleFonts.manropeTextTheme(),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: SignIn(),
      ),
    );
  }
}
