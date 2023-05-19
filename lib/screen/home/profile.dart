import 'dart:io';

import 'package:demofire/screen/home/profile_update.dart';
import 'package:demofire/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:demofire/services/database.dart';

final db = DatabaseService();
final id = Authservices().getCurrentUser()!.uid;

final profiles = ValueNotifier<Profile>(const Profile());

class Profile extends StatelessWidget {
  const Profile({super.key});
  // void showsettingpanel(BuildContext context) {
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (context) {
  //         return Container(
  //           color: Colors.amber[100],
  //           padding:
  //               const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
  //           child: Profileupdate(),
  //         );
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Profile>(
      valueListenable: profiles,
      builder: (context, value, child) {
        return StreamBuilder<Map<String, dynamic>>(
            stream: db.getUserData(id),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              }
              final data = snapshot.data!;
              String fname = data['firstName'];
              String lname = data['lastName'];
              String email = data['email'];
              String gender = data['gender'];
              String mobile = data['mobile_no'];
              String registerno = data['register_no'];
              String dob = data['dob'];
              return SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Align(
                      alignment: FractionalOffset.center,
                      child: CircleAvatar(
                        backgroundImage: const AssetImage('assets/profile.png'),
                        backgroundColor: Colors.amber[200],
                        radius: 45,
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
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      fname.toUpperCase() + ' ' + lname.toUpperCase(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 590,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30))),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          Expanded(
                            child: Container(
                              height: 400,
                              child: Align(
                                alignment: FractionalOffset.center,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 35, top: 20, right: 35),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Register No:'.toUpperCase(),
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 51, 115, 225)),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        registerno,
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 214, 30, 30)),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      const Divider(
                                        color: Colors.blue,
                                        thickness: 1,
                                        height: 1,
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        'Gender:'.toUpperCase(),
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 51, 115, 225)),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        gender,
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 214, 30, 30)),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      const Divider(
                                        color: Colors.blue,
                                        thickness: 1,
                                        height: 1,
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        'Email:'.toUpperCase(),
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 51, 115, 225)),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        email,
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 214, 30, 30)),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      const Divider(
                                        color: Colors.blue,
                                        thickness: 1,
                                        height: 1,
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        'Mobile no:'.toUpperCase(),
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 51, 115, 225)),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        mobile,
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 214, 30, 30)),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      const Divider(
                                        color: Colors.blue,
                                        thickness: 1,
                                        height: 1,
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        'Date of Birth:'.toUpperCase(),
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 51, 115, 225)),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        dob,
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 214, 30, 30)),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      const Divider(
                                        color: Colors.blue,
                                        thickness: 1,
                                        height: 1,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 30),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  fixedSize: const Size(250, 50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  )),
                              onPressed: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Profileupdate()),
                                );
                              },
                              child: const Text(
                                'Edit Profile',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 255, 255, 255)),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            });
      },
    );
  }
}
