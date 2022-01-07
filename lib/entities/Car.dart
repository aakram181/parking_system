import 'dart:core';

class Car {
  final String licensePlate;
  final String uID;
  Car({required this.licensePlate, required this.uID});

  factory Car.fromJson(Map<String, dynamic> json) => Car(
        licensePlate: json['licensePlate']! as String,
        uID: json['uID']! as String,
      );

  Map<String, dynamic> toJson() => {
        "licensePlate": licensePlate,
        "uID": uID,
      };

  @override
  String toString() {
    return 'Car{licensePlate: $licensePlate}';
  }
}
