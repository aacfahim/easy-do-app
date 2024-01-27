import 'package:easy_do_app/screens/auth/sign_in.dart';
import 'package:easy_do_app/services/auth_services.dart';
import 'package:easy_do_app/services/task_notifier.dart';
import 'package:easy_do_app/services/task_services.dart';
import 'package:easy_do_app/widgets/custom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AuthProvider authProvider = AuthProvider();
  await authProvider.init();

  runApp(MyApp(authProvider: authProvider));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.authProvider});
  final AuthProvider authProvider;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(create: (_) => TaskServices()),
        ChangeNotifierProvider(create: (_) => TaskNotifier()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          primaryColor: const Color(0xFF8C88CD),
          textTheme: GoogleFonts.manropeTextTheme(),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: authProvider.authToken != null
            ? CustomBottomNavigationBar()
            : SignIn(),
      ),
    );
  }
}
