import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:date_format/date_format.dart';
import 'package:demofire/models/user.dart';
import 'package:demofire/screen/authenticate/pre_auth.dart';
import 'package:demofire/screen/authenticate/signin.dart';
import 'package:demofire/services/auth.dart';
import 'package:demofire/services/database.dart';
import 'package:demofire/shared/loading.dart';
import 'package:demofire/shared/textform.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Signup extends StatefulWidget {
  final Function toggleview;
  Signup({required this.toggleview});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final formkey = GlobalKey<FormState>();
  final List<String> dept = ['CSE', 'ECE', 'EEE', 'Mech', 'Civil'];

  bool loading = false;
  int count = 0;

  // String imageUrl = "";
  String firstname = "";
  String lastname = "";
  String register = "";
  String mobile = "";
  String gender = "";
  String dob = "";
  String? dep;
  // String othergender = "";
  String email = "";
  String password = "";
  // bool Ogender = false;
  bool passwordVisible = false;
  bool hidepass = true;
  bool error = false;
  bool load = false;
  String gendererror = "";
  Authservices authService = Authservices();
  DatabaseService databaseService = DatabaseService();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;

  final picker = ImagePicker();
  XFile? imageFile;
  String? imagepath;
  String? imageURL;

  Future<XFile?> pickImagegallery() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      load = imageFile == null ? true : false;
    });
    return pickedImage;
  }

  Future<XFile?> pickImagecamera() async {
    final pickedImage = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      load = imageFile == null ? true : false;
    });
    return pickedImage;
  }

  Future<XFile?> cropImage(XFile imageFile) async {
    CroppedFile? croppedImage =
        await ImageCropper().cropImage(sourcePath: imageFile.path);
    if (croppedImage == null) {
      return null;
    }
    return XFile(croppedImage.path);
  }

Future<void> uploadImageToStorage(XFile pickedImage) async {
  if (pickedImage != null) {
    XFile? croppedImage = await cropImage(pickedImage);
    if (croppedImage != null) {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference ref = storage.ref().child(fileName);
      await ref.putFile(File(croppedImage.path));
      String imageUrl = await ref.getDownloadURL();
      setState(() {
        imageFile = croppedImage;
        imagepath = imageFile!.path;
        imageURL = imageUrl;
        load = imageFile == null ? true : false;
      });
    }
  }
}
Future<void> _selectAndCropImageFromCamera() async {
  XFile? pickedImage = await pickImagecamera();
  await uploadImageToStorage(pickedImage!);
}

