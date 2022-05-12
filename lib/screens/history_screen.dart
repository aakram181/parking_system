import 'package:flutter/material.dart';
import 'package:parking_system/entities/transactions.dart';
import 'package:parking_system/widgets/transaction_card.dart';

class HistoryScreen extends StatefulWidget {
  static const String id = 'history_screen';

  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  // Create a list of transaction history
  List<Transaction> history = <Transaction>[
    Transaction.entry(uID: "1", gTitle: "Maadi", entryTime: DateTime.now()),
    Transaction.reserve(uID: "2", gTitle: "Opera"),
    Transaction.entry(
        uID: "2", gTitle: "Maadi", entryTime: DateTime(2022, 4, 1, 10, 33, 40)),
    Transaction(
        uID: '2',
        gTitle: 'Zamalek',
        entryTime: DateTime(2022, 4, 1, 10, 33, 40),
        exitTime: DateTime.now(),
        fees: 5,
        status: TransactionStatus.complete)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF08051F),
        toolbarHeight: 56,
        centerTitle: true,
        title: const Text(
          "Your history ",
        ),
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: history.length,
          itemBuilder: (BuildContext context, int index) {
            return TransactionCard(transaction: history[index]);
          }),
    );
  }
}
