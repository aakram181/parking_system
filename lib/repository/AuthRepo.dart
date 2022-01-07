import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo {
  static Future<String?> signUp(String email, String password) async {
    try {
      UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return credential.user!.uid;
    } on FirebaseAuthException catch (e) {
      print(e.code);
    }
  }

  static Future<String?> signIn(String email, String password) async {
    try {
      UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return credential.user!.uid;
    } on FirebaseAuthException catch (e) {
      print(e.code);
    }
  }

  static Future<String?> changePassword(
      String currentPassword, String newPassword) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser!;
      final cred = EmailAuthProvider.credential(
          email: currentUser.email!, password: currentPassword);
      if (cred != null) {
        currentUser.updatePassword(newPassword);
      }
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  static void logOut() async {
    await FirebaseAuth.instance.signOut();
  }

  static Future<String?> deleteUser() async {
    try {
      await FirebaseAuth.instance.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  static Future<String?> reAuth(String email, String password) async {
    AuthCredential cred =
        EmailAuthProvider.credential(email: email, password: password);

    try {
      await FirebaseAuth.instance.currentUser!
          .reauthenticateWithCredential(cred);
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }
}
