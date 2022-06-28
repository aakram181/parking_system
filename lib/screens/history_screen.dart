import 'package:flutter/material.dart';
import 'package:parking_system/entities/history.dart';
import 'package:parking_system/utils/view_model.dart';
import 'package:parking_system/widgets/transaction_card.dart';

class HistoryScreen extends StatefulWidget {
  static const String id = 'history_screen';

  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  // Create a list of transaction history
  late List<History> _history;
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
      body: FutureBuilder(
          future: ViewModel.getTransactions(),
          builder:
              (BuildContext context, AsyncSnapshot<List<History>> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError) {
                  throw Exception("An Error Occurred");
                }
            }
            _history = snapshot.data!;
            return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: _history.length,
                itemBuilder: (BuildContext context, int index) {
                  return TransactionCard(transaction: _history[index]);
                });
          }),
    );
  }
}
