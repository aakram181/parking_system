import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parking_system/entities/history.dart';

class HistoryRepo {
  String uID;
  late CollectionReference historyRef;
  late History history;

  HistoryRepo(this.uID);

  Future<List<History>> getTransactions() async {
    List<History> transactions = [];
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uID)
        .collection("history")
        .withConverter<History>(
          fromFirestore: (snapshot, _) => History.fromJson(snapshot.data()!),
          toFirestore: (history, _) => history.toJson(),
        )
        .get()
        .then((QuerySnapshot<History> querySnapshot) {
      for (var element in querySnapshot.docs) {
        if (element['ExitTimestamp'] == element['EntryTimestamp']) {
          history = History.entry(
              gTitle: element['GarageName'],
              entryTime: element['EntryTimestamp']);
        } else {
          history = element.data();
        }
        transactions.add(history);
      }
    });
    return transactions;
  }
}
