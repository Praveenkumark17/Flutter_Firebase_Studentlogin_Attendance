import 'package:demofire/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:demofire/services/database.dart';

final db = DatabaseService();
final id = Authservices().getCurrentUser()!.uid;

final dashboards = ValueNotifier<Dashboard>(const Dashboard());

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Dashboard>(
      valueListenable: dashboards,
      builder: (context, value, child) {
        return StreamBuilder<Map<String, dynamic>>(
            stream: db.getUserData(id),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }
              final data = snapshot.data!;
              String fname = data['firstName'];
              String lname = data['lastName'];
              return Container(
                padding: EdgeInsets.all(30),
                child: Column(
                  children: [
                    Align(
                      alignment: FractionalOffset.topLeft,
                      child:  Text(
                        'Welcome!'.toUpperCase() +
                            ' ' +
                            fname.toUpperCase() +
                            ' ' +
                            lname.toUpperCase(),
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold,color: Color.fromARGB(255, 222, 14, 14)),
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
