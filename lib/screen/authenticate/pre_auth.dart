import 'package:demofire/models/user.dart';
import 'package:demofire/screen/authenticate/authenticate.dart';
import 'package:demofire/screen/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Preauth extends StatelessWidget {
  const Preauth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserID?>(context);
    bool? id = user?.puid;
    print('preauth: $user');
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
