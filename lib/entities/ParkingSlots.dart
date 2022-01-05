import 'package:parking_system/utils/constants.dart';

// a parking slot can be full, empty or reserved

class ParkingSlots {
  final String pID;
  ParkState currentState;

  ParkingSlots({required this.pID, required this.currentState});

  factory ParkingSlots.fromJson(Map<String, dynamic> json) => ParkingSlots(
        pID: json['pID'] as String,
        currentState: toState(json['currentState']),
      );

  Map<String, dynamic> toJson() => {
        "pID": pID,
        "currentState": currentState.toString(),
      };

  static ParkState toState(String state) {
    switch (state) {
      case "occupied":
        return ParkState.occupied;
      case "empty":
        return ParkState.empty;
      case "reserved":
        return ParkState.reserved;
    }
    return ParkState.unknown;
  }

  @override
  String toString() {
    return 'ParkingSlots{{ID: $pID},currentState: $currentState}';
  }
}
