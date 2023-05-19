import 'package:demofire/models/user.dart';
import 'package:demofire/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Authservices {
  DatabaseService databaseService = DatabaseService();
  final FirebaseAuth auth = FirebaseAuth.instance;

  // //pre obj
  // Preuser? preUserIDFromFirebaseUser(ids) {
  //   if (user == null) {
  //     return null;
  //   } else {
  //     print('PreuserID : $ids');
  //     return Preuser(id: ids);
  //   }
  // }

  // //auth change user
  // Stream<Preuser?> get preid {
  //   return auth.authStateChanges().map(preUserIDFromFirebaseUser);
  // }

  //create user obj
  UserID? userIDFromFirebaseUser(User? user, bool puid) {
    if (user == null) {
      return null;
    } else {
      print('userID : ' + user.uid);
      print('puid : ' + puid.toString());
      return UserID(uid: user.uid, puid: puid);
    }
  }

  //auth change user
  Stream<UserID?> get user {
    return auth
        .authStateChanges()
        .map((user) => userIDFromFirebaseUser(user, false));
  }

  //register
  Future signUpWithEmailAndPassword(Users usersD) async {
    try {
      UserCredential result = await auth.createUserWithEmailAndPassword(
          email: usersD.email, password: usersD.password);
      User? users = result.user;
      //get current uid
      final Uid = auth.currentUser?.uid;
      databaseService.addUserToDatabase(usersD, Uid);
      print('UID :$Uid');
      print('AUTH :$users');
      bool puid = false;
      // return userCredential.user;
      return userIDFromFirebaseUser(users, puid);
    } on FirebaseAuthException catch (e) {
      print('Failed to create user: ${e.message}');
      return null;
    }
  }

  User? getCurrentUser() {
    return auth.currentUser;
  }

  //Sign in
  Future loginUser(String email, String password) async {
    try {
      UserCredential result = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      print('User logged in successfully!');
      return userIDFromFirebaseUser(user, false);
    } catch (e) {
      print('Error logging in user: $e');
      return null;
    }
  }

  //sign out
  Future<void> Signout() async {
    try {
      await auth.signOut();
    } catch (e) {
      print('Error signing out: $e');
    }
  }
}
