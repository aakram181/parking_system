import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parking_system/entities/car.dart';

class CarRepo {
  Car car;
  final CollectionReference carsRef =
      FirebaseFirestore.instance.collection("cars").withConverter<Car>(
            fromFirestore: (snapshot, _) => Car.fromJson(snapshot.data()!),
            toFirestore: (car, _) => car.toJson(),
          );
  CarRepo(this.car);

  Future<void> addCar() {
    return carsRef
        .add(car)
        .then((value) => print("Car Added"))
        .catchError((error) => print("Failed to add car: $error"));
  }

  // get user document path from user id
  static DocumentReference getRef(String uID) {
    final coll = FirebaseFirestore.instance.collection("users");
    return coll.doc(uID);
  }
}
