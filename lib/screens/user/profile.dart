import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Profile")),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        color: Theme.of(context).primaryColor, width: 1.5),
                    borderRadius: BorderRadius.circular(8)),
                child: ListTile(
                  leading: CircleAvatar(),
                  title: Text("John Doe"),
                  subtitle: Text("johndoe@gmail.com"),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
              ),
              SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: ListTile(
                  leading: Icon(Icons.power_settings_new_outlined,
                      color: Colors.red),
                  title: Text("Log Out"),
                ),
              ),
              SizedBox(height: 15),
              Text(
                "Version: 1.0.0",
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ));
  }
}
