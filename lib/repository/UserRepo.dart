import 'package:cloud_firestore/cloud_firestore.dart';

import '../entities/User.dart';

class UserRepo {
  User user;
  final CollectionReference usersRef =
      FirebaseFirestore.instance.collection('users').withConverter<User>(
            fromFirestore: (snapshot, _) => User.fromJson(snapshot.data()!),
            toFirestore: (user, _) => user.toJson(),
          );
  UserRepo(this.user);

  Future<void> addUser() {
    return usersRef
        .doc(user.uid)
        .set(user)
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> deleteUser(String uID) {
    return usersRef.doc(uID).delete();
  }
}
