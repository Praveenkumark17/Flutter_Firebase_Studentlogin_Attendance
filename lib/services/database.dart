import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demofire/models/user.dart';
import 'package:demofire/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  final FirebaseAuth auth = FirebaseAuth.instance;

  // final id = Authservices().getCurrentUser()!.uid;    //don't use this overflow

  // Add user to the database
  Future<void> addUserToDatabase(Users user, uid) async {
    print('db: $uid');
    try {
      await usersCollection.doc(uid).set(user.toMap());
    } catch (e) {
      print('Error adding user to database: $e');
    }
  }

  //send User Values to UI pages and get current id value in Current UI page
  Stream<Map<String, dynamic>> getUserData(String id) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .snapshots()
        .map((snapshot) => snapshot.data() as Map<String, dynamic>);
  }

  // Future<void> uploadImage(String imagePath) async {
  //   if (imagePath == null) return;

  //   String fileName = DateTime.now().millisecondsSinceEpoch.toString();
  //   Reference ref = storage.ref().child(fileName);
  //   await ref.putFile(File(imagePath));
  //   String imageUrl = await ref.getDownloadURL();

  //   await firestore.collection('users').doc(id).set({
  //     'refNumber': fileName,
  //     'url': imageUrl,
  //   });

  //   print('Uploaded image URL: $imageUrl');
  // }
}
