enum TransactionStatus { ongoing, complete, cancelled, reserved }

class Transaction {
  final String gTitle; // garage name
  final String uID; // user ID
  TransactionStatus status = TransactionStatus.ongoing;
//  late String pID; // parking slot ID
  DateTime entryTime = DateTime(2022, 4, 1, 0, 0, 0);
  DateTime exitTime = DateTime(2022, 4, 1, 0, 0, 0);
  int fees = 0;
  Transaction(
      {required this.uID,
      required this.gTitle,
      required this.entryTime,
      required this.exitTime,
      required this.fees,
      required this.status});
  Transaction.entry(
      { //required this.pID,
      required this.uID,
      required this.gTitle,
      required this.entryTime,
      this.status = TransactionStatus.ongoing});
  Transaction.reserve(
      {required this.uID,
      required this.gTitle,
      this.status = TransactionStatus.reserved});

  factory Transaction.fromJsonEntry(Map<String, dynamic> json) =>
      Transaction.entry(
        // pID: json['pID'] as String,
        uID: json['uID'] as String,
        gTitle: json['gTitle'] as String,
        entryTime: (json['entryTimeStamp']),
      );

  Map<String, dynamic> toJson() => {
        //'pID': pID,
        'uID': uID,
        'gTitle': gTitle,
      };

  void updateStatus(TransactionStatus status) {
    this.status = status;
  }

  String dateTimetoString(DateTime time, String string) {
    int day = time.day;
    int month = time.month;
    int year = time.year;
    int hour = time.hour;
    int min = time.minute;
    int sec = time.second;
    return "$string: $day/$month/$year $hour:$min:$sec";
  }

// void setEntryTime(Timestamp entryTime) {
//   this.entryTime = entryTime.toDate();
// }
//
// void setExitTime(Timestamp exitTime) {
//   this.exitTime = exitTime.toDate();
//   updateStatus(TransactionStatus.complete);
// }
}
