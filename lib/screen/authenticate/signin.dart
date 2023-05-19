import 'package:demofire/models/user.dart';
import 'package:demofire/screen/authenticate/signup.dart';
import 'package:demofire/services/auth.dart';
import 'package:demofire/shared/loading.dart';
import 'package:demofire/shared/textform.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Signin extends StatefulWidget {
  final Function toggleview;
  Signin({required this.toggleview});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final formkey = GlobalKey<FormState>();

  bool loading = false;
  int? name;
  bool error = false;

  String register = "";
  // String mobile = "";
  String email = "";
  String password = "";
  bool passwordVisible = false;
  bool hidepass = true;

  final Authservices auth = Authservices();

  int count = 0;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.amber[100],
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                padding: const EdgeInsets.fromLTRB(30.0, 190.0, 30.0, 10.0),
                child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Align(
                        alignment: FractionalOffset.topLeft,
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.amber[700],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        decoration: inputformdecoration.copyWith(
                          hintText: 'Enter the email',
                          labelText: 'Email',
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter email';
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                      ),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      // TextFormField(
                      //   decoration: inputformdecoration.copyWith(
                      //     hintText: 'Enter the register no',
                      //     labelText: 'Register No',
                      //   ),
                      //   autovalidateMode: AutovalidateMode.onUserInteraction,
                      //   keyboardType: TextInputType.number,
                      //   validator: (value) {
                      //     if (value!.isEmpty) {
                      //       return 'Please enter rigister no';
                      //     } else {
                      //       return null;
                      //     }
                      //   },
                      //   onChanged: (value) {
                      //     setState(() {
                      //       register = value;
                      //     });
                      //   },
                      // ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: inputformdecoration.copyWith(
                          hintText: 'Enter the Password',
                          labelText: 'Password',
                          suffixIcon: IconButton(
                            icon: Icon(passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(
                                () {
                                  passwordVisible = !passwordVisible;
                                  hidepass = !hidepass;
                                },
                              );
                            },
                          ),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        obscureText: hidepass,
                        validator: (value) {
                          if (value!.length < 6) {
                            return 'Please enter password greater 6 length';
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          setState(() {
                            password = value;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      if (error == true)
                        Text(
                          "Invalid e-mail or password",
                          style: const TextStyle(
                              color: Colors.red, fontSize: 14.0),
                        ),
                      if (error == true)
                        const SizedBox(
                          height: 20,
                        ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(330, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        onPressed: () async {
                          if (formkey.currentState!.validate()) {
                            setState(() {
                              loading = true;
                            });

                            dynamic result =
                                await auth.loginUser(email, password);
                            if (result == null) {
                              setState(() {
                                error = true;
                                loading = false;
                              });
                            }
                            print(result);
                            if (result != null) {
                              final SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              setState(() {
                                count = prefs.getInt('count') ?? 0;
                                count++;
                                prefs.setInt('count', count);
                              });
                            }
                            print('email: $email');
                            print('password: $password');
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          children: [
                            const Text(
                              "Register Now?",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              child: const Text(
                                'Sign Up',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.amber),
                              ),
                              onTap: () {
                                widget.toggleview();
                                // Navigator.pushReplacement(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) => const Signup()),
                                // );
                              },
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
