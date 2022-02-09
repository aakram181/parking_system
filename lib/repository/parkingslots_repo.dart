import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:parking_system/entities/parking_slots.dart';

class ParkingSlotsRepo {
  ParkingSlotsRepo();
  DatabaseReference slotsRef = FirebaseDatabase.instance.ref("Parking_slots");

  Future<List<ParkingSlots>> parkingMap() async {
    List<ParkingSlots>? plist = [];
    DataSnapshot lotsSnap;
    // Get the Stream
    DatabaseEvent event = await slotsRef.once();
    // stream.listen((event) {
    lotsSnap = event.snapshot;
    for (var doc in lotsSnap.children) {
      var name = doc.key;
      var state = doc.value!
          .toString()
          .substring(7, doc.value!.toString().lastIndexOf('}'));

      ParkingSlots p = ParkingSlots(name!, state);
      plist.add(p);
    }
    // });
    return plist;
  }

  // cloud fire store
  // final CollectionReference slotRef = FirebaseFirestore.instance
  //     .collection("parkingslots")
  //     .withConverter<ParkingSlots>(
  //       fromFirestore: (snapshot, _) => ParkingSlots.fromJson(snapshot.data()!),
  //       toFirestore: (slot, _) => slot.toJson(),
  //     );
  //
  // Future<QuerySnapshot<ParkingSlots>> docSnap() {
  //   return FirebaseFirestore.instance
  //       .collection("parkingslots")
  //       .withConverter<ParkingSlots>(
  //         fromFirestore: (snapshot, _) =>
  //             ParkingSlots.fromJson(snapshot.data()!),
  //         toFirestore: (slot, _) => slot.toJson(),
  //       )
  //       .orderBy(
  //         'pID',
  //       )
  //       .get();
  // }
  //
  // // return a future parking slots list
  // Future<List<ParkingSlots>?> parkingMap() async {
  //   List<ParkingSlots>? plist = [];
  //   var parkSnap = docSnap();
  //   await parkSnap.then((value) => {
  //         for (var doc in value.docs)
  //           {
  //             plist.add(doc.data()),
  //           },
  //       });
  //   return plist;
  // }
  //
  // void changeState(ParkingSlots slot, ParkState state) {
  //   FirebaseFirestore.instance
  //       .collection("parkingslots")
  //       .withConverter<ParkingSlots>(
  //         fromFirestore: (snapshot, _) =>
  //             ParkingSlots.fromJson(snapshot.data()!),
  //         toFirestore: (slot, _) => slot.toJson(),
  //       )
  //       .where('pID', isEqualTo: slot.pID)
  //       .get()
  //       .then((value) async => {
  //             for (var cslot in value.docs)
  //               {
  //                 print("Parking Slot " +
  //                     cslot.data().pID +
  //                     " State has been changed from " +
  //                     cslot.data().currentState.name +
  //                     " to " +
  //                     slot.currentState.name),
  //                 await cslot.reference.update({'currentState': state.name}),
  //               }
  //           });
  // }
}
