import 'package:demofire/screen/authenticate/signin.dart';
import 'package:demofire/screen/authenticate/signup.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showsign = true;
  void toggleview() {
    setState(() {
      showsign = !showsign;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showsign) {
      return Signin(toggleview: toggleview);
    } else {
      return Signup(toggleview: toggleview);
    }
  }
}
