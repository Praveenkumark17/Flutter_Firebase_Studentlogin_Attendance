import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demofire/shared/textform.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Profileupdate extends StatefulWidget {
  const Profileupdate({super.key});

  @override
  State<Profileupdate> createState() => _ProfileupdateState();
}

class _ProfileupdateState extends State<Profileupdate> {
  // final formkey = GlobalKey<FormState>();

  // String firstname = "";
  // String lastname = "";

  // final picker = ImagePicker();
  // XFile? imageFile;
  // XFile? CimageFile;

  // Future<XFile?> pickImage() async {
  //   final pickedImage = await picker.pickImage(source: ImageSource.camera);
  //   return pickedImage;
  // }
  // Future<XFile?> pickgall() async {
  //   final pickedImage = await picker.pickImage(source: ImageSource.gallery);
  //   return pickedImage;
  // }

  // Future<XFile?> cropImage(XFile imageFile) async {
  //   CroppedFile? croppedImage =
  //       await ImageCropper().cropImage(sourcePath: imageFile.path);
  //   if (croppedImage == null) {
  //     return null;
  //   }
  //   return XFile(croppedImage.path);
  // }

  // Future<void> _selectAndCropImageFromCamera() async {
  //   XFile? pickedImages = await pickImage();
  //   if (pickedImages != null) {
  //     XFile? croppedImage = await cropImage(pickedImages);
  //     setState(() {
  //       imageFile = croppedImage;
  //     });
  //   }
  // }
  // Future<void> _selectAndCropImageFromgallery() async {
  //   XFile? pickedImages = await pickgall();
  //   if (pickedImages != null) {
  //     XFile? croppedImage = await cropImage(pickedImages);
  //     setState(() {
  //       imageFile = croppedImage;
  //     });
  //   }
  // }
  // void uploadImage() async {
  //   if (imageFile == null) return;
  //   String fileName = DateTime.now().millisecondsSinceEpoch.toString();
  //   firebase_storage.Reference ref =
  //       firebase_storage.FirebaseStorage.instance.ref().child(fileName);
  //   await ref.putFile(File(imageFile!.path));
  //   String imageUrl = await ref.getDownloadURL();

  //   await FirebaseFirestore.instance.collection('images').add({
  //     'refNumber': fileName,
  //     'url': imageUrl,
  //   });

  //   print('Uploaded image URL: $imageUrl');
  // }

  // String imageUrl = "";
  // void fetchImage() async {
  //   DocumentSnapshot snapshot = await FirebaseFirestore.instance
  //       .collection('images')
  //       .doc('documentId')
  //       .get();
  //    if (snapshot.exists) {
  //     Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
  //     if (data != null && data.containsKey('url')) {
  //       setState(() {
  //         imageUrl = data['url'];
  //       });
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Profile"),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
        // key: formkey,
        child: Form(
          child: Column(
            children: [
              // ElevatedButton(
              //   onPressed: () async {
              //      _selectAndCropImageFromCamera();
              //     // setState(() {
              //     //   imageFile = pickedImage;
              //     // });
              //   },
              //   child: Text('Pick Image'),
              // ),
              // ElevatedButton(
              //   onPressed: () async {
              //      _selectAndCropImageFromgallery();
              //     // setState(() {
              //     //   imageFile = pickedImage;
              //     // });
              //   },
              //   child: Text('Pick gall'),
              // ),
              // SizedBox(height: 16),
              // if (imageFile != null)
              //   Image.file(
              //     File(imageFile!.path),
              //     height: 200,
              //   ),
              // SizedBox(height: 16),
              // ElevatedButton(
              //   onPressed: () {},
              //   child: Text('Upload Image'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
