import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking_system/entities/transactions.dart';

TextStyle kListTileStyle = TextStyle(
  fontFamily: 'Cairo',
  fontSize: 15.0.sp,
  fontWeight: FontWeight.w300,
  color: Colors.black,
);

class TransactionCard extends StatelessWidget {
  Transaction transaction;

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
                        transaction.dateTimetoString(
                            transaction.exitTime, "Exit Time"),
                      )),
                  // Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     children: [
                  //       Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           CircleAvatar(
                  //               backgroundColor: Colors.red.shade900,
                  //               radius: 9),
                  //           SizedBox(
                  //               height: 40,
                  //               child: VerticalDivider(
                  //                   color: Colors.grey.shade700)),
                  //           CircleAvatar(
                  //               backgroundColor: Colors.green.shade900,
                  //               radius: 9),
                  //         ],
                  //       ),
                  //       Column(
                  //         // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           SizedBox(
                  //             height: 45,
                  //             child: Text(
                  //               transaction.dateTimetoString(
                  //                   transaction.entryTime, "Entry Time"),
                  //               style: kListTileStyle,
                  //             ),
                  //           ),
                  //           SizedBox(
                  //             height: 41,
                  //             child: Text(
                  //                 transaction.dateTimetoString(
                  //                     transaction.exitTime, "Exit Time"),
                  //                 style: kListTileStyle),
                  //           ),
                  //         ],
                  //       )
                  //     ]),
                  ListTile(
                    leading: const Icon(Icons.account_balance_wallet_outlined),
                    title: Text(transaction.fees.toString() + " EGP"),
                  )
                ],
              ),
            ),
            transaction.status == TransactionStatus.complete
                ? const SizedBox(
                    width: 60, child: Icon(Icons.check, color: Colors.green))
                : transaction.status == TransactionStatus.cancelled
                    ? const SizedBox(width: 60, child: Icon(Icons.cancel))
                    : transaction.status == TransactionStatus.reserved
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