Future<void> _selectAndCropImageFromgallery() async {
  XFile? pickedImage = await pickImagegallery();
  await uploadImageToStorage(pickedImage!);
}


  // void uploadImage() async {
  //   if (imageFile == null) return;
  //   String fileName = DateTime.now().millisecondsSinceEpoch.toString();
  //   firebase_storage.Reference ref =
  //       firebase_storage.FirebaseStorage.instance.ref().child(fileName);
  //   await ref.putFile(File(imageFile!.path));
  //   String imageUrl = await ref.getDownloadURL();

  //   // await FirebaseFirestore.instance.collection('images').add({
  //   //   'refNumber': fileName,
  //   //   'url': imageUrl,
  //   // });

  //   print('Uploaded image URL: $imageUrl');
  // }

  // DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: dob.isNotEmpty ? DateTime.parse(dob) : DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      final DateFormat formatter = DateFormat('dd-MM-yyyy');
      final String formattedDate = formatter.format(pickedDate);
      setState(() {
        dob = formattedDate;
      });
    }
  }

  void buttonmodel() {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20.0),
          ),
        ),
        backgroundColor: Colors.amber[100],
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            height: 200,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(270, 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
                    _selectAndCropImageFromgallery();
                    // XFile? pickedImage = await pickImagegallery();
                    // setState(() async {
                    //   imageFile = pickedImage;
                    // });
                    Navigator.pop(context);
                  },
                  child: Text("Gallery Image"),
                ),
                SizedBox(
                  height: 15,
                ),
                Text("OR"),
                SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(270, 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
                    _selectAndCropImageFromCamera();
                    // XFile? pickedImage = await pickImagecamera();
                    // setState(() {
                    //   imageFile = pickedImage;
                    // });
                    Navigator.pop(context);
                  },
                  child: Text("Open Camera"),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.amber[100],
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 10.0),
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
                          'Sign Up',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.amber[700],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        borderRadius: BorderRadius.all(Radius.circular(45)),
                        child: CircleAvatar(
                          backgroundColor: Colors.amber[200],
                          radius: 45,
                          child: load
                              ? CircularProgressIndicator(
                                  strokeWidth: 4,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.amber),
                                ):
                                imageFile != null
                                  ? ClipOval(
                                      child: Container(
                                        height: 150,
                                        width: 150,
                                        decoration: BoxDecoration(),
                                        child: Image.file(
                                          File(imageFile!.path),
                                          height: 200,
                                        ),
                                      ),
                                    )
                                  : Icon(
                                      Icons.person,
                                      size: 45,
                                    )
                        ),
                        onTap: () {
                          setState(() {
                            buttonmodel();
                          });
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: inputformdecoration.copyWith(
                          hintText: 'Enter the first name',
                          labelText: 'First Name',
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter first name';
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          setState(() {
                            firstname = value;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: inputformdecoration.copyWith(
                          hintText: 'Enter the last name',
                          labelText: 'Last Name',
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter last name';
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          setState(() {
                            lastname = value;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.none,
                        decoration: inputformdecoration.copyWith(
                          hintText: 'Pick the dob',
                          labelText: 'Date of Birth',
                        ),
                        readOnly: true,
                        controller: TextEditingController(
                          text: dob,
                        ),
                        onTap: () {
                          _selectDate(context);
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: inputformdecoration.copyWith(
                          hintText: 'Enter the register no',
                          labelText: 'Register No',
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter rigister no';
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          setState(() {
                            register = value;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      DropdownButtonFormField<String>(
                        value: dep,
                        decoration: inputformdecoration.copyWith(
                            labelText: "Department"),
                        onChanged: (String? newValue) {
                          setState(() {
                            dep = newValue!;
                          });
                        },
                        items: dept.map((String option) {
                          return DropdownMenuItem<String>(
                            value: option,
                            child: Text(option),
                          );
                        }).toList(),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^[6-9][0-9]{0,9}$')),
                        ],
                        decoration: inputformdecoration.copyWith(
                          hintText: 'Enter the mobile number',
                          labelText: 'Mobile No',
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter mobile no';
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          setState(() {
                            mobile = value;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Text(
                            "Gender:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Radio(
                            value: 'male',
                            groupValue: gender,
                            onChanged: (value) {
                              setState(() {
                                gender = value!;
                                // Ogender = false;
                                gendererror = "";
                              });
                            },
                          ),
                          const Text(
                            "Male",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Radio(
                            value: 'female',
                            groupValue: gender,
                            onChanged: (value) {
                              setState(() {
                                gender = value!;
                                // Ogender = false;
                                gendererror = "";
                              });
                            },
                          ),
                          const Text(
                            "Female",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Radio(
                            value: 'others',
                            groupValue: gender,
                            onChanged: (value) {
                              setState(() {
                                gender = value!;
                                // Ogender = true;
                                gendererror = "";
                              });
                            },
                          ),
                          const Text(
                            "Others",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Align(
                          alignment: FractionalOffset.centerLeft,
                          child: Text(
                            gendererror,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 212, 31, 18),
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // if (Ogender)
                      //   TextFormField(
                      //     decoration: inputformdecoration.copyWith(
                      //       hintText: 'Enter the gender name',
                      //       labelText: 'Gender Name',
                      //     ),
                      //     autovalidateMode: AutovalidateMode.onUserInteraction,
                      //     validator: (value) {
                      //       if (value!.isEmpty) {
                      //         return 'Please enter gender name as your select';
                      //       } else {
                      //         return null;
                      //       }
                      //     },
                      //     onChanged: (value) {
                      //       setState(() {
                      //         othergender = value;
                      //       });
                      //     },
                      //   ),
                      // if (Ogender)
                      //   const SizedBox(
                      //     height: 20,
                      //   ),
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
                            return 'Password must greater than 6 length';
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
                        const Text(
                          "E-mail already registered",
                          style: TextStyle(color: Colors.red, fontSize: 14.0),
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
                          'Sign Up',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        onPressed: () async {
                          if (gender == "") {
                            setState(() {
                              gendererror = "Please Select the Gender Option";
                            });
                          }
                          if (formkey.currentState!.validate()) {
                            final usersD = Users(
                                firstname,
                                lastname,
                                register,
                                mobile,
                                gender,
                                email,
                                password,
                                dob,
                                imagepath!,
                                imageURL!);
                            setState(() {
                              loading = true;
                            });
                            dynamic result = await authService
                                .signUpWithEmailAndPassword(usersD);
                            // await databaseService.uploadImage(imagepath!);
                            // Preuser(id: false);
                            if (result == null) {
                              setState(() {
                                loading = false;
                                error = true;
                              });
                            }
                            if (result != null) {
                              final SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              setState(() {
                                count = prefs.getInt('count') ?? 0;
                                count++;
                                prefs.setInt('count', count);
                              });
                              print('user register success');
                            }
                          }
                          print('fname: $firstname');
                          print('lname: $lastname');
                          print('registerno: $register');
                          print('mobile: $mobile');
                          print('gender: $gender');
                          print('email: $email');
                          print('password: $password');
                          print('dob: $dob');
                          print('img_path: $imagepath');
                          print('img_URL: $imageURL');
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
                              'Already Registered?',
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
                                'Sign In',
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
                                //       builder: (context) => const Signin()),
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
