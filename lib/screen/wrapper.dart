import 'package:demofire/models/user.dart';
import 'package:demofire/screen/authenticate/pre_auth.dart';
import 'package:demofire/screen/home/welcome.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  int count = 0;

  @override
  void initState() {
    super.initState();
    getCount();
  }

  // void setCount() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   // await Future.delayed(Duration(milliseconds: 500));
  //   setState(() {
  //     count = prefs.getInt('count') ?? 0;
  //     count++;
  //     prefs.setInt('count', count);
  //   });
  // }

  void getCount() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      count = prefs.getInt('count') ?? 0;
    });
    print(count);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserID?>(context);

    bool? id = user?.puid;
    // print('preauth: $user');
    // String? name = "praveen";
    if (count == 0 && user==null) {
      return Welcome();
    } else {
      return Preauth();
    }
    // return Preauth();
  }
}
