import 'package:demofire/screen/authenticate/pre_auth.dart';
import 'package:demofire/screen/authenticate/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.fromLTRB(30, 100, 30, 30),
      color: Colors.amber[100],
      child: Padding(
        padding: const EdgeInsets.only(top: 200),
        child: Column(
          children: [
            Align(
              alignment: FractionalOffset.bottomCenter,
              child: Container(
                height: 450,
                width: 300,
                decoration: const BoxDecoration(
                  // border: Border.all(color: Colors.red),
                  // borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                      image: AssetImage("assets/mini_wel.png"), fit: BoxFit.fill),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 140),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.amber,
                    fixedSize: Size(270, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    side: const BorderSide(
                      color: Colors.white,
                      width: 2,
                    )),
                onPressed: () {
                  setState(() {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const Preauth()),
                    );
                  });
                },
                child: const Text(
                  'Let Start',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
