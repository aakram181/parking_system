import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo {
  static Future<String?> signUp(String email, String password) async {
    try {
      UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return credential.user!.uid;
    } on FirebaseAuthException catch (e) {
      print("Firebase Exception: " + e.code);
    }
  }

  static Future<String?> signIn(String email, String password) async {
    try {
      final newUser = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return newUser.user!.uid.toString();
    } on FirebaseAuthException catch (e) {
      print("Firebase Exception: " + e.code);
    }
  }

  static Future<String?> changePassword( String newPassword) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser!;
      currentUser.updatePassword(newPassword);

    } on FirebaseAuthException catch (e) {
      print("Firebase Exception: " + e.code);
    }
  }

  static void logOut() async {
    await FirebaseAuth.instance.signOut();
  }

  static Future<String?> deleteUser() async {
    try {
      await FirebaseAuth.instance.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      print("Firebase Exception: " + e.code);
    }
  }

  static Future<String?> reAuth(String email, String password) async {
    AuthCredential cred =
        EmailAuthProvider.credential(email: email, password: password);

    try {
      await FirebaseAuth.instance.currentUser!
          .reauthenticateWithCredential(cred);
    } on FirebaseAuthException catch (e) {
      print("Firebase Exception: " + e.code);
    }
  }

  static Future<String> currentToken() {
    return FirebaseAuth.instance.currentUser!.getIdToken(true);
  }

  static String currentUid() {
    return FirebaseAuth.instance.currentUser!.uid;
  }

  static String currentEmail() {
    return FirebaseAuth.instance.currentUser!.email!;
  }

  static StreamSubscription onTokenChange() {
    return FirebaseAuth.instance.idTokenChanges().listen((event) {
      event!.getIdToken(true);
    });
  }

  static Future <void> changeEmail(String email) async{
    await FirebaseAuth.instance.currentUser!.updateEmail(email);
  }


}
