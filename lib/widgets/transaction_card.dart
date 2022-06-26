import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking_system/entities/history.dart';

TextStyle kListTileStyle = TextStyle(
  fontFamily: 'Cairo',
  fontSize: 15.0.sp,
  fontWeight: FontWeight.w300,
  color: Colors.black,
);

class TransactionCard extends StatelessWidget {
  History transaction;

  TransactionCard({required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.garage_outlined),
                    title: Text(transaction.gTitle, style: kListTileStyle),
                  ),
                  ListTile(
                      leading: CircleAvatar(
                          backgroundColor: Colors.red.shade900, radius: 9),
                      title: Text(
                        transaction.dateTimetoString(
                            transaction.entryTime, "Entry Time"),
                      )),
                  ListTile(
                      leading: CircleAvatar(
                          backgroundColor: Colors.green.shade900, radius: 9),
                      title: Text(
                        transaction.ExitString(),
                      )),
                  ListTile(
                    leading: const Icon(Icons.account_balance_wallet_outlined),
                    title: Text(
                        transaction.fees.roundToDouble().toString() + " EGP"),
                  )
                ],
              ),
            ),
            transaction.status == HistoryStatus.complete
                ? const SizedBox(
                    width: 60, child: Icon(Icons.check, color: Colors.green))
                : transaction.status == HistoryStatus.cancelled
                    ? const SizedBox(width: 60, child: Icon(Icons.cancel))
                    : transaction.status == HistoryStatus.reserved
                        ? const SizedBox(width: 60, child: Icon(Icons.cancel))
                        : const SizedBox(
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 30,
                              child: Icon(Icons.more_horiz),
                            ),
                          ),
          ],
        ),
      ),
    );
  }
}
