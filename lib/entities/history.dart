import 'package:cloud_firestore/cloud_firestore.dart';

enum HistoryStatus { ongoing, complete, cancelled, reserved }

class History {
  final String gTitle; // garage name
  // final String uID; // user ID
  String status = "ongoing";
//  late String pID; // parking slot ID
  late Timestamp entryTime;
  late Timestamp exitTime;
  num fees = 0;
  History(
      {required this.gTitle,
      required this.entryTime,
      required this.exitTime,
      required this.fees,
      required this.status});
  History.entry({
    required this.gTitle,
    required this.entryTime,
  });
  History.reserve({required this.gTitle, this.status = "reserved"});

  factory History.fromJson(Map<String, dynamic> json) => History(
        gTitle: json['GarageName'] as String,
        entryTime: (json['EntryTimestamp']),
        exitTime: (json['ExitTimestamp'])!,
        fees: (json['Fees']),
        status: (json['state']),
      );

  Map<String, dynamic> toJson() => {
        'GarageName': gTitle,
      };

  void updateStatus(String status) {
    this.status = status;
  }

  String ExitString() {
    if (status == 'ongoing') {
      return "Exit Time: N/A";
    }
    return dateTimetoString(exitTime, "Exit Time");
  }

  String dateTimetoString(Timestamp time, String string) {
    var date =
        DateTime.fromMillisecondsSinceEpoch(time.millisecondsSinceEpoch * 1000);
    int day = date.day;
    int month = date.month;
    int year = date.year;
    int hour = date.hour;
    int min = date.minute;
    int sec = date.second;
    return "$string: $day/$month/$year $hour:$min:$sec";
  }
}
