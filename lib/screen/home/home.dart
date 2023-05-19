import 'dart:io';

import 'package:demofire/models/user.dart';
import 'package:demofire/screen/authenticate/pre_auth.dart';
import 'package:demofire/screen/home/dashboard.dart';
import 'package:demofire/screen/home/profile.dart';
import 'package:demofire/services/auth.dart';
import 'package:demofire/services/database.dart';
import 'package:demofire/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int count = 0;
  var appbar = 'Dashboard';
  bool profile = false;
  bool dashboard = true;
  bool loading = false;
  bool profilecon = false;
  final Authservices auth = Authservices();
  final db = DatabaseService();
  final id = Authservices().getCurrentUser()!.uid;
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : StreamBuilder<Map<String, dynamic>>(
            stream: db.getUserData(id),
            builder: (context, snapshot) {
              final data = snapshot.data;
              if (data != null) {
                return Scaffold(
                  backgroundColor: Colors.amber[100],
                  appBar: AppBar(
                    title: Text(appbar),
                    actions: const [],
                    elevation: 0.0,
                  ),
                  drawer: Drawer(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    backgroundColor: Colors.amber[100],
                    child: Column(
                      children: [
                        UserAccountsDrawerHeader(
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(30)),
                              color: Colors.amber),
                          currentAccountPicture: CircleAvatar(
                            backgroundColor: Colors.amber[50],
                            child: ClipOval(
                                  child: Container(
                                    height: 150,
                                    width: 150,
                                    decoration: BoxDecoration(),
                                    child: Image.file(
                                      File(data['imagepath']),
                                      height: 200,
                                    ),
                                  ),
                                ),
                          ),
                          accountName: Text(data['firstName']),
                          accountEmail: Text(data['email']),
                        ),
                        Expanded(
                          child: ListView(
                            padding: EdgeInsets.zero,
                            children: [
                              ListTile(
                                leading: const Icon(Icons.home),
                                title: const Text(
                                  "Home",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                  // Navigator.pushNamed(context, "/profile");
                                  setState(() {
                                    profile = false;
                                    dashboard = true;
                                    profilecon = false;
                                    appbar = 'Dashboard';
                                  });
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.account_circle),
                                title: const Text(
                                  "My Profile",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                  // Navigator.pushNamed(context, "/profile");
                                  setState(() {
                                    dashboard = false;
                                    profile = true;
                                    profilecon = true;
                                    appbar = 'My Profile';
                                  });
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.settings),
                                title: const Text(
                                  "Settings",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                onTap: () {
                                  // Add your onTap logic here
                                },
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 30),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                fixedSize: Size(250, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                )),
                            onPressed: () async {
                              await auth.Signout();
                              final SharedPreferences pref =
                                  await SharedPreferences.getInstance();
                              pref.setInt('count', 0);
                              setState(() {
                                count = 0;
                              });
                            },
                            child: Text("Log Out"),
                          ),
                        ),
                      ],
                    ),
                  ),
                  body: Column(
                    children: [
                      Visibility(
                        visible: dashboard,
                        child: dashboards.value,
                      ),
                      Visibility(
                        visible: profile,
                        child: profiles.value,
                      ),
                      Visibility(
                        visible: profilecon,
                        child: Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30))
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }
              return Container();
            });
  }
}
