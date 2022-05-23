import 'dart:async';

import 'package:flutter/material.dart';
import 'package:parking_system/repository/auth_repo.dart';
import 'package:parking_system/utils/constants.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QImage extends StatefulWidget {
  const QImage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QImageState();
}

class _QImageState extends State<QImage> {
  final Stream<String> _data = (() {
    String data = '';
    String uID = AuthRepo.currentUid();
    // stream timer to change date every minute
    Stream<String> timer = Stream.periodic(const Duration(seconds: 5), (i) {
      DateTime dateTime = (DateTime.now());
      dateTime = dateTime.add(const Duration(seconds: 5));
      var timeStamp = dateFormat.format(dateTime);
      return timeStamp;
    });

    late final StreamController<String> controller;
    //define controller to update the data every on timer change
    controller = StreamController<String>(
      onListen: () async {
        timer.listen((event) {
          // change data every 1 min
          data = "$uID*$event";
          controller.add(data);
        });
      },
    );
    return controller.stream;
  })();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder<String>(
          stream: _data,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());

              case ConnectionState.active:
                return QrImage(
                  data: snapshot.data!,
                  version: QrVersions.auto,
                  size: 300.0,
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                );

              default:
                if (snapshot.hasError) {
                  throw Exception("An Error Occurred");
                }
            }
            return Column(children: const []);
          }),
    );
  }
}
