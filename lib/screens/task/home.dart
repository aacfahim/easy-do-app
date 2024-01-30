import 'package:easy_do_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  HomeAppBar({super.key});

  @override
  _HomeAppBarState createState() => _HomeAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _HomeAppBarState extends State<HomeAppBar> {
  bool isSearchExpanded = false;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: BACKGROUND_COLOR,
      elevation: 0,
      title: isSearchExpanded
          ? TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                border: InputBorder.none,
              ),
              autofocus: true,
              textInputAction: TextInputAction.search,
              onSubmitted: (value) {
                print('Searching for: $value');
              },
            )
          : ListTile(
              title: Text(
                "Hello!",
                style: GoogleFonts.manrope(
                  textStyle:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ),
              subtitle: Text("What's your plan for today?"),
            ),
      actions: [
        IconButton(
          icon: Icon(isSearchExpanded ? Icons.close : Icons.search),
          onPressed: () {
            setState(() {
              isSearchExpanded = !isSearchExpanded;
            });
          },
        ),
      ],
    );
  }
}
