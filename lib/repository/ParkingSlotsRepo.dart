import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parking_system/entities/ParkingSlots.dart';

class ParkingSlotsRepo {
  ParkingSlotsRepo();

  Future<QuerySnapshot<ParkingSlots>> docSnap() {
    return FirebaseFirestore.instance
        .collection("parkingslots")
        .withConverter<ParkingSlots>(
          fromFirestore: (snapshot, _) =>
              ParkingSlots.fromJson(snapshot.data()!),
          toFirestore: (slot, _) => slot.toJson(),
        )
        .get();
  }

  // return a future parkingslots list
  Future<List<ParkingSlots>?> parkingMap() async {
    List<ParkingSlots>? plis = [];
    var parkSnap = docSnap();
    await parkSnap.then((value) => {
          for (var doc in value.docs)
            {
              plis.add(doc.data()),
            },
        });
    return plis;
  }
}
