import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parking_system/entities/car.dart';

class CarRepo {
  Car car;
  // firestore reference
  final CollectionReference carsRef =
      FirebaseFirestore.instance.collection("cars").withConverter<Car>(
            fromFirestore: (snapshot, _) => Car.fromJson(snapshot.data()!),
            toFirestore: (car, _) => car.toJson(),
          );
  CarRepo(this.car);
  //realtime database reference
  // DatabaseReference carsRef =
  //     FirebaseDatabase.instance.ref("cars"); // reference cars object

  Future<void> addCar() {
    // return carsRef.set(car); // add car to realtime database
    // add car to cloud firestore
    return carsRef
        .add(car)
        .then((value) => print("Car Added")) //ToDo: flag success
        .catchError(
            (error) => print("Failed to add car: $error")); //ToDo: flag error
  }

  // get user document path from user id
  static DocumentReference getRef(String uID) {
    final coll = FirebaseFirestore.instance.collection("users");
    return coll.doc(uID);
  }
}
