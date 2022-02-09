import 'package:flutter/material.dart';
import 'package:parking_system/entities/parking_slots.dart';
import 'package:parking_system/repository/parkingslots_repo.dart';
import 'package:parking_system/utils/constants.dart';
import 'package:parking_system/widgets/main_button.dart';
import 'package:parking_system/widgets/parking_card.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

Future<Map<String, ParkState>> getMap(
    Future<List<ParkingSlots>> parkMap) async {
  Map<String, ParkState> map = {};

  await parkMap.then((value) => {
        for (var slot in value) {map[slot.pID] = slot.currentState}
      });
  return map;
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    ParkingSlotsRepo pp = ParkingSlotsRepo();
    var plist = pp.parkingMap();

    Map<String, ParkState>? parkingMap = {};

    void setSelectedIndex(String id) {
      setState(() {
        selectedCardID = id;
        print(selectedCardID);
      });
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Parking Status',
              style: kTitleTextStyle,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 9.5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  Text(
                    'Tap on an empty spot to reserve',
                    style: kSubTitleTextStyle,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('images/mapbg.jpg'),
                  fit: BoxFit.fill,
                )),
                child: FutureBuilder<Map<String, ParkState>>(
                    future: getMap(plist),
                    builder: (BuildContext context,
                        AsyncSnapshot<Map<String, ParkState>> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                          return const Center(
                              child: CircularProgressIndicator());
                          break;
                        default:
                          if (snapshot.hasError) {
                            throw Exception("An Error Occurred");
                          }
                      }
                      parkingMap = snapshot.data;
                      print(parkingMap);
                      return GridView.count(
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        mainAxisSpacing: 0,
                        crossAxisSpacing: 110,
                        crossAxisCount: 2,
                        children: [
                          ParkingCard(
                            name: 'A1',
                            parkState: parkingMap!.values.elementAt(0),
                            id: parkingMap!.keys.elementAt(0),
                            onPressed: () =>
                                setSelectedIndex(parkingMap!.keys.elementAt(0)),
                          ),
                          ParkingCard(
                              name: 'B1',
                              parkState: parkingMap!.values.elementAt(4),
                              id: parkingMap!.keys.elementAt(4),
                              onPressed: () => setSelectedIndex(
                                  parkingMap!.keys.elementAt(4))),
                          ParkingCard(
                              name: 'A2',
                              parkState: parkingMap!.values.elementAt(1),
                              id: parkingMap!.keys.elementAt(1),
                              onPressed: () => setSelectedIndex(
                                  parkingMap!.keys.elementAt(1))),
                          ParkingCard(
                              name: 'B2',
                              parkState: parkingMap!.values.elementAt(5),
                              id: parkingMap!.keys.elementAt(5),
                              onPressed: () => setSelectedIndex(
                                  parkingMap!.keys.elementAt(5))),
                          ParkingCard(
                              name: 'A3',
                              parkState: parkingMap!.values.elementAt(2),
                              id: parkingMap!.keys.elementAt(2),
                              onPressed: () => setSelectedIndex(
                                  parkingMap!.keys.elementAt(2))),
                          ParkingCard(
                              name: 'B3',
                              parkState: parkingMap!.values.elementAt(6),
                              id: parkingMap!.keys.elementAt(6),
                              onPressed: () => setSelectedIndex(
                                  parkingMap!.keys.elementAt(6))),
                          ParkingCard(
                              name: 'A4',
                              parkState: parkingMap!.values.elementAt(3),
                              id: parkingMap!.keys.elementAt(3),
                              onPressed: () => setSelectedIndex(
                                  parkingMap!.keys.elementAt(3))),
                          ParkingCard(
                              name: 'B4',
                              parkState: parkingMap!.values.elementAt(7),
                              id: parkingMap!.keys.elementAt(7),
                              onPressed: () => setSelectedIndex(
                                  parkingMap!.keys.elementAt(7)))
                        ],
                      );
                    }),
              ),
            ),
            mainButton(
                text: 'Reserve',
                onPressed: () {
                  String pid = selectedCardID.toString();
                  String state = 'reserved';
                  ParkingSlots parkSlot = ParkingSlots(pid, state);
                  print(parkSlot.pID);
                  //pp.changeState(parkSlot, ParkState.reserved);
                  selectedCardID = "0";
                }),
          ],
        ),
      ),
    );
  }
}
