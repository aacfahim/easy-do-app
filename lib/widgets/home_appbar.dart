import 'package:easy_do_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: BACKGROUND_COLOR,
        elevation: 0,
        title: ListTile(
          title: Text(
            "Hello!",
            style: GoogleFonts.manrope(
                textStyle:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
          ),
          subtitle: Text("What's your plan for today?"),
        ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
