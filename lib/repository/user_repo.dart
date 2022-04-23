import 'package:cloud_firestore/cloud_firestore.dart';

import '../entities/user.dart';

class UserRepo {
  static final CollectionReference usersRef =
      FirebaseFirestore.instance.collection('users').withConverter<User>(
            fromFirestore: (snapshot, _) => User.fromJson(snapshot.data()!),
            toFirestore: (user, _) => user.toJson(),
          );
  static Future<void> addUser(User user) {
    return usersRef
        .doc(user.uid)
        .set(user)
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  static Future<void> deleteUser(String uID) {
    return usersRef.doc(uID).delete();
  }

  static Future<String> getUsername(String uid) async {
    late String username;
    await usersRef.doc(uid).get().then((value) {
      username = value['username'];
    });
    return username;
  }
}
