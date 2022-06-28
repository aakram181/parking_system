import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:parking_system/entities/parking_slots.dart';
import 'package:parking_system/screens/reserve_screen.dart';
import 'package:parking_system/utils/constants.dart';
import 'package:parking_system/widgets/main_button.dart';
import 'package:parking_system/widgets/parking_card.dart';

class MapPage extends StatefulWidget {
  static const String id = 'map_screen';

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final _firestore = FirebaseDatabase.instance.ref("Parking_slots");

  @override
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 60.0, 16.0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Parking Status',
              style: kTitleTextStyle,
            ),
            SizedBox(
              height: 5.0,
            ),
            Row(
              children: [
                Text(
                  'P1',
                  style: kTitleTextStyle,
                ),
                Text(
                  '1st Floor',
                  style: kSubTitleTextStyle,
                )
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('images/mapbg.jpg'),
                fit: BoxFit.fill,
              )),
              child: StreamBuilder<DatabaseEvent>(

                stream: _firestore.onValue.asBroadcastStream(),
                builder: (context,snapshot){
                  if(snapshot.hasData){
                  var data_x = snapshot.data!.snapshot.value;
                  List<ParkingCard> parkingWidget = [];
                  var data_map = data_x as Map<Object?,dynamic>;
                  var map_keys = data_map.keys.toList()..sort();
                  print(map_keys);
                  for(var k in map_keys){
                    final p = ParkingCard(
                      name:k.toString(),
                      parkState: ParkingSlots.toState(data_map[k]!['state'],
                    ), );
                    parkingWidget.add(p);
                  }
                    return GridView.count(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      mainAxisSpacing: 0,
                      crossAxisSpacing: 110,
                      crossAxisCount: 2,
                      children: parkingWidget,
                    );

                  }
                  if (snapshot.connectionState == ConnectionState.waiting){
                    return CircularProgressIndicator();
                  }

                return Text("ERROR"); //TODO ERROR
                }
              ),

            ),
            SizedBox(
              height: 30.0,
            ),
            Center(
              child: mainButton(
                  text: 'Reserve',
                  onPressed: () {

                    Navigator.pushNamed(context, ReserveScreen.id, arguments: args);

                  }),
            ),
          ],
        ),
      ),
    );
  }
}
