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

  static Future<void> UpdateUser(User user) {
    return usersRef
        .doc(user.uid)
        .update({ "email":user.email,"username":user.username})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
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

  static Future<bool> getReservation(String uid) async{
    late bool has_reservation;
    await usersRef.doc(uid).get().then((value){
      has_reservation = value['has_reservation'];
    });
    return has_reservation;
  }

  static Future<void> setReservation(String uid, bool has_reservation) async{
    return usersRef
        .doc(uid)
        .update({"has_reservation": has_reservation})
        .then((value) => print("Reservation status updates"))
        .catchError((error) => print("Failed to update user: $error"));
  }



}
