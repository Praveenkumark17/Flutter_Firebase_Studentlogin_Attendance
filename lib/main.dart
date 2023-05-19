import 'package:demofire/models/user.dart';
import 'package:demofire/screen/home/home.dart';
import 'package:demofire/screen/home/profile.dart';
import 'package:demofire/screen/wrapper.dart';
import 'package:demofire/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:demofire/shared/loading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
    print('Firebase connected');
  } catch (e) {
    print('Firebase connection failed: $e');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserID?>.value(
      value: Authservices().user,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.amber,
        ),
        routes: {
        // '/profile': (context) => Profile(),
        },
        home: Wrapper(),
      ),
    );
  }
}