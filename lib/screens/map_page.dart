import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parking_system/widgets/main_button.dart';
import 'package:parking_system/widgets/parking_card.dart';
import 'package:parking_system/utils/constants.dart';



class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  @override
  Widget build(BuildContext context) {

    var parkingMap = {
      1: ParkState.empty,
      2: ParkState.occupied,
      3: ParkState.occupied,
      4: ParkState.empty,
      5: ParkState.occupied,
      6: ParkState.empty,
      7: ParkState.occupied,
      8: ParkState.occupied,
    };

    void setSelectedIndex(int id) {
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
                  Text('Tap on an empty spot to reserve',style: kSubTitleTextStyle,),
                ],

              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('images/mapbg.jpg'),
                  fit: BoxFit.fill,
                )),
                child: GridView.count(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 110,
                  crossAxisCount: 2,
                  children: [
                    ParkingCard(
                      name: '1A',
                      parkState:parkingMap[1]!,
                      id: 1,
                      onPressed: () => setSelectedIndex(1),
                    ),
                    ParkingCard(
                        name: '2A',
                        parkState: parkingMap[2]!,
                        id: 2,
                        onPressed: () => setSelectedIndex(2)),
                    ParkingCard(
                        name: '1B',
                        parkState: parkingMap[3]!,
                        id: 3,
                        onPressed: () => setSelectedIndex(3)),
                    ParkingCard(
                        name: '2B',
                        parkState: parkingMap[4]!,
                        id: 4,
                        onPressed: () => setSelectedIndex(4)),
                    ParkingCard(
                        name: '1C',
                        parkState: parkingMap[5]!,
                        id: 5,
                        onPressed: () => setSelectedIndex(5)),
                    ParkingCard(
                        name: '2C',
                        parkState: parkingMap[6]!,
                        id: 6,
                        onPressed: () => setSelectedIndex(6)),
                    ParkingCard(
                        name: '1D',
                        parkState: parkingMap[7]!,
                        id: 7,
                        onPressed: () => setSelectedIndex(7)),
                    ParkingCard(
                        name: '2D',
                        parkState: parkingMap[8]!,
                        id: 8,
                        onPressed: () => setSelectedIndex(8))
                  ],
                ),
              ),
            ),
            mainButton(
                text: 'Reserve',
                onPressed: () {
                  print('switch to reserve screen');
                }),
          ],
        ),
      ),
    );
  }
}
